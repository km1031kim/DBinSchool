
  

-- 한 법인에서 어떤 고용인(개인)이 연속 근무했을 시 ?그 연속 근무한 년수만큼 과세금액을 합산하여 레코드 한건으로 만든다.? 아니라면 원래 레코드 1건으로 생성?
-- 만약 다른법인에서 중복된 일을 한 경우 분리해서 관리한다.

--- STEP 1 : 법인번호 별, 개인번호, 과세년도별로 그룹바이.
--- STEP 2 : 개인별로 년차를 구한다. 연차가 1인 경우는 전년도에 이어서 일한다는 것. NULL인 경우는 연속근무X, 0으로 바꿔준다
--- STEP 3 : 연차가 1인 경우는 연속근무에 해당되므로, 이 경우 법인별, 개인별로 그룹바이, 한칸 위 ROW의 금액과 더한다(LAG). 연차가 0인 경우는 현재 ROW의 세금을 입력.
--- STEP 4 : 법인별, 개인별 그룹바이 후 집계함수로 개인별 누적과세를 구한다.

     
SELECT * FROM TEXDATA3

SELECT C.LVY_RPER_TIN AS 법인번호, C.LE_TIN AS 개인번호, SUM(C.누적과세입니다) AS 개인별누적과세금
FROM
(
    SELECT B.*,
           CASE WHEN B.년차=1 THEN LAG(B.과세, B.과세, B.과세) 
           OVER(PARTITION BY B.LE_TIN ORDER BY B.ATRR_YR) ELSE B.과세 END AS 누적과세입니다
    FROM
        (       
        SELECT A.*, NVL(ATRR_YR-전년도,0) AS 년차
        FROM
        (
            SELECT LVY_RPER_TIN, LE_TIN,ATRR_YR, SUM(TXTN_TRGT_SNW_AMT) AS 과세,
                   LAG(ATRR_YR) OVER(PARTITION BY LE_TIN ORDER BY ATRR_YR) AS 전년도
            FROM 
            TEXDATA3
            GROUP BY  LVY_RPER_TIN, LE_TIN,ATRR_YR
            ORDER BY ATRR_YR ASC 
        )A
    )B
)C 
GROUP BY C.LVY_RPER_TIN, C.LE_TIN


SELECT * FROM TEXDATA3

