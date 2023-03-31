--------------------------------------------------------------------------------
----------------------------------PROJECT---------------------------------------
--------------------------------------------------------------------------------
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES(1,'차량내 소음 측정','2023-01-01','2023-06-06','차량내에서 소음 측정');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT, pSTATUS) 
    VALUES(2,'길거리 노이즈 수집','2021-05-01','2022-06-01','길거리 노이즈 수집(초회차)', '완료');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES(3,'가정환경 음성녹음','2022-08-01','2023-08-01','가정환경 내에서 음성 녹음');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES(4,'길거리 노이즈 수집','2023-05-01','2023-06-01','길거리 노이즈 수집');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT, pSTATUS) 
    VALUES(5,'END','2022-05-01','2023-01-01','TEST','완료');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES(6,'길거리 노이즈 수집 경기','2023-05-01','2023-06-01','거주지:겅기');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES(7,'길거리 노이즈 수집 서울','2023-05-01','2023-06-01','거주지:서울');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES(8,'길거리 노이즈 수집 성남','2023-05-01','2023-06-01','거주지:성남');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES(9,'가정환경 음성녹음 아파트','2022-08-01','2023-08-01','주거형태:아파트, 유자녀 우대');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES(10,'가정환경 음성녹음 빌라','2022-08-01','2023-08-01','주거형태:아파트, 유자녀 우대');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES(11,'가정환경 음성녹음 오피스텔','2022-08-01','2023-08-01','주거형태:아파트, 무자녀 우대');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES(12,'가정환경 음성녹음 옥탑','2022-08-01','2023-08-01','주거형태:아파트, 유자녀 우대');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES(13,'길거리 노이즈 수집(도보)','2023-05-01','2023-06-01','거주지:경기도');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES(14,'길거리 노이즈 수집(전동킥보드)','2023-05-01','2023-06-01','거주지:서울');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES(15,'길거리 노이즈 수집(자전거)','2023-05-01','2023-06-01','거주지:경기도');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES(16,'일상대화(영어)','2023-05-01','2023-06-01','출신지:미국,영국');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES(17,'일상대화(영어)','2023-05-01','2023-06-01','출신지:중국,몽골');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES(18,'일상대화(영어)','2023-05-01','2023-06-01','출신지:필리핀,대만');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES(19,'일상대화(일어)','2023-05-01','2023-06-01','출신지:일본');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES(20,'일상대화(일어)','2023-05-01','2023-06-01','출신지:한국,중국');
--------------------------------------------------------------------------------
----------------------------------RECTEAM---------------------------------------
--------------------------------------------------------------------------------
INSERT INTO RECTEAM (rID, rPW, rNAME, rJOB,pNUM) 
    VALUES('PMKIM1','1','김한울','PROJECT_MANAGER',1);
INSERT INTO RECTEAM (rID, rPW, rNAME, rJOB,pNUM) 
    VALUES('PMHONG2','1','홍길동','PROJECT_MANAGER',2);
INSERT INTO RECTEAM (rID, rPW, rNAME, rJOB,pNUM) 
    VALUES('PMPARK3','1','박지성','PROJECT_MANAGER',3);
INSERT INTO RECTEAM (rID, rPW, rNAME, rJOB) 
    VALUES('PMPARK4','1','박싸이','PROJECT_MANAGER');
INSERT INTO RECTEAM (rID, rPW, rNAME, rJOB) 
    VALUES('SCH','1','김스케','SCHEDULER');
INSERT INTO RECTEAM (rID, rPW, rNAME, rJOB,pNUM) 
    VALUES('OP1','1','김오피','OPERATOR',1);
INSERT INTO RECTEAM (rID, rPW, rNAME, rJOB,pNUM) 
    VALUES('OP2','1','박오피','OPERATOR',2);
INSERT INTO RECTEAM (rID, rPW, rNAME, rJOB,pNUM) 
    VALUES('OP3','1','최오피','OPERATOR',1);
INSERT INTO RECTEAM (rID, rPW, rNAME, rJOB) 
    VALUES('OP4','1','김오피','OPERATOR');
INSERT INTO RECTEAM (rID, rPW, rNAME, rJOB) 
    VALUES('OP5','0','0','OPERATOR');
INSERT INTO RECTEAM (rID, rPW, rNAME, rJOB) 
    VALUES('OP6','0','0','OPERATOR');
INSERT INTO RECTEAM (rID, rPW, rNAME, rJOB) 
    VALUES('OP7','0','0','OPERATOR');
INSERT INTO RECTEAM (rID, rPW, rNAME, rJOB) 
    VALUES('OP8','0','0','OPERATOR');

--------------------------------------------------------------------------------
----------------------------------MEMBER----------------------------------------
--------------------------------------------------------------------------------

INSERT INTO MEMBER (mID, mPW, mNAME, pNUM, mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT, mACTIVATE) 
    VALUES('aaa', '1', '김녹음', 1, '1990-06-06', 'M', '010-0101-0101', 'N',
        '경기도', 'N', NULL, NULL, NULL, 1, '우리', '1002-33-11-2341', 'ON');

INSERT INTO MEMBER (mID, mPW, mNAME, pNUM, mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT, mACTIVATE) 
    VALUES('bbb', '1', '박박박', 1, '1988-01-04', 'F', '010-0222-1121', 'N',
        '서울', 'Y', '09:00', '13:00', NULL, 5, '농혐', '1002-3312-2341', 'ON');

INSERT INTO MEMBER (mID, mPW, mNAME, pNUM, mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT, mACTIVATE) 
    VALUES('ccc', '1', 'BOB', 1, '1973-04-05', 'M', '010-1111-3301', 'I',
        '경기도', 'Y', '17:30', NULL, NULL, 1, 'CITY', '1002-1134-1234', 'ON');

INSERT INTO MEMBER (mID, mPW, mNAME,pNUMREG, mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT, mACTIVATE) 
    VALUES('ddd', '1', 'LISA',2,'1994-02-08', 'F', '010-1234-0555', 'I',
        '서울', 'N', NULL, NULL, NULL, 0, '농협', '1002-12-115553', 'ON');

INSERT INTO MEMBER (mID, mPW, mNAME,pNUM,mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT, mACTIVATE) 
    VALUES('asdf', '1', '박이김', 3, '1992-07-11', 'M', '010-4444-0128', 'N',
        '경기도', 'N', NULL, NULL, NULL, 0, '우리', '1002-44-512', 'ON');
        
INSERT INTO MEMBER (mID, mPW, mNAME,pNUM,mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT, mACTIVATE) 
    VALUES('kik', '1', '최고', 2, '1992-07-11', 'M', '010-4123-7432', 'N',
        '경기도', 'N', NULL, NULL, NULL, 0, '국민', '1002-51262-512', 'ON');

INSERT INTO MEMBER (mID, mPW, mNAME, pNUMREG,mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT, mACTIVATE) 
    VALUES('dgga', '1', '최고',2, '1992-07-11', 'M', '010-4123-7432', 'N',
        '경기도', 'N', NULL, NULL, NULL, 2, '국민', '1002-51262-512', 'ON');
        
INSERT INTO MEMBER (mID, mPW, mNAME,mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT, mACTIVATE) 
    VALUES('qwer', '1', '최고', '1992-07-11', 'M', '010-4123-7432', 'N',
        '경기도', 'N', NULL, NULL, NULL, 7, '국민', '1002-51262-512', 'ON');

INSERT INTO MEMBER (mID, mPW, mNAME,pNUMREG, mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT, mACTIVATE) 
    VALUES('gasdf', '1', '최고',3,  '1992-07-11', 'M', '010-4123-7432', 'N',
        '경기도', 'N', NULL, NULL, NULL, 8, '국민', '1002-51262-512', 'ON');

INSERT INTO MEMBER (mID, mPW, mNAME,pNUMREG, mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT, mACTIVATE) 
    VALUES('km', '1', '김민',2,  '1991-05-17', 'M', '010-6135-8376', 'N',
        '경기도', 'N', NULL, NULL, NULL, 1, '우리', '10-51126-836', 'OFF');
--------------------------------------------------------------------------------
----------------------------------FREEBOARD-------------------------------------
--------------------------------------------------------------------------------

INSERT INTO FREEBOARD (fNUM, mID, rID, fTITLE, fCONTENT, fRDATE, fIP)
VALUES (1, 'aaa',NULL,'원글1', '내용1',SYSDATE, '192.168.0.1');

INSERT INTO FREEBOARD (fNUM, mID, rID, fTITLE, fCONTENT, fRDATE, fIP)
VALUES (2, NULL, 'PMKIM1', '원글2', '내용2', SYSDATE, '192.168.0.2');

INSERT INTO FREEBOARD (fNUM, mID, rID, fTITLE, fCONTENT, fRDATE, fIP)
VALUES (3, 'bbb', NULL, '원글3', '내용3', SYSDATE, '192.168.0.3');

INSERT INTO FREEBOARD (fNUM, mID, rID, fTITLE, fCONTENT, fRDATE, fIP)
VALUES (4, 'ccc', NULL, '원글4', '내용4', SYSDATE, '192.168.0.4');

--------------------------------------------------------------------------------
----------------------------------FREEBOARD_COMMENT-------------------------------
--------------------------------------------------------------------------------

INSERT INTO FREEBOARD_COMMENT (frNUM, mID, rID, frCONTENT, frRDATE, frIP,fNUM)
VALUES (1 , 'bbb', NULL, '댓글1', SYSDATE, '192.168.0.1',1);

INSERT INTO FREEBOARD_COMMENT (frNUM, mID, rID, frCONTENT, frRDATE, frIP,fNUM)
VALUES (2 , 'ccc', NULL, '글1-댓글2', SYSDATE, '192.168.0.4',1);

INSERT INTO FREEBOARD_COMMENT (frNUM, mID, rID, frCONTENT, frRDATE, frIP,fNUM)
VALUES (3 , 'ccc', NULL, '글2-댓글1', SYSDATE, '192.168.0.4',2);

INSERT INTO FREEBOARD_COMMENT (frNUM, mID, rID, frCONTENT, frRDATE, frIP,fNUM)
VALUES (4 , 'ccc', NULL, '글1-댓글3', SYSDATE, '192.168.0.4',1);

INSERT INTO FREEBOARD_COMMENT (frNUM, mID, rID, frCONTENT, frRDATE, frIP,fNUM)
VALUES (5 ,  NULL,'PMKIM1', '글1-댓글4', SYSDATE, '192.168.0.4',1);

--------------------------------------------------------------------------------
----------------------------------UPLOADBOARD-----------------------------------
--------------------------------------------------------------------------------

INSERT INTO UPLOADBOARD (uNUM, rID, uTITLE, uCONTENT, uFILENAME,
        uRDATE, uIP, uGROUP, uSTEP, uINDENT)
VALUES (1, 'PMKIM1', '업로드 제목1', '업로드 내용1', NULL, 
        SYSDATE, '192.168.0.4', 1, 0, 0);

INSERT INTO UPLOADBOARD (uNUM, rID, uTITLE, uCONTENT, uFILENAME,
        uRDATE, uIP, uGROUP, uSTEP, uINDENT)
VALUES (2, 'PMHONG2', '업로드 제목2', '업로드 내용2', 'NOIMG.JGP',
        SYSDATE, '192.148.0.1', 2, 0, 0);

INSERT INTO UPLOADBOARD (uNUM, rID, uTITLE, uCONTENT, uFILENAME,
        uRDATE, uIP, uGROUP, uSTEP, uINDENT)
VALUES (3, 'PMPARK3', '글1의 답변글1', '답변 내용1', NULL, 
        SYSDATE, '192.168.0.2', 1, 1, 1);
        
INSERT INTO UPLOADBOARD (uNUM, rID, uTITLE, uCONTENT, uFILENAME,
        uRDATE, uIP, uGROUP, uSTEP, uINDENT)
VALUES (4, 'OP1', '업로드 제목3', '업로드 내용1', 'NOIMG.JPG', 
        SYSDATE, '192.0.0.2', 4, 0, 0);

INSERT INTO UPLOADBOARD (uNUM, rID, uTITLE, uCONTENT, uFILENAME,
        uRDATE, uIP, uGROUP, uSTEP, uINDENT)
VALUES (5, 'PMKIM1', '글3의 답변글1', '답변 내용1', NULL, 
        SYSDATE, '192.168.0.4', 4, 1, 1);
--------------------------------------------------------------------------------
----------------------------------UPLOADBOARD-----------------------------------
--------------------------------------------------------------------------------
INSERT INTO UPLOADBOARD_COMMENT (urNUM, rID, urCONTENT, urRDATE, urIP,uNUM)
VALUES (1 , 'PMKIM1', '글1-댓글1', SYSDATE, '192.168.0.4',1);

INSERT INTO UPLOADBOARD_COMMENT (urNUM, rID, urCONTENT, urRDATE, urIP,uNUM)
VALUES (2 , 'OP1', '글1-댓글1', SYSDATE, '192.168.0.4',1);

INSERT INTO UPLOADBOARD_COMMENT (urNUM, rID, urCONTENT, urRDATE, urIP,uNUM)
VALUES (3 , 'PMHONG2', '글1-댓글1', SYSDATE, '192.168.0.4',1);

INSERT INTO UPLOADBOARD_COMMENT (urNUM, rID, urCONTENT, urRDATE, urIP,uNUM)
VALUES (4 , 'OP3', '글1-댓글1', SYSDATE, '192.168.0.4',1);

INSERT INTO UPLOADBOARD_COMMENT (urNUM, rID, urCONTENT, urRDATE, urIP,uNUM)
VALUES (5 , 'PMKIM1', '글1-댓글1', SYSDATE, '192.168.0.4',2);


SELECT * FROM UPLOADBOARD_COMMENT;


COMMIT;
SELECT rID FROM RECTEAM WHERE rNAME='0' AND rJOB='OPERATOR' ORDER BY  TO_NUMBER(SUBSTR(rID,3));

SELECT * FROM RECTEAM;
SELECT * FROM MEMBER;
--SELECT * FROM FREEBOARD;
--SELECT * FROM FREEBOARD_COMMENT;
--SELECT * FROM UPLOADBOARD ORDER BY UGROUP DESC, USTEP;
--SELECT * FROM UPLOADBOARD_COMMENT;