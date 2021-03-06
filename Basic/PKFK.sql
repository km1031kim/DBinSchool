CREATE USER KOPO4_KM1031KIM
IDENTIFIED BY KM1031KIM

GRANT CONNECT, RESOURCE, DBA TO KOPO4_KM1031KIM


CREATE TABLE KOPO_PRODUCT_VOLUME_JG (
CUSTOMER_ID VARCHAR2(100),
CUSTOMER_STATE VARCHAR2(100),
EMAIL_CNT NUMBER,
constraints pk_kopo_product_volume_jg primary key (CUSTOMER_ID)
)

INSERT INTO KOPO_PRODUCT_VOLUME_JG VALUES('A011', '광진구', 5);

DROP TABLE KOPO_PRODUCT_VOLUME_JG



-- 자식테이블
CREATE TABLE KOPO_PRODUCT_VOLUME_JG(
REGIONID VARCHAR2(100),
PRODUCTID VARCHAR2(100),
YEARWEEK VARCHAR2(100),
QTY NUMBER,
EVENTCODE VARCHAR2(100),
constraints pk_kopo_product_volume_jg primary key (REGIONID, PRODUCTID, YEARWEEK),
constraints fk_kopo_product_volume_jg foreign key (EVENTCODE) references EVENT_MGMT_JG(EVENT_ID) 
)

INSERT INTO KOPO_PRODUCT_VOLUME_JG VALUES('A01','ST0001','202002',101, 'EV0002');

DELETE FROM KOPO_PRODUCT_VOLUME_JG 
WHERE EVENTCODE = 'EV0002'


SELECT * FROM KOPO_PRODUCT_VOLUME_JG



-- 이벤트 관리 테이블 (pk: event_id)
-- 부모테이블
CREATE TABLE EVENT_MGMT_JG(
EVENT_ID VARCHAR2(100),
EVENT_PERIODS VARCHAR2(100),
DISCOUNT_PERCENT NUMBER,
constraints pk_event_mgmt_jg primary key (event_ID)
)

DELETE FROM EVENT_MGMT_JG 
WHERE EVENT_ID = 'EV0002'
 

INSERT INTO EVENT_MGMT_JG VALUES('EV0002',201503,0.5);



INSERT INTO KOPO_PRODUCT_VOLUME_JG VALUES('A02','STOOO2','202002', 101,'EVOOO3');


DROP TABLE EVENT_MGMT_JG





CREATE TABLE KOPO_PRODUCT_VOLUME
( REGIONID  VARCHAR(30), 
  PRODUCTGROUP VARCHAR(30),
  YEARWEEK NUMBER,
  VOLUME NUMBER 
  )
  
 SELECT * FROM KOPO_PRODUCT_VOLUME
 

 UPDATE KOPO_PRODUCT_VOLUME
 SET YEARWEEK = '201513'
 WHERE 1=1
 AND YEARWEEK =  '201512'
 AND PRODUCTGROUP = 'ST0001'
 
 
 
 
 CREATE TABLE KOPO_EVENT_INFO_FOREIGN(
 eventid  VARCHAR2(20),
 EVENTPERIOD VARCHAR2(20),
 PROMOTION_RATIO NUMBER,
 constraint pk_kopo_event_info_foreign primary key (eventid))
 
 CREATE TABLE KOPO_PRODUCT_VOLUME_FOREIGN (
 REGIONID VARCHAR2(20),
 PRODUCTGROUP VARCHAR2(20),
 YEARWEEK VARCHAR2(8),
 NOLUME NUMBER NOT NULL,
 EVENTID VARCHAR2(20),
 constraint pk_kopo_product_volume_foreign primary key(REGIONID, PRODUCTGROUP, YEARWEEK),
 constraint fk_kopo_product_volume_foreign foreign key(EVENTID) references kopo_event_info_foreign(eventid))
 
 INSERT INTO KOPO_PRODUCT_VOLUME_FOREIGN
 VALUES ('A01', 'ST00002', '20151', 55, 'EVTEST')
 
 
 
 #자식키
 
 SELECT * FROM KOPO_PRODUCT_VOLUME_FOREIGN 
 
 #자식키 안 외래키를 변경해보자
 
 UPDATE KOPO_PRODUCT_VOLUME_FOREIGN
 SET EVENTID = 'DKDJD'
 WHERE 1=1

 
 #부모키
 SELECT * FROM KOPO_EVENT_INFO_FOREIGN
 
 
 INSERT INTO KOPO_EVENT_INFO_FOREIGN
 VALUES ('EVTEST', '455', 50)
 
 
 
 
 
 






-- 제약 끊기





INSERT INTO KOPO_KJG (USER_ID, PASSWORD) VALUES ('HAITEAM', '7777')


INSERT INTO KOPO_CONSUMER_KJG (USERID, BIRTH) VALUES('HAITEAM','111111')

INSERT INTO KOPO_SELLER_KJG (USERID, COMPANY) VALUES('HAITEAM','KOPO_SCHOOL_1')

SELECT * FROM KOPO_SELLER_KJG

SELECT * FROM KOPO_CONSUMER_KJG

SELECT * FROM KOPO_KJG

DELETE FROM KOPO_KJG
WHERE USER_ID = 'HAITEAM'


-- ALTER TABLE [테이블명] DROP CONSTRAINT FK 이름
ALTER TABLE KOPO_SELLER_KJG DROP CONSTRAINT FK_KOPO_SELLER_KJG



ALTER TABLE KOPO_CONSUMER 
ADD CONSTRAINT FK_KOPO_CONSUMER_KJG FOREGN KEY(USERiD) REFERENCES KOPO_KJG (USER_ID) ON DELETE CASCADE



-- 데이터 조회

SELECT (USER_ID), (PASSWORD) FROM KOPO_KJG_R



-- 데이터 내용 직접적으로 삽입
INSERT INTO KOPO_KJG_R
SELECT * FROM KOPO_KJG_P


SELECT * FROM KOPO_KJG_R





CREATE TABLE KOPO_KJG_R
(
    USER_ID VARCHAR2(100),
    PASSWORD VARCHAR2(100),
    NAME VARCHAR2(100),
    EMAIL VARCHAR2(100),
    PHONE VARCHAR2(100),
    ADDRESS VARCHAR2(100)
  )
  
  
 INSERT INTO KOPO_KJG_R (USER_ID) VALUES ('KJG')
 
 
 SELECT * FROM KOPO_PRODUCT_VOLUME2
 
 


