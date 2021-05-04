-- 사용자 계정생성
CREATE USER JG --아이디
IDENTIFIED BY JG --비밀번호

-- 사용자 비밀번호 변경 및 사용자 삭제
ALTER USER JG
IDENTIFIED BY KIM  --(새 비밀번호로 변경도 가능.)
--한칸 띄고

DROP USER JG CASCADE; --(삭제)

-- 사용자 권한주기
---GRANT {권한#1}, {권한#2} TO JG
---EX) GRANT CONNECT(접속), RESOURCE(리소스), DBA(테이블) TO JG
GRANT CONNECT, RESOURCE, DBA TO JG


-- 테이블 생성
CREATE TABLE JGDATA 
--- CREATE 테이블명 (타입 및 길이, 타입 및 길이...)
(
    REGIONID VARCHAR(100),--문자열 최대 100자(데이터크기)
    PRODUCTGROUP VARCHAR(100),
    YEARWEEK VARCHAR(100),
    VOLUME NUMBER --(숫자값)
)

-- 테이블 조회하기
SELECT REGIONID, PRODUCTGROUP FROM JGDATA --(SELECT 컬럼명, 컬럼명 FROM 테이블명)
-- 만약 JGDATA를 내의 있는 데이터를 권한을 준 계정에서 접속하고 싶으면
SELECT * FROM SYSTEM.JGDATA --(SYSTEM에 있는 JGDATA 모두를 불러온다)
-- 모든 데이터 조회
SELECT * FROM TABS;


-- 데이터 입력하기
-- DATABASE>IMPORT TABLE DATA>테이블 선택 후 SHOW DATA>파일 첨부>FIRST ROW 선택>
-- >ONE COMMIT AFTER ALL RECORDS.

-- 데이터 에딧
EDIT JGDATA --(DATA GRID 창에서 에딧 가능)

-- 조건 부여 테이블 조회하기
SELECT PRODUCTGROUP, YEARWEEK -- 컬럼 설정
FROM JGDATA -- 데이터 이름
WHERE VOLUME >= 1000000 --조건 부여







