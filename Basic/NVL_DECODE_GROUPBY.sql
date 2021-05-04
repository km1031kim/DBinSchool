-- NVL NULL인경우 다른값으로
-- NVL NULL인경우와 NULL이 아닌경우 둘다 변경이 가능하다. 

SELECT REGIONID
        ,YEARWEEK
        ,VOLUME -- NVL2(NULL이 아니면 0 NULL이면 1) 세팅하는거에 따라 달라진다.
        , NVL2(VOLUME, '변경', '가능') AS VOLUME_NEW
  FROM NVL_CHECK



--- DECODE (~가,~인가?,트루면,아니면)
   
SELECT A.GENDER,
      UPPER(A.GENDER) AS GENDER_NEW,
       DECODE(
            UPPER(A.GENDER),'MALE', 1, 0,
                            'FEMALE',2,0) AS GENDER_NEW
FROM KOPO_CUSTOMERDATA A
        

SELECT * FROM DT_RESULT_FINAL3

---------------------------------- -------------------- NULL값 제거한 후 계산하는 연습문제.
SELECT A.*,
   CASE WHEN A.PREDICTION_QTY = 0 THEN 0
       ELSE ROUND((1 - ABS(A.PREDICTION_QTY - A.REAL_QTY) / A.PREDICTION_QTY)*100,2) END AS ACCURACY
   FROM DT_RESULT_FINAL3 A
   where 1=1
 ---------------------------------- ----------------------------------   
      

-- 그룹 바이 할때 REGIONID
SELECT REGIONID,
        PRODUCT,
        SUM(QTY) AS QTY_SUM
FROM KOPO_CHANNEL_SEASONALITY_NEW 
GROUP BY REGIONID, PRODUCT --그룹키


SELECT REGIONID,
    MIN(YEARWEEK),
    MAX(YEARWEEK)
FROM KOPO_CHANNEL_SEASONALITY_NEW
GROUP BY REGIONID --그룹키


SELECT PRODUCT,
    PRODUCT LIKE '%1%'
FROM KOPO_CHANNEL_SEASONLAITY_NEW
GROUP BY PRODUCT



-- 우리는 A60지역에 판매되는 모든 상품을 기준으로 
    --A01, A02 지역에서 언제 출시되었고 언제까지 팔리고 있는지를 알아본다.
        -- 작은 부분부터 말아올려야함. 일단 A60에서 팔리는 모든 상품 기준
    
    
    
 ------------------ GroupBy(집계컬럼) 중간고사 !! 중요!!! ----------------------
    

SELECT REGIONID, -- 그룹키와 같이 한 쌍, 따라온다. 뒤에 SUM MIN MAX COUNT 등의 그룹 함수가 들어온다.
    MIN(YEARWEEK) AS 출시일, --출시일
    MAX(YEARWEEK) AS 최종거래일 -- 현재 최종 거래일
FROM KOPO_CHANNEL_SEASONALITY_NEW
WHERE 1=1
AND REGIONID IN ('A01','A02','A60') -- 2. 관심있는 세 지역 같이 조회.nd MIN(YEARWEEK) > 2014
AND PRODUCT IN (SELECT DISTINCT PRODUCT 
                FROM KOPO_CHANNEL_SEASONALITY_NEW
                WHERE REGIONID = 'A60') -- 1. A60에서 판매하는 모든 프로덕트(중복제외)만 조회.
GROUP BY REGIONID --그룹키, 지역별 출시를 알아보기 위해(집계대상 컬럼1, 집계대상 컬럼2)
HAVING MIN(YEARWEEK) > 201401 -- 그룹 함수는 그룹키 밑에서 HAVING 조건절로 사용 가능.



--- 이따가 전체 중복제거도 해보자
--- DECODE로도 해보자


-- COUNT 써보기. a60에 데이터가 1872개 있꾸나.
SELECT REGIONID,
    COUNT(*) AS COUNT_VALUE 
FROM KOPO_CHANNEL_SEASONALITY_NEW
GROUP BY REGIONID



SELECT COUNT(*) 
FROM 
(   SELECT DISTINCT REGIONID
    FROM KOPO_CHANNEL_RESULT_NEW
)


----  GROUP BY 연습해보자 !! 시험
SELECT 지역,상품, -- 지역이 같은것끼리 하나의 그룹을 생성.
    SUM(거래량) AS 거래총량 
FROM GROUP_TEST
GROUP BY 지역, 상품


SELECT * FROM GROUP_TEST

