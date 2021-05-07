SELECT * FROM KOPO_CUSTOMERDATA

--AMOUNT의 평균을 구해보자
SELECT C.CUSTOMERCODE,
       C.TOTAL_AMOUNT / C.CNT_SUM AS AVG_AMOUNT
FROM
(
SELECT B.CUSTOMERCODE,
       B.ST,
       B.GENDER1,
       B.EMAIL,
       B.TOTAL_AMOUNT,
       AC_AMOUNT_CNT + AV_AMOUNT_CNT + HA_AMOUNT_CNT + EMI_CE_AMOUNT_CNT AS CNT_SUM
FROM 
(
SELECT CUSTOMERCODE,
       ST,
       DOB,
       GENDER1,
       EMAIL,
       FEST_CNT,
       TOTAL_AMOUNT,
       AC_AMOUNT,
       AV_AMOUNT,
       HA_AMOUNT,
       EMI_CE_AMOUNT,
       CASE WHEN AC_AMOUNT >= 0 THEN 1 END AS AC_AMOUNT_CNT,
       CASE WHEN AV_AMOUNT >= 0 THEN 1 END AS AV_AMOUNT_CNT,
       CASE WHEN HA_AMOUNT >= 0 THEN 1 END AS HA_AMOUNT_CNT,
       CASE WHEN EMI_CE_AMOUNT >= 0 THEN 1 END AS EMI_CE_AMOUNT_CNT
FROM
KOPO_CUSTOMERDATA
WHERE 1=1
AND GENDER = 'Male'
AND STATENAME = 'State2'
ORDER BY TOTAL_AMOUNT DESC
)B
)C
