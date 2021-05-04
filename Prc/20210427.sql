SELECT * FROM KOPO_CHANNEL_RESULT


--  A01������ ���� ���� �� �ŷ�ó�� TOP3��ǰ
SELECT AP2ID,
       PRODUCT,
       SUM(QTY)
FROM
KOPO_CHANNEL_RESULT
WHERE ACCOUNTID = 5004878 -- ���� ���� �Ǹ��� ACCOUNTID
GROUP BY AP2ID,PRODUCT
ORDER BY SUM(QTY) DESC



SELECT AP2ID, ACCOUNTID, PRODUCTGROUP, SUM(QTY)
FROM KOPO_CHANNEL_RESULT
WHERE ACCOUNTID IN(
    SELECT ACCOUNTID FROM (
    SELECT ACCOUNTID, SUM(QTY) AS SUM_QTY
    FROM KOPO_CHANNEL_RESULT
    WHERE 1=1
    AND AP2ID = 'A01'
    GROUP BY ACCOUNTID
    HAVING SUM(QTY) IN (
    SELECT MAX(SUM_QTY)
    FROM(
       ---? A01������ ���� ���� �Ǹ��� �ŷ�ó�� TOP3 ��ǰ(PRODUCTGROUP)�� ��������?
        SELECT AP2ID, ACCOUNTID, SUM(QTY) AS SUM_QTY
        FROM KOPO_CHANNEL_RESULT
        WHERE 1=1
        AND AP2ID = 'A01'
        GROUP BY AP2ID, ACCOUNTID
        ORDER BY SUM(QTY)DESC
    ) )
    ORDER BY SUM(QTY)DESC )
)
GROUP BY AP2ID, ACCOUNTID, PRODUCTGROUP




SELECT ACCOUNTID
FROM(
    SELECT A.*,
            ROW_NUMBER() OVER(ORDER BY SUM_QTY DESC) AS RANK
    FROM(
        SELECT AP2ID, ACCOUNTID, SUM(QTY) AS SUM_QTY
            FROM KOPO_CHANNEL_RESULT
            WHERE 1=1
            AND AP2ID = 'A01'
            GROUP BY AP2ID, ACCOUNTID
            ORDER BY SUM(QTY)DESC
    ) A
)B
WHERE 1=1
AND RANK BETWEEN 1 AND 3











---- ��������(���� �ȿ� ����)
---- SELECT * FROM ���̺�� ->
------ SELECT A.* FROM (����Ʈ ����)A


    
    
    
    
    
    
    
SELECT B.REGIONID, B.PRODUCT, B.YEARWEEK, B.QTY FROM
(
    SELECT A.REGIONID,
    A.PRODUCT,
    A.YEARWEEK,
    SUBSTR(A.YEARWEEK,0,4) AS YEAR,
    SUBSTR(A.YEARWEEK,5,6) AS WEEK,
    A.QTY
    FROM KOPO_CHANNEL_SEASONALITY_NEW A
    WHERE 1=1
)B
WHERE B.WEEK != '53'

EDIT NO_EVENT_REGIONID_JG



-- STEP1: ����/�ŷ�ó���� �հ�(�Ǹŷ�)�� ���Ѵ�.
-- STEP2: ���� ���� �Ǹ��� �ŷ�ó�� ã�´�. (��, A01 ������)
-- STEP3: ����/�ŷ�/��ǰ�� �հ�(�Ǹŷ�)�� ��ȸ�ϸ鼭 �ŷ�ó��
            -- ���� ���� �Ǹ��� �ŷ�ó�� �����.
            

        
 

