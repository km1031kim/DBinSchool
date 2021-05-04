-- DT_RESULT_FINAL3 ���̺���
--- ��Ȯ���� �����ϼ���
---- ��, �������� 0�ΰ�� ��Ȯ���� 0
------ ��Ȯ�� = 1- ABS(������-������)/������


SELECT * FROM DT_RESULT_FINAL3


--DECODE�� ����ؼ� Ǯ���

--- DECODE(-��,-�̸�,�̰Ű�,�ƴϸ��̰�)

---- 1. PREDICTION_QTY�� 0�̸� 1�� �ٲٰ�, �� ���̺� ����
----- 2. �� ���̺��� ���� ��Ȯ�� ���ϱ�.

--DECODE�� ����ؼ� Ǯ���
SELECT C.*,
    DECODE(NONEZERO,1,0,ROUND((PROTOTYPE*100),2)) AS ACCURACY
FROM
(
SELECT B.*,
    1 - ABS(B.NONEZERO - B.REAL_QTY) / NONEZERO AS PROTOTYPE
FROM    
(SELECT A.*,
    DECODE(A.PREDICTION_QTY,0,1,A.PREDICTION_QTY) AS NONEZERO
    FROM DT_RESULT_FINAL3 A
)B   
)C    





------------------------ CONCAT, IN, LIKE NOT IN ���� ------------------------------
SELECT * FROM DT_RESULT_FINAL3


-- LIKE
--- WHERE �÷��� LIKE '%���Ե� ����%' // ������ ��� 224�� �����ϴ����� ���� ������.
SELECT * FROM DT_RESULT_FINAL3 WHERE PREDICTION_QTY LIKE '224%'


-- IN
--- 2100�� �͸� ����.
SELECT * FROM DT_RESULT_FINAL3
WHERE REAL_QTY IN '2100'

-- NOTIN
--- 2100�� �ƴ� �͸� ����.
SELECT * FROM DT_RESULT_FINAL3
WHERE REAL_QTY NOT IN '2100'


-- �÷� ��ġ�� 

SELECT A.*,
    PRODUCT||'_'||ITEM AS PROITEM
    FROM DT_RESULT_FINAL3 A
    

-- CONCAT �÷���ġ��
---- PRODUCT�� ITEM ��, ���� �����ڰ� �� �� �ִ�!! �ű�!
SELECT A.*,
    CONCAT(PRODUCT||'_'||ITEM, '_'||YEARWEEK) AS PROITEM
    FROM DT_RESULT_FINAL3 A
    
   




    