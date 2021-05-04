CREATE TABLE EXAM
(  SEG1 VARCHAR2(100),
   SEG2 VARCHAR2(100),
   SEG3 NUMBER,
   TARGETWEEK NUMBER,
   YEAR NUMBER,
   WEEK NUMBER,
   QTY NUMBER,
   FCST_W6 NUMBER,
   FCST_W5 NUMBER,
   FCST_W4 NUMBER,
   FCST_W3 NUMBER,
   FCST_W2 NUMBER,
   FCST_W1 NUMBER
 )
 
 
 
 



SELECT B.* 
FROM
(
   CASE WHEN B.FCST_W6 == 0 OR B.QTY == 0 THEN 0
        WHEN B B.QTY/B.FCST_W6 > 2, THEN 0 
        ELSE 1 - ABS(B.FCST_W6 - B.ACTUAL) / FCST_W6 END AS W6,

        SELECT A.*,
            ABS(A.FCST_W6 - A.QTY) AS W6,
            ABS(A.FCST_W5 - A.QTY) AS W5,
            ABS(A.FCST_W4 - A.QTY) AS W4,
            ABS(A.FCST_W3 - A.QTY) AS W3,
            ABS(A.FCST_W2 - A.QTY) AS W2,
            ABS(A.FCST_W1 - A.QTY) AS W1
            FROM EXAM A
            ORDER BY SEG2 ASC, SEG3 ASC
)B
 


--- DECODE (~��,~�ΰ�?,Ʈ���,�ƴϸ�)
   
SELECT A.GENDER,
      UPPER(A.GENDER) AS GENDER_NEW,
       DECODE(
            UPPER(A.GENDER),'MALE', 1, 0,
                            'FEMALE',2,0) AS GENDER_NEW
FROM KOPO_CUSTOMERDATA A






SELECT B.*,
   (CASE  WHEN (B.FCST_W6 = 0 OR B.QTY = 0) THEN 0
         WHEN (B.QTY/B.FCST_W6 > 2) THEN 0
         ELSE ROUND((1-ABS(B.FCST_W6 - B.QTY) / B.FCST_W6),9)   
         END) AS W6_1
         DECODE(W6_1,NULL,0,W6_1)
FROM
(        SELECT A.*,
         ABS(A.FCST_W6 - A.QTY) AS W6,
         ABS(A.FCST_W5 - A.QTY) AS W5,
         ABS(A.FCST_W4 - A.QTY) AS W4,
         ABS(A.FCST_W3 - A.QTY) AS W3,
         ABS(A.FCST_W2 - A.QTY) AS W2,
         ABS(A.FCST_W1 - A.QTY) AS W1
         FROM EXAM A
         ORDER BY SEG2 ASC, SEG3 ASC   
)B




SELECT A.*,
DECODE(

SELE
    





    
    
 ROUND((1 - ABS(FCST - ACTUAL) / FCST)*100,2) AS ACCURACY
FROM RMSE_MAE_EXAMPLE2 A
    

    

ALTER
REPLACE VALUE ('FCST_W6','W6') 
FROM EXAM
    
    