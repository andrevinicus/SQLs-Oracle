-- Movimentos de materiais na conta paciente    
SELECT
c.DT_MOVIMENTO_ESTOQUE,
c.nr_movimento_estoque,
d.DS_CONVENIO, 
e.DS_MATERIAL DESCRICAO,
e.CD_MATERIAL,
d.NM_PACIENTE PACIENTE,
a.QT_MATERIAL MOVIMENTADO, 
b.QT_ESTOQUE ESTOQUE,
a.CD_UNIDADE_MEDIDA_CONSUMO
FROM CONTA_PACIENTE_MATERIAL_V2 a
INNER JOIN SALDO_ESTOQUE B ON b.CD_MATERIAL = a.CD_MATERIAL 
INNER JOIN MOVIMENTO_ESTOQUE_V c ON a.CD_MATERIAL = c.CD_MATERIAL 
INNER JOIN ATENDIMENTO_PACIENTE_REL_V d ON c.NR_ATENDIMENTO = d.NR_ATENDIMENTO
INNER JOIN MATERIAL e ON e.CD_MATERIAL = c.CD_MATERIAL 
WHERE c.DT_MOVIMENTO_ESTOQUE BETWEEN :dt_inicial AND :dt_final + 86399 / 86400
AND (c.nr_movimento_estoque  = :nr_movimento_estoque OR :nr_movimento_estoque = 0)
AND (c.cd_material = :cd_material or :cd_material = 0)
GROUP BY b.QT_ESTOQUE, c.DT_MOVIMENTO_ESTOQUE, 
         e.DS_MATERIAL, e.CD_MATERIAL, d.NM_PACIENTE,
         a.CD_UNIDADE_MEDIDA_CONSUMO, a.QT_MATERIAL, 
         d.DS_CONVENIO, c.nr_movimento_estoque, c.DT_MOVIMENTO_ESTOQUE   
ORDER BY 
         c.nr_movimento_estoque DESC,
         c.DT_MOVIMENTO_ESTOQUE DESC;
         
         

         
         
         
         
         
         


        
        
        
        
        
        
        
-- Movimentos de materiais na conta paciente            
SELECT
c.DT_MOVIMENTO_ESTOQUE,
c.NR_ATENDIMENTO,
d.DS_CONVENIO, 
e.DS_MATERIAL DESCRICAO,
c.CD_MATERIAL,
d.NM_PACIENTE PACIENTE,
c.QT_MOVIMENTO MOVIMENTADO, 
c.QT_ESTOQUE ESTOQUE,
a.CD_UNIDADE_MEDIDA_CONSUMO,
substr(obter_valor_dominio(20,c.cd_acao),1,80) ds_acao,	
substr(obter_descricao_padrao('OPERACAO_ESTOQUE','DS_OPERACAO',
					CD_OPERACAO_ESTOQUE),1,80) ds_desc
FROM CONTA_PACIENTE_MATERIAL_V2 a
INNER JOIN MOVIMENTO_ESTOQUE_V c ON c.CD_MATERIAL = a.CD_MATERIAL 
INNER JOIN ATENDIMENTO_PACIENTE_REL_V d ON c.NR_ATENDIMENTO = d.NR_ATENDIMENTO
INNER JOIN MATERIAL e ON e.CD_MATERIAL = c.CD_MATERIAL 
WHERE c.DT_MOVIMENTO_ESTOQUE BETWEEN :dt_inicial AND :dt_final + 86399 / 86400
AND (c.NR_ATENDIMENTO  = :nr_atendimento OR :nr_atendimento = 0)
AND (c.cd_material = :cd_material or :cd_material = 0)
GROUP BY b.QT_ESTOQUE, c.DT_MOVIMENTO_ESTOQUE, 
         e.DS_MATERIAL, c.CD_MATERIAL, d.NM_PACIENTE,
         a.CD_UNIDADE_MEDIDA_CONSUMO, c.QT_MOVIMENTO, 
         d.DS_CONVENIO, d.NR_ATENDIMENTO, c.DT_MOVIMENTO_ESTOQUE,
         ds_desc, ds_acao
ORDER BY c.DT_MOVIMENTO_ESTOQUE DESC,
         c.NR_ATENDIMENTO DESC,
         c.CD_MATERIAL;
        
        

-- Movimentos de materiais na conta paciente        
SELECT DISTINCT 
a.DT_MOVIMENTO_ESTOQUE,
a.NR_DOCUMENTO,
a.CD_MATERIAL,
b.DS_MATERIAL,
a.QT_MOVIMENTO, 
e.NM_PACIENTE,
substr(obter_descricao_padrao('OPERACAO_ESTOQUE','DS_OPERACAO',
					CD_OPERACAO_ESTOQUE),1,80) ds_acao,
obter_Saldo_Disp_estoque(a.cd_estabelecimento, a.cd_material, a.cd_local_estoque,a.dt_mesano_referencia) qt_disponivel
FROM MOVIMENTO_ESTOQUE_V a 
INNER JOIN MATERIAL_V b ON a.CD_MATERIAL = b.CD_MATERIAL
INNER JOIN CONTA_PACIENTE_MATERIAL_V2 c ON a.CD_MATERIAL = c.CD_MATERIAL 
INNER JOIN MATERIAL_ATEND_PACIENTE d ON a.CD_MATERIAL = d.CD_MATERIAL 
INNER JOIN ATENDIMENTO_PACIENTE_REL_V e ON d.NR_ATENDIMENTO = e.NR_ATENDIMENTO
WHERE  a.DT_MOVIMENTO_ESTOQUE BETWEEN :dt_inicial AND fim_dia(:dt_final)
	AND (a.NR_DOCUMENTO  = :nr_documento OR :nr_documento = 0)
	AND (a.cd_material = :cd_material or :cd_material = 0)
@SQL_WHERE	
GROUP BY a.DT_MOVIMENTO_ESTOQUE,
         a.NR_DOCUMENTO,
         a.CD_MATERIAL,
         b.DS_MATERIAL,
         a.QT_MOVIMENTO,
         e.NM_PACIENTE, 
         b.CD_MATERIAL,
         a.CD_ESTABELECIMENTO,
         a.CD_LOCAL_ESTOQUE,
         a.DT_MESANO_REFERENCIA,
         a.CD_OPERACAO_ESTOQUE,
         a.CD_ACAO         
ORDER BY a.DT_MOVIMENTO_ESTOQUE DESC,
         a.NR_DOCUMENTO DESC
         
                 
         
        
SELECT DISTINCT 
CD_OPERACAO_ESTOQUE CD,d
DS_OPERACAO  DS
FROM OPERACAO_ESTOQUE        

SELECT DISTINCT
CD_OPERACAO_ESTOQUE cd_operacao,
DS_OPERACAO  ds_operacao
FROM OPERACAO_ESTOQUE
WHERE 

--viwes e campos que se interligas entre elas        
SELECT *
FROM MATERIAL_ATEND_PACIENTE map2  WHERE rownum <=10 --NR_ATENDIMENTO 

SELECT *
FROM CONTA_PACIENTE_MATERIAL_V2 WHERE rownum <=10 --NR_INTERNO_CONTA 

SELECT *
FROM ATENDIMENTO_PACIENTE_REL_V mv WHERE rownum <=10 --CD_PESSOA_FISICA --NR_ATENDIMENTO 

SELECT *
FROM PESSOA_FISICA WHERE rownum <=10






--Saldo por filtro de data
SELECT *
FROM SALDO_ESTOQUE WHERE DT_ATUALIZACAO between 
TO_DATE('27/03/2023','DD/MM/YYYY') and 
TO_DATE('27/03/2023 23:59:59','DD/MM/YYYY HH24:mi:ss')

obter_Saldo_Disp_estoque(a.cd_estabelecimento, a.cd_material, a.cd_local_estoque,a.dt_mesano_referencia) qt_disponivel,