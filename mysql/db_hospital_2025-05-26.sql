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
	