--------------------------------------------------------------------------------
----------------------------------RECTEAM---------------------------------------
--------------------------------------------------------------------------------
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES((SELECT NVL(MAX(pNUM),0)+1 FROM PROJECT),'차량내 소음 측정','2023-01-01','2023-06-06','차량내에서 소음 측정');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES((SELECT NVL(MAX(pNUM),0)+1 FROM PROJECT),'가정환경 음성녹음','2022-08-01','2023-08-01','가정환경 내에서 음성 녹음');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES((SELECT NVL(MAX(pNUM),0)+1 FROM PROJECT),'길거리 노이즈 수집','2023-05-01','2023-06-01','길거리 노이즈 수집');
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES((SELECT NVL(MAX(pNUM),0)+1 FROM PROJECT),'END','2022-05-01','2023-01-01','TEST');



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
    VALUES('PMPARK3','1','박지성','PROJECT_MANAGER');
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

--------------------------------------------------------------------------------
----------------------------------MEMBER----------------------------------------
--------------------------------------------------------------------------------

INSERT INTO MEMBER (mID, mPW, mNAME, pNUM, mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT) 
    VALUES('aaa', '1', '김녹음', 1, '1990-06-06', 'M', '010-0101-0101', 'N',
        '경기도', 'N', NULL, NULL, NULL, 1, '우리', '1002-33-11-2341');

INSERT INTO MEMBER (mID, mPW, mNAME, pNUM, mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT) 
    VALUES('bbb', '1', '박박박', 1, '1988-01-04', 'F', '010-0222-1121', 'N',
        '서울', 'Y', '09:00', '13:00', NULL, 5, '농혐', '1002-3312-2341');

INSERT INTO MEMBER (mID, mPW, mNAME, pNUM, mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT) 
    VALUES('ccc', '1', 'BOB', 1, '1973-04-05', 'M', '010-1111-3301', 'I',
        '경기도', 'Y', '17:30', NULL, NULL, 1, 'CITY', '1002-1134-1234');

INSERT INTO MEMBER (mID, mPW, mNAME,pNUMREG, mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT) 
    VALUES('ddd', '1', 'LISA',2,'1994-02-08', 'F', '010-1234-0555', 'I',
        '서울', 'N', NULL, NULL, NULL, 0, '농협', '1002-12-115553');

INSERT INTO MEMBER (mID, mPW, mNAME,pNUM,mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT) 
    VALUES('asdf', '1', '박이김', 3, '1992-07-11', 'M', '010-4444-0128', 'N',
        '경기도', 'N', NULL, NULL, NULL, 0, '우리', '1002-44-512');
        
INSERT INTO MEMBER (mID, mPW, mNAME,pNUM,mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT) 
    VALUES('kik', '1', '최고', 2, '1992-07-11', 'M', '010-4123-7432', 'N',
        '경기도', 'N', NULL, NULL, NULL, 0, '국민', '1002-51262-512');

INSERT INTO MEMBER (mID, mPW, mNAME, pNUMREG,mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT) 
    VALUES('dgga', '1', '최고',2, '1992-07-11', 'M', '010-4123-7432', 'N',
        '경기도', 'N', NULL, NULL, NULL, 2, '국민', '1002-51262-512');
        
INSERT INTO MEMBER (mID, mPW, mNAME,mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT) 
    VALUES('qwer', '1', '최고', '1992-07-11', 'M', '010-4123-7432', 'N',
        '경기도', 'N', NULL, NULL, NULL, 7, '국민', '1002-51262-512');

INSERT INTO MEMBER (mID, mPW, mNAME,pNUMREG, mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, rCNT, mBANK, mACCOUNT) 
    VALUES('gasdf', '1', '최고',3,  '1992-07-11', 'M', '010-4123-7432', 'N',
        '경기도', 'N', NULL, NULL, NULL, 8, '국민', '1002-51262-512');

--------------------------------------------------------------------------------
----------------------------------FREEBOARD-------------------------------------
--------------------------------------------------------------------------------

INSERT INTO FREEBOARD (fNUM, mID, rID, fTITLE, fCONTENT, fRDATE, fIP)
VALUES ((SELECT NVL(MAX(fNUM),0)+1 FROM FREEBOARD), 'aaa',NULL,'원글1', '내용1',SYSDATE, '192.168.0.1');

INSERT INTO FREEBOARD (fNUM, mID, rID, fTITLE, fCONTENT, fRDATE, fIP)
VALUES ((SELECT NVL(MAX(fNUM),0)+1 FROM FREEBOARD), NULL, 'PMKIM1', '원글2', '내용2', SYSDATE, '192.168.0.2');

INSERT INTO FREEBOARD (fNUM, mID, rID, fTITLE, fCONTENT, fRDATE, fIP)
VALUES ((SELECT NVL(MAX(fNUM),0)+1 FROM FREEBOARD), 'bbb', NULL, '원글3', '내용3', SYSDATE, '192.168.0.3');

INSERT INTO FREEBOARD (fNUM, mID, rID, fTITLE, fCONTENT, fRDATE, fIP)
VALUES ((SELECT NVL(MAX(fNUM),0)+1 FROM FREEBOARD), 'ccc', NULL, '원글4', '내용4', SYSDATE, '192.168.0.4');

--------------------------------------------------------------------------------
----------------------------------FREEBOARD_REPLY-------------------------------
--------------------------------------------------------------------------------

INSERT INTO FREEBOARD_REPLY (frNUM, mID, rID, frCONTENT, frRDATE, frIP,fNUM)
VALUES ((SELECT NVL(MAX(frNUM),0)+1 FROM FREEBOARD_REPLY), 'bbb', NULL, '댓글1', SYSDATE, '192.168.0.1',1);

INSERT INTO FREEBOARD_REPLY (frNUM, mID, rID, frCONTENT, frRDATE, frIP,fNUM)
VALUES ((SELECT NVL(MAX(frNUM),0)+1 FROM FREEBOARD_REPLY), 'ccc', NULL, '글1-댓글2', SYSDATE, '192.168.0.4',1);

INSERT INTO FREEBOARD_REPLY (frNUM, mID, rID, frCONTENT, frRDATE, frIP,fNUM)
VALUES ((SELECT NVL(MAX(frNUM),0)+1 FROM FREEBOARD_REPLY), 'ccc', NULL, '글2-댓글1', SYSDATE, '192.168.0.4',2);

INSERT INTO FREEBOARD_REPLY (frNUM, mID, rID, frCONTENT, frRDATE, frIP,fNUM)
VALUES ((SELECT NVL(MAX(frNUM),0)+1 FROM FREEBOARD_REPLY), 'ccc', NULL, '글1-댓글3', SYSDATE, '192.168.0.4',1);

--------------------------------------------------------------------------------
----------------------------------UPLOADBOARD-----------------------------------
--------------------------------------------------------------------------------

INSERT INTO UPLOADBOARD (uNUM, rID, uTITLE, uCONTENT, uFILENAME,
        uRDATE, uIP, uGROUP, uSTEP, uINDENT)
VALUES ((SELECT NVL(MAX(uNUM),0)+1 FROM UPLOADBOARD), 'PMKIM1', '업로드 제목1', '업로드 내용1', NULL, 
        SYSDATE, '192.168.0.4', (SELECT NVL(MAX(uNUM),0)+1 FROM UPLOADBOARD), 0, 0);

INSERT INTO UPLOADBOARD (uNUM, rID, uTITLE, uCONTENT, uFILENAME,
        uRDATE, uIP, uGROUP, uSTEP, uINDENT)
VALUES ((SELECT NVL(MAX(uNUM),0)+1 FROM UPLOADBOARD), 'PMHONG2', '업로드 제목2', '업로드 내용2', 'NOIMG.JGP',
        SYSDATE, '192.148.0.1', (SELECT NVL(MAX(uNUM),0)+1 FROM UPLOADBOARD), 0, 0);

INSERT INTO UPLOADBOARD (uNUM, rID, uTITLE, uCONTENT, uFILENAME,
        uRDATE, uIP, uGROUP, uSTEP, uINDENT)
VALUES ((SELECT NVL(MAX(uNUM),0)+1 FROM UPLOADBOARD), 'PMPARK3', '글1의 답변글1', '답변 내용1', NULL, 
        SYSDATE, '192.168.0.2', 1, 1, 1);
        
INSERT INTO UPLOADBOARD (uNUM, rID, uTITLE, uCONTENT, uFILENAME,
        uRDATE, uIP, uGROUP, uSTEP, uINDENT)
VALUES ((SELECT NVL(MAX(uNUM),0)+1 FROM UPLOADBOARD), 'OP1', '업로드 제목3', '업로드 내용1', 'NOIMG.JPG', 
        SYSDATE, '192.0.0.2', (SELECT NVL(MAX(uNUM),0)+1 FROM UPLOADBOARD), 0, 0);

INSERT INTO UPLOADBOARD (uNUM, rID, uTITLE, uCONTENT, uFILENAME,
        uRDATE, uIP, uGROUP, uSTEP, uINDENT)
VALUES ((SELECT NVL(MAX(uNUM),0)+1 FROM UPLOADBOARD), 'PMKIM1', '글3의 답변글1', '답변 내용1', NULL, 
        SYSDATE, '192.168.0.4', 4, 1, 1);
        
COMMIT;
SELECT * FROM PROJECT;
SELECT * FROM RECTEAM;
SELECT * FROM MEMBER;
SELECT * FROM FREEBOARD;
SELECT * FROM FREEBOARD_REPLY;
SELECT * FROM UPLOADBOARD ORDER BY UGROUP DESC, USTEP;