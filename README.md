# Gerenciamento de Banco de Dados - Faculdade FACINT

Este repositório refere-se ao conteúdo ministrado durante as aulas ao vivo da disciplina de Gerenciamento de Banco de Dados ofertada aos cursos de tecnologia da Faculdade FACINT pelo Professor Esp. Alex Rocha.

Você pode acompanhar as aulas através do canal faculdade clicando nos links a seguir:

**Aula de 05/05/2025**:


[![Gerenciamento de Banco de Dados - ao vivo -  05/05/2025 - Alex Rocha](https://img.youtube.com/vi/JPBxcMvAqEo/0.jpg)](https://www.youtube.com/watch?v=JPBxcMvAqEo)

**Aula de 12/05/2025**:


[![Projeto e Modelagem de Dados - ao vivo - 12/05/2025 - Alex Rocha](https://img.youtube.com/vi/3OGisLwIZz8/0.jpg)](https://www.youtube.com/watch?v=3OGisLwIZz8)

**Aula de 19/05/2025**:

[![Projeto e Modelagem de Dados - ao vivo - 19/05/2025 - Alex Rocha](https://img.youtube.com/vi/9vTu4MPtwIs/0.jpg)](https://www.youtube.com/watch?v=9vTu4MPtwIs)

**Aula de 26/05/2025**:

[![Projeto e Modelagem de Dados - ao vivo - 26/05/2025 - Alex Rocha](https://img.youtube.com/vi/PDYSuTREFs8/0.jpg)](https://www.youtube.com/watch?v=PDYSuTREFs8)

## Conteúdo Ministrado:

Os conteúdos ministrados durante as aulas são referentes à DDL, DML e DQL, nesta ordem:

**Em 12/05/2025:** [Database db_hospital](./mysql/db_hospital_2025-05-14.sql)

```sql
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
```

**Em 19/05/2025:** [Database db_hospital](./mysql/db_hospital_2025-05-19.sql)

```sql
USE db_hospital;

--  INCLUSÃO DE DADOS EM medico
INSERT INTO medico(nome, crm, telefone)
VALUES ('EDGAR CARRILLO', '123456/PR', '(44) 4002-8922');

INSERT INTO medico(nome, crm, telefone)
VALUES ('EDGAR CARRILLO', '123456/PR', '(44) 4002-8922');

INSERT INTO medico(nome, crm, telefone)
VALUES ('VINICIUS DA SILVA OLIVEIRA', '987654/RJ', '(21) 1818-1111'),
       ('RICARDO CORDEIRO', '654321/RJ', '(21) 1818-1515');
       
INSERT INTO medico(nome, crm, telefone)
VALUES ('WINSTON MELO DE ALMEIRA JÚNIOR', '321654/MA', '(98) 1212-1515');

-- ATUALIZAÇÃO DE DADOS EM MÉDICO
UPDATE medico SET nome = 'RICARDO DE SOUZA DA SILVA CORDEIRO' WHERE id = 3;

UPDATE medico SET nome = LOWER(nome);

UPDATE medico SET nome = UPPER(nome);


-- INCLUSÃO DE DADOS EM PACIENTE
INSERT INTO paciente(telefone, nome, cpf)
VALUES ('(44) 3268-6800', 'JOÃO DA SILVA', '99999999991'),
       ('(85) 99732-6650', 'MARIA DAS DORES', '12345678900'),
	   ('', 'HELSON FERREIRA', '88888888888'),
       ('(68) 55555-5555', 'RITA CAGIANO', '45678912322');
    
-- EXCLUSÃO DE DADOS EM PACIENTE	
DELETE FROM paciente WHERE id = 18;

INSERT INTO paciente(nome, cpf, telefone)
VALUES ('MARIA IZABEL', '11122233300', '(11) 2121-1212');


-- ALTERAÇÃO DA TABELA consulta PARA INCLUSÃO DO CAMPO DATETIME
ALTER TABLE consulta ADD data DATETIME NOT NULL DEFAULT NOW();


-- INCLUSÃO DE CONSULTAS PARA CADA MÉDICO/PACIENTE

INSERT INTO consulta(medicoid, pacienteid, data)
SELECT medico.id, 20, now()
FROM medico;
```

**Em 26/05/2025:** [Database db_hospital](./mysql/db_hospital_2025-05-26.sql)

```sql
-- PRIMEIRO SELECT: OLÁ MUNDO!

SELECT "olá, mundo!" as "boas vindas";

-- SELECT COM DIAS DA SEMANA

SELECT "DOMINGO", "SEGUNDA", "TERÇA", "QUARTA", "QUINTA", "SEXTA", "SABÁDO";

-- SELECT EM UMA TABELA COM FILTRO

SELECT *
  FROM medico
 WHERE crm LIKE '%RJ';
 
-- SELECT COM MAIS DE UMA CLÁUSULA DE FILTRO

SELECT nome, cpf, telefone
  FROM paciente
 WHERE nome LIKE '_A%'
       AND id > 0;
	   

-- APRESENTAR O NOME DOS MÉDICOS E O NOME DOS PACIENTES
-- EM SEUS DEVIDOS HORÁRIOS PARA AGENDA MÉDICA


-- SOLUÇÃO 1: PRODUTO CARTESIANO COM RESTRIÇÃO DE FILTRO
SELECT paciente.nome as "nome paciente", medico.nome as "nome médico", consulta.data
  FROM consulta, medico, paciente
 WHERE consulta.medicoid = medico.id 
       AND consulta.pacienteid = paciente.id;
      

-- SOLUÇÃO 2: JUNÇÕES INTERNAS	  
SELECT paciente.nome as "nome paciente", 
	    medico.nome as "nome médico", 
        consulta.data
  FROM consulta INNER JOIN medico ON consulta.medicoid = medico.id
  INNER JOIN paciente ON consulta.pacienteid = paciente.id;
  
  
-- CRIAÇÃO DE UMA VIEW
CREATE VIEW view_agenda AS   
SELECT medico.nome as "nome médico",
        paciente.nome as "paciente", 
        consulta.data
FROM medico
LEFT JOIN consulta ON medico.id = consulta.medicoid
LEFT JOIN paciente ON paciente.id = consulta.pacienteid
UNION
SELECT medico.nome as "nome médico",
        paciente.nome as "paciente", 
        consulta.data
FROM medico
RIGHT JOIN consulta ON medico.id = consulta.medicoid
RIGHT JOIN paciente ON paciente.id = consulta.pacienteid;


-- OBTENÇÃO DOS DADOS DE UMA VIEW
SELECT * FROM view_agenda;
```
---
Desenvolvido por Alex Rocha