
-- STEP 0. 테이블 생성 후 IMPORT

CREATE TABLE EXAM
(
    SEG1          VARCHAR2 (100),
    SEG2          VARCHAR2 (100),
    SEG3          NUMBER,
    TARGETWEEK    NUMBER,
    YEAR          NUMBER,
    WEEK          NUMBER,
    QTY           NUMBER,
    FCST_W6       NUMBER,
    FCST_W5       NUMBER,
    FCST_W4       NUMBER,
    FCST_W3       NUMBER,
    FCST_W2       NUMBER,
    FCST_W1       NUMBER
)
 -- STEP 1. ABS8W = [ABS(FCST-ACT) 컬럼 추가 후 STEP_ONE으로 테이블 저장. 대상 자료와 같은 모양으로 오름차순 정렬.

 CREATE TABLE STEP_ONE AS
 SELECT A.*,
      ABS(A.FCST_W6 - A.QTY) AS W6,
      ABS(A.FCST_W5 - A.QTY) AS W5,
      ABS(A.FCST_W4 - A.QTY) AS W4,
      ABS(A.FCST_W3 - A.QTY) AS W3,
      ABS(A.FCST_W2 - A.QTY) AS W2,
      ABS(A.FCST_W1 - A.QTY) AS W1
      FROM EXAM A
      ORDER BY SEG2 ASC, SEG3 ASC



-- STEP 2. ACC8W = [ IF(OR(F8W=0, ACT=0), 0, IF(ACT/FCST > 2, 0, 1-ABS8W/FCST] 컬럼 추가 후 STEP_TWO로 테이블 저장.

CREATE TABLE STEP_TWO AS
    SELECT B.*,
        CASE WHEN (B.FCST_W6 = 0 OR B.QTY = 0) THEN 0
            WHEN (B.QTY/B.FCST_W6 > 2) THEN 0
            ELSE (1-ABS(B.FCST_W6 - B.QTY) / B.FCST_W6)
            END AS ACC8W6_N,
        CASE WHEN (B.FCST_W5 = 0 OR B.QTY = 0) THEN 0
             WHEN (B.QTY/B.FCST_W5 > 2) THEN 0
             ELSE (1-ABS(B.FCST_W5 - B.QTY) / B.FCST_W5)
             END AS ACC8W5_N,
        CASE WHEN (B.FCST_W4 = 0 OR B.QTY = 0) THEN 0
            WHEN (B.QTY/B.FCST_W4 > 2) THEN 0
            ELSE (1-ABS(B.FCST_W4 - B.QTY) / B.FCST_W4)
            END AS ACC8W4_N,
        CASE WHEN (B.FCST_W3 = 0 OR B.QTY = 0) THEN 0
            WHEN (B.QTY/B.FCST_W3 > 2) THEN 0
            ELSE (1-ABS(B.FCST_W3 - B.QTY) / B.FCST_W3)
            END ACC8W3_N,
        CASE WHEN (B.FCST_W2 = 0 OR B.QTY = 0) THEN 0
            WHEN (B.QTY/B.FCST_W2 > 2) THEN 0
            ELSE (1-ABS(B.FCST_W2 - B.QTY) / B.FCST_W2)
            END AS ACC8W2_N,
        CASE WHEN (B.FCST_W1 = 0 OR B.QTY = 0) THEN 0
            WHEN (B.QTY/B.FCST_W1 > 2) THEN 0
            ELSE (1-ABS(B.FCST_W1 - B.QTY) / B.FCST_W1)
            END AS ACC8W1_N
     FROM STEP_ONE B
     ORDER BY SEG2 ASC, SEG3 ASC


-- STEP 3. STEP_TWO 테이블 속 NULL값 0으로 치환 후 필요한 컬럼만 조회, STEP_THREE로 테이블 저장

CREATE TABLE STEP_THREE AS
SELECT C.SEG1, C.SEG2, C.SEG3, C.TARGETWEEK, C.YEAR, C.WEEK, C.QTY, 
       C.FCST_W6, C.FCST_W5, C.FCST_W4, C.FCST_W3, C.FCST_W2, C.FCST_W1, 
       C.W6, C.W5, C.W4, C.W3, C.W2, C.W1,
    NVL(C.ACC8W6_N,0) AS ACC8W6,
    NVL(C.ACC8W5_N,0) AS ACC8W5,
    NVL(C.ACC8W4_N,0) AS ACC8W4,
    NVL(C.ACC8W3_N,0) AS ACC8W3,
    NVL(C.ACC8W2_N,0) AS ACC8W2,
    NVL(C.ACC8W1_N,0) AS ACC8W1
FROM
STEP_TWO C


-- STEP 4. ACC8W*QTY = FCST * ACC8W	컬럼 추가. NULL 값 0으로 치환 전 TEMP로 컬럼명 저장. STEP_FOUR로 테이블 저장.		

CREATE TABLE STEP_FOUR AS    
SELECT A.*,
    ROUND((A.FCST_W6 * A.ACC8W6),0) AS TEMP6,
    ROUND((A.FCST_W5 * A.ACC8W5),0) AS TEMP5,
    ROUND((A.FCST_W4 * A.ACC8W4),0) AS TEMP4,
    ROUND((A.FCST_W3 * A.ACC8W3),0) AS TEMP3,
    ROUND((A.FCST_W2 * A.ACC8W2),0) AS TEMP2,
    ROUND((A.FCST_W1 * A.ACC8W1),0) AS TEMP1
FROM STEP_THREE A


-- STEP 5. STEP_FOUR 테이블의 TEMP1~TEMP6 NULL값 0으로 치환 후 TEMP1~TEMP6 컬럼을 제외한 필요한 데이터만 추출해서 STEP_FIVE 로 저장.

CREATE TABLE STEP_FIVE AS
SELECT A.SEG1, A.SEG2, A.SEG3, A.TARGETWEEK, A.YEAR, A.WEEK, A.QTY, 
       A.FCST_W6, A.FCST_W5, A.FCST_W4, A.FCST_W3, A.FCST_W2, A.FCST_W1, 
       A.W6, A.W5, A.W4, A.W3, A.W2, A.W1, A.ACC8W6, A.ACC8W5, A.ACC8W4, A.ACC8W3, A.ACC8W2, A.ACC8W1,
     NVL(A.TEMP6,0) AS "ACC8W6*QTY",
     NVL(A.TEMP5,0) AS "ACC8W5*QTY",
     NVL(A.TEMP4,0) AS "ACC8W4*QTY",
     NVL(A.TEMP3,0) AS "ACC8W3*QTY",
     NVL(A.TEMP2,0) AS "ACC8W2*QTY",
     NVL(A.TEMP1,0) AS "ACC8W1*QTY" 
FROM STEP_FOUR A


-- STEP 6. FCST_AVG 컬럼 생성 후 NULL값 0으로 치환 후 STEP_SIX로 저장

CREATE TABLE STEP_SIX AS
SELECT A.*,
   (A.FCST_W6 +  A.FCST_W5 +  A.FCST_W4 +  A.FCST_W3 +  A.FCST_W2 +  A.FCST_W1) / 6 AS FCST_AVG_TEMP
FROM STEP_FIVE A


--STEP 7. FCST_AVG 의 NULL값 0으로 치환 후 필요한 컬럼만 남겨서 STEP_SEVEN 으로 저장.

CREATE TABLE STEP_SEVEN AS
SELECT A.SEG1, A.SEG2, A.SEG3, A.TARGETWEEK, A.YEAR, A.WEEK, A.QTY, 
       A.FCST_W6, A.FCST_W5, A.FCST_W4, A.FCST_W3, A.FCST_W2, A.FCST_W1, 
       A.W6, A.W5, A.W4, A.W3, A.W2, A.W1, A.ACC8W6, A.ACC8W5, A.ACC8W4, A.ACC8W3, A.ACC8W2, A.ACC8W1,
       A."ACC8W6*QTY", A."ACC8W5*QTY", A."ACC8W4*QTY", A."ACC8W3*QTY", A."ACC8W2*QTY", A."ACC8W1*QTY",
    NVL(A.FCST_AVG_TEMP,0) AS FCST_AVG
FROM STEP_SIX A


--STEP 8. ACC_AVG 컬럼 생성 후 STEP_RESULT 로 저장.

CREATE TABLE STEP_RESULT AS
SELECT A.*,
    ("ACC8W6*QTY" + "ACC8W5*QTY" + "ACC8W4*QTY" + "ACC8W3*QTY" + "ACC8W2*QTY" + "ACC8W1*QTY") / 6  AS ACC_AVG
FROM STEP_SEVEN A


-- STEP 9. 답과 비교해본다

----최종본
SELECT * FROM STEP_RESULT

----정답
SELECT * FROM ANSWER
ORDER BY SEG2 ASC, SEG3 ASC

 -- 차이 없음! 완성! --

