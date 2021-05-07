-- �츮�� A60������ �ǸŵǴ� ��� ��ǰ�� �������� 
    --A01, A02 �������� ���� ��õǾ��� �������� �ȸ��� �ִ����� �˾ƺ���.
        -- ���� �κк��� ���ƿ÷�����. �ϴ� A60���� �ȸ��� ��� ��ǰ ����
            -- �׸��� ���δ�Ʈ �������� �� ����� ������ ��������.
SELECT B.PRODUCTNUMBER,
       B.MINWEEK,
       B.MAXWEEK
FROM
(
SELECT PRODUCT,
       CONCAT(SUBSTR(PRODUCT,0,7),LPAD(SUBSTR(PRODUCT,8,9),2,0)) AS PRODUCTNUMBER, -- �и� �� �ٽ� ����.
       MIN(YEARWEEK) AS MINWEEK,
       MAX(YEARWEEK) AS MAXWEEK
FROM
KOPO_CHANNEL_SEASONALITY_NEW
WHERE 1=1
AND REGIONID IN ('A01','A02')
AND PRODUCT IN (SELECT DISTINCT PRODUCT FROM KOPO_CHANNEL_SEASONALITY_NEW WHERE REGIONID = 'A60')
GROUP BY PRODUCT
ORDER BY PRODUCTNUMBER ASC
)B










