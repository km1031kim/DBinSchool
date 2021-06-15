
  

-- �� ���ο��� � �����(����)�� ���� �ٹ����� �� ?�� ���� �ٹ��� �����ŭ �����ݾ��� �ջ��Ͽ� ���ڵ� �Ѱ����� �����.? �ƴ϶�� ���� ���ڵ� 1������ ����?
-- ���� �ٸ����ο��� �ߺ��� ���� �� ��� �и��ؼ� �����Ѵ�.

--- STEP 1 : ���ι�ȣ ��, ���ι�ȣ, �����⵵���� �׷����.
--- STEP 2 : ���κ��� ������ ���Ѵ�. ������ 1�� ���� ���⵵�� �̾ ���Ѵٴ� ��. NULL�� ���� ���ӱٹ�X, 0���� �ٲ��ش�
--- STEP 3 : ������ 1�� ���� ���ӱٹ��� �ش�ǹǷ�, �� ��� ���κ�, ���κ��� �׷����, ��ĭ �� ROW�� �ݾװ� ���Ѵ�(LAG). ������ 0�� ���� ���� ROW�� ������ �Է�.
--- STEP 4 : ���κ�, ���κ� �׷���� �� �����Լ��� ���κ� ���������� ���Ѵ�.

     
SELECT * FROM TEXDATA3

SELECT C.LVY_RPER_TIN AS ���ι�ȣ, C.LE_TIN AS ���ι�ȣ, SUM(C.���������Դϴ�) AS ���κ�����������
FROM
(
    SELECT B.*,
           CASE WHEN B.����=1 THEN LAG(B.����, B.����, B.����) 
           OVER(PARTITION BY B.LE_TIN ORDER BY B.ATRR_YR) ELSE B.���� END AS ���������Դϴ�
    FROM
        (       
        SELECT A.*, NVL(ATRR_YR-���⵵,0) AS ����
        FROM
        (
            SELECT LVY_RPER_TIN, LE_TIN,ATRR_YR, SUM(TXTN_TRGT_SNW_AMT) AS ����,
                   LAG(ATRR_YR) OVER(PARTITION BY LE_TIN ORDER BY ATRR_YR) AS ���⵵
            FROM 
            TEXDATA3
            GROUP BY  LVY_RPER_TIN, LE_TIN,ATRR_YR
            ORDER BY ATRR_YR ASC 
        )A
    )B
)C 
GROUP BY C.LVY_RPER_TIN, C.LE_TIN


SELECT * FROM TEXDATA3

