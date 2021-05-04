CREATE TABLE T1
( YEAR VARCHAR2(100),
  MONTH VARCHAR2 (100),
  DAY VARCHAR2(100)
)



--- 실습문제 3번!

--- 다음 구동날짜를 계산, 옆 컬럼에 넣어야 한다


-- TO_DATE(YEAR||MONTH||DAY)+7*1 AS DAY

-- TO_DATE, TO CHAR 검색.

-- NEXT_DAY(TO_DATE(YEAR||MONTH||DAY)+7*2, 3) AS DAY

-- NEXT_DAY 실행 시 7, 7*2 등으로 몇 주 뒤인지 계산 가능하고,
-- 뒤에있는 ,1 ,2 ,3 ,4 ,5 ,6 ,7 는 일, 월 ,화 ,수, 목, 금 토 이다
-- 즉 합친 년월일에 14일을 더하고 그 주의 화요일을 DAY컬럼 속에 넣는다


SELECT * FROM T1

INSERT INTO T1 VALUES 
('2021', '04','28')





-- TO DATE는 안의 숫자를 특정한 형식의 DATE로 바꿔준다.
-- 그냥 실행할 시 / 로 구분되어 있지만 TO_CHAR 를 통해 구분자를 바꿔줄 수 있다
-- EX 'YYYY-MM-DD', 'YYYY%%MM%%DD'
SELECT A.*,
    TO_CHAR(NEXT_DAY(TO_DATE(A.YEAR||A.MONTH||A.DAY)+7, 3),'YYYY-MM-DD') AS AFTER_BATCH
FROM T1 A







    
 
