-- CRIAÇÃO DO BANCO DE DADOS DB_HOSPITAL

CREATE DATABASE IF NOT EXISTS db_hospital;

USE db_hospital;

/*
 * TRÊS ENTIDADES:
 *		- MÉDICO(id, nome, crm*, telefone)
 *		- PACIENTE(id, nome, cpf*, telefone)
 *		- CONSULTA(id, pacienteid, medicoid)
*/

-- DECLARAÇÃO DA TABELA médico

CREATE TABLE IF NOT EXISTS medico(
	id INT AUTO_INCREMENT,
	nome VARCHAR(255) NOT NULL,
	crm VARCHAR(9),
	telefone VARCHAR(16) NOT NULL DEFAULT '(XX) XXXXX-XXXX',
	
	CONSTRAINT pk_medico PRIMARY KEY(id),
	CONSTRAINT uk_medico_crm UNIQUE(crm)
);


-- DECLARAÇÃO DA TABELA paciente

CREATE TABLE IF NOT EXISTS paciente(
	id INT AUTO_INCREMENT,
	nome VARCHAR(255) NOT NULL,
	cpf CHAR(11),
	telefone VARCHAR(16) NOT NULL DEFAULT '(XX) XXXXX-XXXX',
	
	CONSTRAINT pk_paciente PRIMARY KEY(id),
	CONSTRAINT uk_paciente_crm UNIQUE(cpf)
);

-- DECLARAÇÃO DA TABELA consulta

CREATE TABLE IF NOT EXISTS consulta(
	id INT AUTO_INCREMENT,
	pacienteid INT NOT NULL,
	medicoid INT NOT NULL,
	
	CONSTRAINT pk_consulta PRIMARY KEY(id),
	CONSTRAINT fk_consulta_pacienteid FOREIGN KEY(pacienteid) REFERENCES paciente(id),
	CONSTRAINT fk_consulta_medicoid FOREIGN KEY(medicoid) REFERENCES medico(id)
);