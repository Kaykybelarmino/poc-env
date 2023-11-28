
	DROP DATABASE IF EXISTS medconnect;
	CREATE DATABASE IF NOT EXISTS medconnect;
	USE medconnect;

	-- Crie a tabela Hospital
	CREATE TABLE IF NOT EXISTS Hospital (
		idHospital INT PRIMARY KEY AUTO_INCREMENT,
		nomeFantasia VARCHAR(45) NOT NULL,
		CNPJ CHAR(14) NOT NULL,
		razaoSocial VARCHAR(45) NOT NULL,
		sigla VARCHAR(45) NOT NULL,
		responsavelLegal VARCHAR(45) NOT NULL,
		fkHospitalSede INT,
		CONSTRAINT fkHospitalSede FOREIGN KEY (fkHospitalSede) REFERENCES Hospital (idHospital)
	);

	-- Inserir dados na tabela Hospital
	INSERT INTO Hospital (nomeFantasia, CNPJ, razaoSocial, sigla, responsavelLegal, fkHospitalSede) 
	VALUES 
		('Hospital ABC', '12345678901234', 'ABC Ltda', 'HABC', 'João da Silva', NULL),
		('Hospital Einstein', '12325678901234', 'Einstein Ltda', 'HEIN', 'Maria Silva', NULL);

	-- Crie a tabela EscalonamentoUsuario
	CREATE TABLE IF NOT EXISTS EscalonamentoUsuario (
		idEscalonamento INT PRIMARY KEY AUTO_INCREMENT,
		cargo VARCHAR(45) NOT NULL,
		prioridade INT NOT NULL
	);

	-- Inserir dados na tabela EscalonamentoUsuario
	INSERT INTO EscalonamentoUsuario (cargo, prioridade) 
	VALUES 
		('Atendente', 1),
		('Engenheiro De Noc', 2),
		('Admin', 3);

	-- Crie a tabela Usuario
	CREATE TABLE IF NOT EXISTS Usuario (
		idUsuario INT AUTO_INCREMENT,
		nome VARCHAR(45) NOT NULL,
		email VARCHAR(45) NOT NULL,
		CPF VARCHAR(15) NOT NULL,
		telefone VARCHAR(15) NOT NULL,
		senha VARCHAR(45) NOT NULL,
		fkHospital INT,
		fkEscalonamento INT,
		PRIMARY KEY (idUsuario, fkHospital),
		CONSTRAINT fkHospital FOREIGN KEY (fkHospital) REFERENCES Hospital (idHospital),
		CONSTRAINT fkEscalonamento FOREIGN KEY (fkEscalonamento) REFERENCES EscalonamentoUsuario (idEscalonamento)
	);

	-- Inserir dados na tabela Usuario
	INSERT INTO Usuario (nome, email, CPF, telefone, senha, fkHospital, fkEscalonamento) 
	VALUES 
		('Kayky', 'kayky@abc.com', '12345678901', '987654321', '123456', 1, 1),
		('Gabriel', 'gabriel@email.com', '12345678901', '987654321', '123456', 1, 2),
		('Maria Souza', 'maria@example.com', '12345678901', '987654321', 'senha123', 1, 3);

	-- Crie a tabela statusRobo
	CREATE TABLE IF NOT EXISTS statusRobo (
		idStatus INT PRIMARY KEY AUTO_INCREMENT,
		nome VARCHAR(45) NOT NULL
	);

	-- Inserir dados na tabela statusRobo
	INSERT INTO statusRobo (nome) 
	VALUES ('Ativo');

	-- Crie a tabela RoboCirurgiao
	CREATE TABLE IF NOT EXISTS RoboCirurgiao (
		idRobo INT PRIMARY KEY AUTO_INCREMENT,
		modelo VARCHAR(45) NOT NULL,
		fabricacao VARCHAR(45) NOT NULL,
		idProcess VARCHAR(45),
		telaAtual varchar(40),
		fkStatus INT,
		fkHospital INT,
		CONSTRAINT fkStatus FOREIGN KEY (fkStatus) REFERENCES statusRobo (idStatus),
		CONSTRAINT fkHospitalRobo FOREIGN KEY (fkHospital) REFERENCES Hospital (idHospital)
	);
    


	-- Inserir dados na tabela RoboCirurgiao
	INSERT INTO RoboCirurgiao (modelo, fabricacao, fkStatus, fkHospital, idProcess) 
	VALUES ('Modelo A', '2023-09-12', 1, 1, 'B2532B6');

	-- Crie a tabela Metrica
	CREATE TABLE IF NOT EXISTS Metrica (
		idMetrica INT PRIMARY KEY AUTO_INCREMENT,
		alerta DOUBLE,
		urgente DOUBLE,
		critico DOUBLE,
		tipo_dado VARCHAR(50)
	);

	INSERT INTO Metrica (idMetrica, alerta, urgente, critico, tipo_dado)
    VALUES
    (1, 60, 70, 80, 'Porcentagem da CPU'),
    (3, 264, 275, 300, 'Processos da CPU'),
    (11, 0.4, 0.3, 0.2, 'Velocidade da CPU');

    -- Inserir Métricas de RAM
    INSERT INTO Metrica (idMetrica, alerta, urgente, critico, tipo_dado)
    VALUES
    (5, 90.1, 93, 95, 'Porcentagem da Memoria'),
    (6, 17, 18, 20, 'Porcentagem da Memoria Swap');

    -- Inserir Métricas de Disco Rígido
    INSERT INTO Metrica (idMetrica, alerta, urgente, critico, tipo_dado)
    VALUES
    (8, 70, 80, 90, 'Porcentagem do Disco');

    -- Inserir Métricas de Rede
    INSERT INTO Metrica (idMetrica, alerta, urgente, critico, tipo_dado)
    VALUES
    (10, 40, 60, 80, 'Latencia de Rede');

	-- Crie a tabela categoriaComponente
	CREATE TABLE IF NOT EXISTS categoriaComponente (
		idCategoriaComponente INT PRIMARY KEY AUTO_INCREMENT,
		nome VARCHAR(45) NOT NULL
	);

	-- Inserir dados na tabela categoriaComponente
	INSERT INTO categoriaComponente (idCategoriaComponente, nome) VALUES
		(1, 'CPU'),
		(2, 'Memória RAM'),
		(3, 'Disco'),
		(4, 'Rede'),
        (5, 'Processos');

	-- Crie a tabela componentes
	CREATE TABLE IF NOT EXISTS componentes (
		idComponentes INT PRIMARY KEY AUTO_INCREMENT,
		nome VARCHAR(45) NOT NULL,
		unidade VARCHAR(10),
		descricaoAdd VARCHAR(45),
		fkCategoriaComponente INT,
		fkMetrica INT,
		CONSTRAINT fkCategoriaComponente FOREIGN KEY (fkCategoriaComponente) REFERENCES categoriaComponente (idCategoriaComponente),
		CONSTRAINT frkMetrica FOREIGN KEY (fkMetrica) REFERENCES Metrica (idMetrica)
	);
    		

	INSERT INTO componentes (idComponentes,nome, unidade, fkCategoriaComponente, fkMetrica) 
	VALUES (1,'Porcentagem da CPU', '%', 1, 1),
	(2,'Velocidade da CPU', 'GHz', 1, 11),
	(3,'Tempo no sistema da CPU', 's', 1, null),
	(4,'Processos da CPU', null, 1, 3);

-- Inserir Memória RAM
	INSERT INTO componentes (idComponentes,nome, unidade, fkCategoriaComponente, fkMetrica) 
	VALUES (5,'Porcentagem da Memoria', '%', 2, 5),
	(6,'Total da Memoria', 'GB', 2, null),
	(7,'Uso da Memoria', 'GB', 2, null),
	(8,'Porcentagem da Memoria Swap', '%',2,6),
	(9,'Uso da Memoria Swap', 'GB', 2, null);

-- Inserir Disco
	INSERT INTO componentes (idComponentes, nome, unidade, fkCategoriaComponente, fkMetrica) 
	VALUES (10,'Porcentagem do Disco', '%', 3, 8),
	(11,'Total do Disco', 'GB', 3, null),
	(12,'Uso do Disco', 'GB', 3, null),
	(13,'Tempo de Leitura do Disco', 's', 3, null),
	(14,'Tempo de Escrita do Disco', 's', 3, null);

-- Inserir Rede
	INSERT INTO componentes (idComponentes, nome, descricaoAdd, fkCategoriaComponente, fkMetrica) 
	VALUES (15,'Status da Rede', 'Conexao da Rede', 4, null),
	(16,'Latencia de Rede', 'Latencia em MS', 4, 10),
	(17,'Bytes enviados','Bytes enviados da Rede', 4, null),
	(18,'Bytes recebidos','Bytes recebidos da Rede', 4, null);

	INSERT INTO componentes (idComponentes, nome, descricaoAdd, fkCategoriaComponente, fkMetrica) 
	VALUES 
	(19,'Total de processos', 'processos', 1, null),
	(20,'Total de Threads', 'threads', 1, null),
	(21,'Quantidade de processos', 'Quantidades de processos em execução', 5, null);


	CREATE TABLE dispositivos_usb (
		id INT AUTO_INCREMENT PRIMARY KEY,
		nome VARCHAR(255),
		dataHora DATETIME,
		id_produto VARCHAR(10),
		fornecedor VARCHAR(255),
		conectado BOOLEAN,
		fkRoboUsb int , 
	constraint fkRoboUsb foreign key (fkRoboUsb) references  RoboCirurgiao(idRobo)
		);

	-- Crie a tabela Registros
	CREATE TABLE IF NOT EXISTS Registros (
		idRegistro INT AUTO_INCREMENT,
		fkRoboRegistro INT,
		HorarioDado DATETIME NOT NULL,
		dado DOUBLE NOT NULL,
		fkComponente INT,
		PRIMARY KEY (idRegistro, fkRoboRegistro),
		CONSTRAINT fkRoboRegistro FOREIGN KEY (fkRoboRegistro) REFERENCES RoboCirurgiao (idRobo),
		CONSTRAINT fkComponente FOREIGN KEY (fkComponente) REFERENCES componentes (idComponentes)
	);
    

	-- Crie a tabela Alerta
	CREATE TABLE IF NOT EXISTS Alerta (
		idAlerta INT PRIMARY KEY AUTO_INCREMENT,
		tipo_alerta VARCHAR(15),
		fkRegistro INT,
		fkRobo INT,
		dtHora DATETIME,
		nome_componente VARCHAR(45),
		dado DOUBLE
	);

	-- Crie a tabela quantidadeAlerta
	CREATE TABLE IF NOT EXISTS quantidadeAlerta (
		idQuantidadeAlerta INT PRIMARY KEY AUTO_INCREMENT,
		tipo_alerta VARCHAR(10),
		dtHora DATETIME
	);

	
	-- Criar a tabela processos
	CREATE TABLE IF NOT EXISTS Processos (
	    idProcesso INT PRIMARY KEY AUTO_INCREMENT,
	    pid INT,
	    nome VARCHAR(100),
	    processo_status VARCHAR(20),
	    momento_inicio DATETIME,
	    data_hora_captura DATETIME,
	    fkRobo INT,
			CONSTRAINT fkRoboProcesso FOREIGN KEY (fkRobo) REFERENCES RoboCirurgiao (idRobo)
	);

	