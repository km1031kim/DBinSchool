--- 테이블 생성

CREATE TABLE 근무지 (
 근무지 VARCHAR2(100),
 근무지명 VARCHAR2(100),
 근무지주소 VARCHAR2(100)
 )
 
 CREATE TABLE 부서 (
 부서코드 VARCHAR2(100),
 부서명 VARCHAR2(100)
 )
   
 CREATE TABLE 사원 (
 사원번호 NUMBER,
 사원명 VARCHAR2(100),
 직급코드 NUMBER,
 근무지코드 VARCHAR2(100),
 부서코드 VARCHAR2(100),
 상급자사원번호 NUMBER,
 급여 NUMBER,
 입사일 VARCHAR2(100)
 )
 
  
  CREATE TABLE 직급 (
 직급코드 NUMBER,
 직급명 VARCHAR2(100)
 )
 
 -- 입력확인
SELECT * FROM 근무지
 
SELECT * FROM 부서
 
SELECT * FROM 사원
 
SELECT * FROM 직급


 
-- 1. 급여가 800만원 이상인 사원의 사원명, 직급코드를 출력하시오


SELECT 사원명, 직급코드 
FROM 사원
WHERE 1=1
AND 급여 >= 8000000



-- 2. 입사일이 2010년~2018년 사이인 사원의 사원명, 부서코드, 급여, 입사일을 출력하시오


SELECT B.사원명,
       B.부서코드,
       B.급여,
       B.입사일
FROM
(
    SELECT A.*,
           TO_NUMBER(SUBSTR(A.입사일,0,4)) AS 입사년도
    FROM 사원 A
    WHERE 1=1
)B
WHERE 1=1
AND 입사년도 >= 2010
AND 입사년도 <= 2018



-- 3. 입사일이 2020년 08월이면서 부서코드가 'C'가 아닌 사원의 사원명, 근무지코드, 부서코드를 출력하시오


SELECT B.사원명,
       B.근무지코드,
       B.부서코드
FROM
(
    SELECT A.*,
            SUBSTR(A.입사일,0,7) AS 입사년월
    FROM
    사원 A
    WHERE 1=1
)B
WHERE 1=1
AND B.입사년월 = '2020-08'
AND B.부서코드 != 'C'



-- 4. 사원의 총인원수를 출력하시오


SELECT SUM(TEMP) AS 총인원수
FROM
(
    SELECT 사원명,
           COUNT(사원명) AS TEMP
    FROM 
    사원
    WHERE 1=1
    GROUP BY 사원명
)B



-- 5. 상급자사원번호가 없는 사원의 총인원수와 총급여합을 출력하시오

---- step1 : null값 치환하기(0으로)
---- step2 : 0을 가지고 있는 데이터만 추출하기
---- step3 : 총인원수와, 총급여합 구하기(group by)


SELECT COUNT(B.DUAL) AS 총인원수,
       SUM(B.급여) AS 총급여
FROM
(
    SELECT A.*,
           NVL2(A.상급자사원번호, A.상급자사원번호, 0) AS TEMP, -- NULL값 으로 치환.
           1 AS DUAL -- 인원수 구하기 위해 1 넣어주기.
    FROM 
    사원 A
)B
WHERE 1=1 
AND TEMP = 0



-- 6. 급여가 300만원이하이면서 2020년 08월 15일 이후에 입사한 사원의 총인원수와 총급여합을 출력하시오

---- STEP 1 : 급여 300만원 이하 데이터 추출
---- STEP 2 : 입사일 뒤의 00:00 없애고 비교하기 쉬운 형태로 변환
---- STEP 3 : 2020 / 08 / 15 이후의 사원목록 추출
---- STEP 4 : 사원의 총인원수와 총급여합 추출


SELECT SUM(C.TEMP) AS 총인원수,
       SUM(C.급여) AS 총급여합
FROM
(
    SELECT B.*
    FROM
    (
        SELECT A.*,
               TO_CHAR(TO_DATE(SUBSTR(A.입사일,0,10)), 'yyyymmdd') AS 입사년월일,
               1 AS TEMP -- 인원수를 위한 1.TEMP       
        FROM
        사원 A
        WHERE 1=1
        AND A.급여 <= 3000000
    )B
    WHERE 1=1
    AND TO_NUMBER(B.입사년월일) >= 20200815
)C



-- 7.'한' 씨 성을 가진 사원들을 출력하시오

---- STEP 1 : 성의 인덱스 추출
---- STEP 2 : 인덱스로 데이터 정제
---- STEP 3 : 성이 두글자인 경우는?? EX) 한솔진규.. 성이 한솔..
                -- 성이 한이여야 되고, 이름은 네글자 이상이면 안된다.


SELECT * 
FROM 
사원
WHERE 1=1
AND SUBSTR(사원명,0,1) = '한'
AND LENGTH(사원명) < 4

 

-- 8. 직급별 급여의 평균을 출력하시오(반올림해서 정수만 출력)

---- STEP 1 : 직급코드으로 GROUP BY
---- STEP 2 : 평균 구하기
---- STEP 3 : 반올림 하기


SELECT 직급코드,
       ROUND(AVG(급여)) AS 평균급여
FROM
사원
GROUP BY 직급코드



-- 9. 사원명에 '삭' 자가 포함되어 있거나 '김'씨 성을 가진 사원의 급여합을 출력하시오.

---- LIKE, SUBSRT 사용.
---- STEP 1 : 사원명에 '삭' 자 있는 데이터 추출
---- STEP 2 : '김'씨 성을 가진 데이터 추출
---- STEP 3 : 급여합 구하기


SELECT SUM(B.급여) AS 급여합
FROM
(
    SELECT * 
    FROM 
    사원
    WHERE 1=1
    AND 사원명 LIKE '%삭'
    OR SUBSTR(사원명,0,1) = '김' 
)
B



-- 10.부서별 사원수를 출력하시오

---- STEP 1 : 모든 사원에 1 값 주기 OR COUNT 사용
---- STEP 2 : 부서코드로 GROUP BY 하기
---- STEP 3 : SUM하기.


SELECT 부서코드,
       SUM(TEMP) AS 총인원수
FROM
(
    SELECT A.*,
           1 AS TEMP
    FROM
    사원 A
)
GROUP BY 부서코드


-- 11. 근무지별 사원의 총인원수를 출력하시오

---- STEP 1 : 모든 ROW에 1 값 주기 OR COUNT 사용
---- STEP 2 : 근무지별로 GROUPBY
---- STEP 3 : SUM하기


SELECT 근무지코드,
       SUM(TEMP) AS 총인원수
FROM
(  
    SELECT A.*,
           1 AS TEMP
    FROM
    사원 A
)
WHERE 1=1
GROUP BY 근무지코드



-- 12. 가장 높은 급여와 가장 낮은 급여를 출력하시오.

---- STEP 1 : MAX 사용
---- STEP 2 : MIN 사용


SELECT MAX(급여) AS 최대급여,
       MIN(급여) AS 최소급여
FROM
사원



-- 13. 급여가 500만원 이상, 800만원 이하인 사원의 급여평균과 급여의 최대값을 출력하시오

---- STEP 1 : 급여의 범위로 데이터 정제
---- STEP 2 : AVG, MAX 사용, 평균과 최대값 출력


SELECT  AVG(급여) AS 평균급여,
        MAX(급여) AS 최대급여
FROM
사원
WHERE 1=1
AND 급여 >= 5000000 AND 급여 <= 8000000



-- 14. 가장 높은 급여와 가장 낮은 급여의 차를 출력하시오

---- STEP 1 : 가장 높은 급여와 낮은 급여 추출.
---- STEP 2 : 새 컬럼으로 출력


SELECT (MAX(급여) - MIN(급여)) AS 최대급여차
FROM
사원
WHERE 1=1



-- 15. 근무지가 'A1'이 아닌 사원들의 부서코드별 사원수를 출력하시오

---- STEP 1 : 근무지가 A1이 아닌 사원 추출, COUNT 하기.
---- STEP 2 : 부서코드로 GROUP BY, SUM 구하기


SELECT 부서코드,
       COUNT(사원명) AS 총인원수
FROM
(
    SELECT * FROM 
    사원
    WHERE 1=1
    AND 근무지코드 != 'A1'
)
GROUP BY 부서코드



-- 16. 부서코드별 사원번호순으로 부서코드, 사원번호, 사원명, 급여의 누적값을 구해서 출력하시오

---- STEP 1 : GROUP BY 후 ORDER BY 부서코드, 사원번호
---- STEP 2 : 누적 합계를 구하기 위해 분석함수 OVER절을 사용. 
----          첫번째 행부터 읽고 있는 행까지(ROWS UNBOUNDED PRECEDING)
----          컬럼별로 누적시에는 SUM(누적할 컬럼명) OVER(PARTITION BY [그룹화할 컬럼명] ORDER BY [정렬값]


SELECT 부서코드,
       사원번호,
       사원명,
       SUM(급여) OVER(PARTITION BY 부서코드 ORDER BY 부서코드, 사원번호) AS 누적급여       
FROM
사원
GROUP BY 부서코드, 사원번호,사원명,급여
ORDER BY 부서코드, 사원번호



-- 17. 부서명, 사원명 출력하시오 

---- STEP 1 : 사원 테이블에 부서 테이블 JOIN
---- STEP 2 : 부서명, 사원명 출력


SELECT C.부서명,
       C.사원명
FROM
(
    SELECT A.*,
           B.*
    FROM 사원 A
    LEFT JOIN 부서 B
    ON A.부서코드 = B.부서코드
)C



-- 18.전체 사원명과 부서명을 출력하되 부서명이 존재하지 않는 부서코드는 '부서명없음'으로 출력하시오

---- STEP 1 : 17번 문제와 동일하게 진행
---- STEP 2 : NVL2 사용.


SELECT C.사원명,
       C.TEMP AS 부서명
FROM
(
    SELECT A.*,
           B.*,
           NVL2(부서명, 부서명, '부서명없음') AS TEMP
    FROM
    사원 A
    LEFT JOIN 부서 B
ON A.부서코드 = B.부서코드
)C



-- 19. 부서명으로 오름차순 정렬해서 부서명, 사원명, 입사일을 출력하시오

---- STEP 1 : 사원테이블과 부서테이블 JOIN
---- STEP 2 : ORDER BY 부서명.


SELECT C.TEMP AS 부서명,
       C.사원명,
       C.입사일
FROM
(
    SELECT A.*,
           B.*,
           NVL2(부서명, 부서명, '부서명없음') AS TEMP
    FROM
    사원 A
    LEFT JOIN 부서 B
    ON A.부서코드 = B.부서코드
)C
ORDER BY C.TEMP



-- 20. 부서명과 부서별 사원의 총인원수를 출력하시오

---- STEP 1 : 사원테이블, 부서테이블 JOIN
---- STEP 2 : 부서명으로 GROUP BY, COUNT 사용


SELECT C.TEMP AS 부서명,
       COUNT(사원명) AS 총인원수
FROM
(
    SELECT A.*,
           B.*,
           NVL2(부서명, 부서명, '부서명없음') AS TEMP
    FROM
    사원 A
    LEFT JOIN 부서 B
    ON A.부서코드 = B.부서코드
)C
GROUP BY C.TEMP



-- 21. 사원명을 출력하되 급여가 100만원 미만이면 0, 100만원~200만원 사이면 200, 200만원~300만원이면 300...
--     (구간대를 1000만원까지) 을 함께 출력하시오(사원별 급여구간)

---- STEP 1 : CASW WHEN 사용, 급여구간 지정하기
---- STEP 2 : 사원명, 급여구간 출력하기


SELECT B.사원명,
       B."사원별 급여구간"
FROM
(
    SELECT A.*,   
           CASE WHEN A.급여 < 1000000 THEN 0
                WHEN A.급여 < 2000000 THEN 200
                WHEN A.급여 < 3000000 THEN 300
                WHEN A.급여 < 4000000 THEN 400
                WHEN A.급여 < 5000000 THEN 500
                WHEN A.급여 < 6000000 THEN 600
                WHEN A.급여 < 7000000 THEN 700
                WHEN A.급여 < 8000000 THEN 800
                WHEN A.급여 < 9000000 THEN 900
                ELSE 1000
                END AS "사원별 급여구간"       
    FROM 
    사원 A
)B



-- 22. 사원이 속한 모든 부서의 부서별 부서명과 급여합을 출력하시오

---- STEP 1 : 사원테이블과 부서테이블 JOIN
---- STEP 2 : 부서명으로 GROUPBY, SUM(급여)


SELECT C.TEMP AS 부서명,
       SUM(C.급여) AS 급여합
FROM
(
    SELECT A.*,
           B.*,
           NVL2(부서명, 부서명, '부서명없음') AS TEMP
    FROM 사원 A
    LEFT JOIN 부서 B
    ON A.부서코드 = B.부서코드
)C
GROUP BY C.TEMP


       
-- 23. 부서별 부서명, 최소급여, 최대급여 출력하시오

---- STEP 1 : 사원테이블, 부서테이블 JOIN
---- STEP 2 : 부서명으로 GROUPBY, MIN(급여), MAX(급여(


SELECT C.TEMP AS 부서명,
       MIN(C.급여) AS 최소급여,
       MAX(C.급여) AS 최대급여
FROM
(
    SELECT A.*,
           B.*,
           NVL2(부서명, 부서명, '부서명없음') AS TEMP
    FROM 사원 A
    LEFT JOIN 부서 B
    ON A.부서코드 = B.부서코드
)
C
GROUP BY C.TEMP



-- 24. 전체 사원을 대상으로 사원번호, 사원명, 상급자사원번호, 상급자사원명을 출력하시오(상급자사원번호가 없는 사원이 상급자임)

---- STEP 1 : 같은 테이블끼리 조인. 상급자사원번호 = 사원번호로 기준컬럼 잡기
---- STEP 2 : NULL값 상급자로 번경


SELECT C.사원번호,
       C.사원명,
       C.상급자사원번호,
       C.상급자사원명
FROM
(
    SELECT A.*,
           NVL2(B.사원명, B.사원명, '상급자') AS 상급자사원명
    FROM 사원 A
    LEFT JOIN 사원 B
    ON A.상급자사원번호 = B.사원번호
)C



-- 25. 상급자사원명이 '허잔석' 인 사원들의 부서명별 급여평균을 출력하시오

---- STEP 1 : 같은 테이블끼리 조인. 상급자사원명 컬럼 추가
---- STEP 2 : 상급자 사원명 '허잔석' 으로 데이터 정제
---- STEP 3 : 부서 테이블과 조인. 부서명 추가
---- STEP 4 : 부서명으로 GROUP BY, AVG(급여) 출력


SELECT NVL2(F.부서명, F.부서명, '부서없음') AS 부서명,
       AVG(F.급여) AS 부서별급여평균
FROM
(
    SELECT D.*,
           E.*
    FROM
    (
        SELECT C.*
        FROM
        (
            SELECT A.*,
                   NVL2(B.사원명, B.사원명, '상급자') AS 상급자사원명
            FROM 사원 A
            LEFT JOIN 사원 B
            ON A.상급자사원번호 = B.사원번호
        )C
        WHERE 1=1
        AND C.상급자사원명 = '허잔석'
    )D
    LEFT JOIN 부서 E
    ON D.부서코드 = E.부서코드
)F
GROUP BY F.부서명



-- 26. 부서별 급여의 합이 1억원이 넘는 부서의 부서명과 해당 부서의 급여합을 출력하시오. (1억 넘는게 없어서 천만으로 바꿨습니다)

---- STEP 1 : 사원테이블, 부서테이블 조인, 부서명 정보 추가
---- STEP 2 : SUM(급여) >= 천만원 조건 추가. 
---- STEP 3 : 조건에 맞는 부서명, 급여합 출력


SELECT * FROM
(
    SELECT C.부서명,
           SUM(C.급여) AS 급여합
    FROM
    (
        SELECT A.*,
               B.*
        FROM 사원 A
        LEFT JOIN 부서 B
        ON A.부서코드 = B.부서코드
    )C
    WHERE 1=1
    GROUP BY C.부서명
)D
WHERE D.급여합 >= 10000000



-- 27. 전체 사원을 대상으로 부서별 사원수가 2명 미만인 부서의 부서코드, 부서명, 사원수를 출력하시오(부서명이 없으면 '부서명없음'으로 출력)

---- STEP 1 : 사원테이블, 부서테이블 JOIN.
---- STEP 2 : 부서코드로 GROUP BY, 부서별 사원수 구하기
---- STEP 3 : 사원수가 2명 미만인 부서만 출력


SELECT *
FROM
(
    SELECT C.부서코드,
           NVL2(C.부서명, C.부서명, '부서명없음') AS 부서명,
           COUNT(C.사원명) AS 사원수
    FROM
    (
        SELECT A.*,
               B.부서명 AS 부서명       
        FROM 사원 A
        LEFT JOIN 부서 B
        ON A.부서코드 = B.부서코드
    )C
    GROUP BY C.부서코드, C.부서명
)
WHERE 1=1
AND 사원수 < 2



-- 28. 부서별로 부서코드, 부서명, 사원수를 출력하되 부서명이 존재 하지 않으면 부서명은 '부서명없음', 사원수를 0으로 출력하시오

---- STEP 1 : 사원테이블, 부서테이블 JOIN
---- STEP 2 : 부서명 NULL값 -> 부서명 없음 변경
---- STEP 3 : DECODE 사용, 부서명없음 의 경우 사원수 0으로 변경.


SELECT D.부서코드,
       D.부서명,
       DECODE(D.부서명,'부서명없음',0,COUNT(D.사원명)) AS CNT
FROM
(
    SELECT C.부서코드,
           NVL2(C.부서명, C.부서명, '부서명없음') AS 부서명,
           C.사원명
    FROM
    (
        SELECT A.*,
               B.부서명
        FROM 사원 A
        LEFT JOIN 부서 B
        ON A.부서코드 = B.부서코드
    )C
)D
GROUP BY D.부서코드, D.부서명



-- 29. 가장 많은 사원을 데리고 있는 상급자의 상급자명, 부서명을 출력하시오.

---- STEP 1 : 사원테이블, 부서테이블 JOIN
---- STEP 2 : 사원테이블끼리 JOIN, 상급자 이름 매치시키기.
---- STEP 3 : 상급자으로 GROUPBY, 사원수 COUNT
---- STEP 4 : 상급자 본인 제외 후 출력.


SELECT F.상급자명,
       COUNT(F.사원명) AS 멘티수
FROM
(
    SELECT E.상급자명,
           E.사원명
    FROM
    (
        SELECT C.*,
               NVL2(D.사원명, D.사원명, '상급자') AS 상급자명
        FROM
        (       
            SELECT A.*,
                   B.부서명
            FROM 사원 A
            LEFT JOIN 부서 B
            ON A.부서코드 = B.부서코드
        )C
        LEFT JOIN 사원 D
        ON C.상급자사원번호 = D.사원번호
    )E
    WHERE 1=1
    GROUP BY E.상급자명, E.사원명
)F
WHERE F.상급자명 != '상급자'
GROUP BY F.상급자명



-- 30. 부서명이 등록되지 않은 사원과 직급이 같고 현황조사를 하고 있는 사원의 사원명, 직급명을 출력하시오.

---- STEP 1 : 사원, 부서테이블,  JOIN
---- STEP 2 : 부서명이 없는 사원의 직급코드를 기준으로, 해당 직급코드를 가지고 있는 사원 조회.
---- STEP 3 : 직급 테이블과 JOIN, 부서 테이블과 JOIN.
---- STEP 4 : 현황조사 직원만 출력.


SELECT 사원명,
       직급명
FROM
(
    SELECT * FROM
    (
        SELECT * FROM
        (
            SELECT * FROM
            사원
            WHERE 1=1
            AND 직급코드 IN (SELECT DISTINCT 직급코드 
                            FROM (  SELECT A.*,
                                    NVL2(B.부서명, B.부서명, '부서명없음') AS 부서명
                                    FROM 사원 A
                                    LEFT JOIN 부서 B
                                    ON A.부서코드 = B.부서코드 )
                            WHERE 부서명 = '부서명없음')
        )C
        LEFT JOIN 직급 D
        ON C.직급코드 = D.직급코드
    )E
    LEFT JOIN 부서 F
    ON E.부서코드 = F.부서코드
) WHERE 부서명 = '현황조사';



-- 31.직급별로 최소 급여를 받고 있는 사원의 사원번호, 사원명, 부서명, 급여를 급여의 내림차순 정렬로 출력하시오

---- STEP 1 : 사원테이블, 부서테이블 조인
---- STEP 2 : 부서별 최소급여로 GROUP BY
---- STEP 3 : 사원테이블과 JOIN 해당되는 최소급여를 가진 사원과 연결. 데이터 출력. 
---- STEP 4 : 내림차순 정렬


SELECT F.사원번호,
       F.사원명,
       NVL2(E.부서명, E.부서명, '부서명없음') AS 부서명,
       F.급여
FROM
(
    SELECT MIN(D.급여) AS 최소급여,
           D.부서명
    FROM
    (
        SELECT C.*
        FROM
        (
            SELECT A.*,
                   B.부서명
            FROM 사원 A
            LEFT JOIN 부서 B
            ON A.부서코드 = B.부서코드
        )C
    )D
    GROUP BY D.부서명
    )E
LEFT JOIN 사원 F
ON E.최소급여 = F.급여
ORDER BY 급여 DESC



-- 32. 각 사원의 시급을 계산(근무일수 20일, 9시간근무, 소수 첫번째 자리에서 반올림)해서 부서명, 사원명, 직급명, 시급을 부서명별, 시급이 많은 순으로 출력하시오.

---- STEP 1 : 시급을 계산, 새 컬럼으로 추가.
---- STEP 2 : 부서테이블과 조인, 부서명 연결
---- STEP 3 : 직급테이블과 조인, 직급명 연결
---- STEP 4 : GROUP BY, JOIN을 통해 부서별로 시급이 높은 순으로 출력.


SELECT F.부서명,
       F.사원명,
       F.직급명,
       F.시급
FROM
(
    SELECT D.*,
           E.직급명
    FROM
    (
        SELECT B.*,
               NVL2(C.부서명, C.부서명, '부서명없음') AS 부서명
        FROM
        (
            SELECT A.*,
                   ROUND((A.급여 / 180),0) AS 시급
            FROM
            사원 A
        )B
        LEFT JOIN 부서 C
        ON B.부서코드 = C.부서코드
    )D
    LEFT JOIN 직급 E
    ON D.직급코드 = E.직급코드
)F
GROUP BY F.부서명, F.사원명, F.직급명, F.시급
ORDER BY F.부서명 ASC, F.시급 DESC



-- 33. 직급별 입사일이 가장 오래된 사원에 대해 사원명, 직급명, 입사년도를 출력하시오

---- STEP 1 : 사원테이블, 직급테이블 JOIN
---- STEP 2 : 입사일 컬럼 TIMESTAMP로 속성 변경
---- STEP 3 : GROUP BY로 직급별로 가장 오래된 입사일 조회
---- STEP 4 : 사원테이블과 조인, 가장 오래된 입사일을 가진 사원과 연결
---- STEP 5 : 조인된 테이블에서 직급명, 사원명, 입사년도(SUBSTR) 조회


SELECT H.직급명,
       H.사원명,
       H.입사년도
FROM
(
    SELECT F.직급명,
           G.사원명,
           SUBSTR(G.입사일,0,4) AS 입사년도
    FROM
    (
        SELECT E.직급명,
               MIN(TEMP) AS 가장오래된입사일
        FROM
            (
            SELECT D.사원명,
                   D.직급명,
                   D.입사일,
                   D.TEMP
            FROM
            (
                SELECT B.*,
                       TO_TIMESTAMP(B.입사일) AS TEMP,
                       C.직급명
                FROM
                (
                    SELECT *
                    FROM
                    사원 A
                )B
                LEFT JOIN 직급 C
                ON B.직급코드 = C.직급코드
            )D
        )E
        GROUP BY E.직급명
    )F
    LEFT JOIN 사원 G
    ON F.가장오래된입사일 = G.입사일
)H
GROUP BY H.직급명, H.사원명, H.입사년도
ORDER BY H.직급명 DESC
