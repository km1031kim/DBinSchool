
------------------------ CONCAT, IN, LIKE, NOT IN ���� ------------------------------
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
    