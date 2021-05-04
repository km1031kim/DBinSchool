-- DT_RESULT_FINAL3 테이블에서
--- 정확도를 산출하세요
---- 단, 예측값이 0인경우 정확도는 0
------ 정확도 = 1- ABS(예측값-실측값)/예측값


SELECT * FROM DT_RESULT_FINAL3


--DECODE를 사용해서 풀어보자

--- DECODE(-가,-이면,이거고,아니면이거)

---- 1. PREDICTION_QTY가 0이면 1로 바꾸고, 새 테이블에 적용
----- 2. 새 테이블을 통해 정확도 구하기.

--DECODE를 사용해서 풀어보자
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





------------------------ CONCAT, IN, LIKE NOT IN 연습 ------------------------------
SELECT * FROM DT_RESULT_FINAL3


-- LIKE
--- WHERE 컬럼명 LIKE '%포함된 문자%' // 예제의 경우 224로 시작하는지에 대한 쿼리문.
SELECT * FROM DT_RESULT_FINAL3 WHERE PREDICTION_QTY LIKE '224%'


-- IN
--- 2100인 것만 추출.
SELECT * FROM DT_RESULT_FINAL3
WHERE REAL_QTY IN '2100'

-- NOTIN
--- 2100이 아닌 것만 추출.
SELECT * FROM DT_RESULT_FINAL3
WHERE REAL_QTY NOT IN '2100'


-- 컬럼 합치기 

SELECT A.*,
    PRODUCT||'_'||ITEM AS PROITEM
    FROM DT_RESULT_FINAL3 A
    

-- CONCAT 컬럼합치기
---- PRODUCT랑 ITEM 뒤, 에도 구분자가 들어갈 수 있다!! 신기!
SELECT A.*,
    CONCAT(PRODUCT||'_'||ITEM, '_'||YEARWEEK) AS PROITEM
    FROM DT_RESULT_FINAL3 A
    
   




    