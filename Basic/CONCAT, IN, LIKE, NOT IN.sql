
------------------------ CONCAT, IN, LIKE, NOT IN 연습 ------------------------------
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
    