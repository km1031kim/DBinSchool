-- 우리는 A60지역에 판매되는 모든 상품을 기준으로 
    --A01, A02 지역에서 언제 출시되었고 언제까지 팔리고 있는지를 알아본다.
        -- 작은 부분부터 말아올려야함. 일단 A60에서 팔리는 모든 상품 기준
            -- 그리고 프로덕트 오름차순 시 생기는 오류를 방지하자.
SELECT B.PRODUCTNUMBER,
       B.MINWEEK,
       B.MAXWEEK
FROM
(
SELECT PRODUCT,
       CONCAT(SUBSTR(PRODUCT,0,7),LPAD(SUBSTR(PRODUCT,8,9),2,0)) AS PRODUCTNUMBER, -- 분리 후 다시 결합.
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










