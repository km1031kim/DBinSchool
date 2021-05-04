CREATE TABLE T1
( YEAR VARCHAR2(100),
  MONTH VARCHAR2 (100),
  DAY VARCHAR2(100)
)



--- �ǽ����� 3��!

--- ���� ������¥�� ���, �� �÷��� �־�� �Ѵ�


-- TO_DATE(YEAR||MONTH||DAY)+7*1 AS DAY

-- TO_DATE, TO CHAR �˻�.

-- NEXT_DAY(TO_DATE(YEAR||MONTH||DAY)+7*2, 3) AS DAY

-- NEXT_DAY ���� �� 7, 7*2 ������ �� �� ������ ��� �����ϰ�,
-- �ڿ��ִ� ,1 ,2 ,3 ,4 ,5 ,6 ,7 �� ��, �� ,ȭ ,��, ��, �� �� �̴�
-- �� ��ģ ����Ͽ� 14���� ���ϰ� �� ���� ȭ������ DAY�÷� �ӿ� �ִ´�


SELECT * FROM T1

INSERT INTO T1 VALUES 
('2021', '04','28')





-- TO DATE�� ���� ���ڸ� Ư���� ������ DATE�� �ٲ��ش�.
-- �׳� ������ �� / �� ���еǾ� ������ TO_CHAR �� ���� �����ڸ� �ٲ��� �� �ִ�
-- EX 'YYYY-MM-DD', 'YYYY%%MM%%DD'
SELECT A.*,
    TO_CHAR(NEXT_DAY(TO_DATE(A.YEAR||A.MONTH||A.DAY)+7, 3),'YYYY-MM-DD') AS AFTER_BATCH
FROM T1 A







    
 
