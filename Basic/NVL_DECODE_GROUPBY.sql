-- NVL NULL�ΰ�� �ٸ�������
-- NVL NULL�ΰ��� NULL�� �ƴѰ�� �Ѵ� ������ �����ϴ�. 

SELECT REGIONID
        ,YEARWEEK
        ,VOLUME -- NVL2(NULL�� �ƴϸ� 0 NULL�̸� 1) �����ϴ°ſ� ���� �޶�����.
        , NVL2(VOLUME, '����', '����') AS VOLUME_NEW
  FROM NVL_CHECK



--- DECODE (~��,~�ΰ�?,Ʈ���,�ƴϸ�)
   
SELECT A.GENDER,
      UPPER(A.GENDER) AS GENDER_NEW,
       DECODE(
            UPPER(A.GENDER),'MALE', 1, 0,
                            'FEMALE',2,0) AS GENDER_NEW
FROM KOPO_CUSTOMERDATA A
        

SELECT * FROM DT_RESULT_FINAL3

---------------------------------- -------------------- NULL�� ������ �� ����ϴ� ��������.
SELECT A.*,
   CASE WHEN A.PREDICTION_QTY = 0 THEN 0
       ELSE ROUND((1 - ABS(A.PREDICTION_QTY - A.REAL_QTY) / A.PREDICTION_QTY)*100,2) END AS ACCURACY
   FROM DT_RESULT_FINAL3 A
   where 1=1
 ---------------------------------- ----------------------------------   
      

-- �׷� ���� �Ҷ� REGIONID
SELECT REGIONID,
        PRODUCT,
        SUM(QTY) AS QTY_SUM
FROM KOPO_CHANNEL_SEASONALITY_NEW 
GROUP BY REGIONID, PRODUCT --�׷�Ű


SELECT REGIONID,
    MIN(YEARWEEK),
    MAX(YEARWEEK)
FROM KOPO_CHANNEL_SEASONALITY_NEW
GROUP BY REGIONID --�׷�Ű


SELECT PRODUCT,
    PRODUCT LIKE '%1%'
FROM KOPO_CHANNEL_SEASONLAITY_NEW
GROUP BY PRODUCT



-- �츮�� A60������ �ǸŵǴ� ��� ��ǰ�� �������� 
    --A01, A02 �������� ���� ��õǾ��� �������� �ȸ��� �ִ����� �˾ƺ���.
        -- ���� �κк��� ���ƿ÷�����. �ϴ� A60���� �ȸ��� ��� ��ǰ ����
    
    
    
 ------------------ GroupBy(�����÷�) �߰���� !! �߿�!!! ----------------------
    

SELECT REGIONID, -- �׷�Ű�� ���� �� ��, ����´�. �ڿ� SUM MIN MAX COUNT ���� �׷� �Լ��� ���´�.
    MIN(YEARWEEK) AS �����, --�����
    MAX(YEARWEEK) AS �����ŷ��� -- ���� ���� �ŷ���
FROM KOPO_CHANNEL_SEASONALITY_NEW
WHERE 1=1
AND REGIONID IN ('A01','A02','A60') -- 2. �����ִ� �� ���� ���� ��ȸ.nd MIN(YEARWEEK) > 2014
AND PRODUCT IN (SELECT DISTINCT PRODUCT 
                FROM KOPO_CHANNEL_SEASONALITY_NEW
                WHERE REGIONID = 'A60') -- 1. A60���� �Ǹ��ϴ� ��� ���δ�Ʈ(�ߺ�����)�� ��ȸ.
GROUP BY REGIONID --�׷�Ű, ������ ��ø� �˾ƺ��� ����(������ �÷�1, ������ �÷�2)
HAVING MIN(YEARWEEK) > 201401 -- �׷� �Լ��� �׷�Ű �ؿ��� HAVING �������� ��� ����.



--- �̵��� ��ü �ߺ����ŵ� �غ���
--- DECODE�ε� �غ���


-- COUNT �Ẹ��. a60�� �����Ͱ� 1872�� �ֲٳ�.
SELECT REGIONID,
    COUNT(*) AS COUNT_VALUE 
FROM KOPO_CHANNEL_SEASONALITY_NEW
GROUP BY REGIONID



SELECT COUNT(*) 
FROM 
(   SELECT DISTINCT REGIONID
    FROM KOPO_CHANNEL_RESULT_NEW
)


----  GROUP BY �����غ��� !! ����
SELECT ����,��ǰ, -- ������ �����ͳ��� �ϳ��� �׷��� ����.
    SUM(�ŷ���) AS �ŷ��ѷ� 
FROM GROUP_TEST
GROUP BY ����, ��ǰ


SELECT * FROM GROUP_TEST

