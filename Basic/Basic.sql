-- ����� ��������
CREATE USER JG --���̵�
IDENTIFIED BY JG --��й�ȣ

-- ����� ��й�ȣ ���� �� ����� ����
ALTER USER JG
IDENTIFIED BY KIM  --(�� ��й�ȣ�� ���浵 ����.)
--��ĭ ���

DROP USER JG CASCADE; --(����)

-- ����� �����ֱ�
---GRANT {����#1}, {����#2} TO JG
---EX) GRANT CONNECT(����), RESOURCE(���ҽ�), DBA(���̺�) TO JG
GRANT CONNECT, RESOURCE, DBA TO JG


-- ���̺� ����
CREATE TABLE JGDATA 
--- CREATE ���̺�� (Ÿ�� �� ����, Ÿ�� �� ����...)
(
    REGIONID VARCHAR(100),--���ڿ� �ִ� 100��(������ũ��)
    PRODUCTGROUP VARCHAR(100),
    YEARWEEK VARCHAR(100),
    VOLUME NUMBER --(���ڰ�)
)

-- ���̺� ��ȸ�ϱ�
SELECT REGIONID, PRODUCTGROUP FROM JGDATA --(SELECT �÷���, �÷��� FROM ���̺��)
-- ���� JGDATA�� ���� �ִ� �����͸� ������ �� �������� �����ϰ� ������
SELECT * FROM SYSTEM.JGDATA --(SYSTEM�� �ִ� JGDATA ��θ� �ҷ��´�)
-- ��� ������ ��ȸ
SELECT * FROM TABS;


-- ������ �Է��ϱ�
-- DATABASE>IMPORT TABLE DATA>���̺� ���� �� SHOW DATA>���� ÷��>FIRST ROW ����>
-- >ONE COMMIT AFTER ALL RECORDS.

-- ������ ����
EDIT JGDATA --(DATA GRID â���� ���� ����)

-- ���� �ο� ���̺� ��ȸ�ϱ�
SELECT PRODUCTGROUP, YEARWEEK -- �÷� ����
FROM JGDATA -- ������ �̸�
WHERE VOLUME >= 1000000 --���� �ο�







