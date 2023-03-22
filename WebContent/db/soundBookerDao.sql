-------------------------------------------------------------------------------
-------------------------------- MemberDao query--------------------------------
-------------------------------------------------------------------------------

-- dao에 들어갈 query
-- (1) 회원id 중복체크
SELECT * FROM MEMBER WHERE MID='aaa' AND MBIRTH = '900606' AND MNAME = '김녹음';
SELECT * FROM MEMBER WHERE ;
SELECT * FROM MEMBER WHERE ;
-- (2) 회원가입
INSERT INTO MEMBER (mID, mPW, mNAME, pNUM,mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, mBANK, mACCOUNT) 
    VALUES('fff', '1', '이기자',NULL,'1991-02-05', 'M', '010-1221-3101', 'N',
        '경기도', 'N', NULL, NULL, NULL, '우리', '1002-1134-1234');
COMMIT;
SELECT * FROM MEMBER WHERE MNAME = '김녹음' AND MPHONE='010-0101-0101';
-- (3) 로그인
SELECT * FROM MEMBER WHERE mID='aaa' and mPW='1';
-- (4) mid로 dto가져오기(로그인 성공시 session에 넣기 위함)
SELECT * FROM MEMBER WHERE MID='aaa';
-- (5) 회원 정보 수정
UPDATE MEMBER 
    SET MPW       = '1',
        MNAME     = '송중기',
        MPHONE    = '010-3333-3333',
        MADDRESS  = '서울시 서대문구',
        MDRIVE    = 'Y',
        MPREFER1  = '13:30',
        MPREFER2  = '14:00',
        MPREFER3  = '12:30',
        MBANK     = '농협',
        MACCOUNT  = '11-3341-2451'
    WHERE MID = 'fff';
-- (6) 프로젝트 신청
UPDATE MEMBER SET PNUMREG = 2
        WHERE MID = 'aaa';
-- (7) 신청 취소
UPDATE MEMBER SET PNUMREG = NULL
        WHERE MID = 'aaa';
-- (8) 전체 등록된 회원수
SELECT COUNT(*) CNT FROM MEMBER;


SELECT *
    FROM (SELECT ROWNUM RN, A.* FROM(SELECT * FROM MEMBER ORDER BY RCNT DESC) A)
    WHERE RN BETWEEN 1 AND 10;

-- (9) 회원탈퇴
UPDATE MEMBER SET mACTIVATE = 'OFF'
    WHERE mID ='aaa';
-- (10) 계정 활성화
UPDATE MEMBER SET mACTIVATE = 'ON'
    WHERE mID ='aaa' and mACTIVATE = 'OFF';
ROLLBACK;
COMMIT;

-------------------------------------------------------------------------------
-------------------------------- RecteamDao query------------------------------
-------------------------------------------------------------------------------
-- dao에 들어갈 query
--------------------------------------공통--------------------------------------
-- (1) 로그인
SELECT * FROM RECTEAM WHERE rID='OP5' and rPW='1';

-- (2) rID로 dto가져오기(로그인 성공시 session에 넣기 위함)
SELECT * FROM RECTEAM WHERE rID='PMKIM1';
    
    
--------------------------------프로젝트 관리자-----------------------------------
-- (1) 작업자 id 중복체크
SELECT * FROM RECTEAM WHERE rID='OP4' AND RNAME='김오피';
-- (2) 작업자 등록 & 작업자 정보 수정
UPDATE RECTEAM 
    SET RPW       = '1',
        RNAME     = '송중기'
    WHERE RID = 'OP5';
-- (3) 작업자 삭제
UPDATE UPLOADBOARD SET RID = '없는 회원'
    WHERE rID='OP1';
UPDATE UPLOADBOARD_COMMENT SET RID = '없는 회원'
    WHERE rID='OP1';
UPDATE FREEBOARD SET RID = '없는 회원'
    WHERE rID='OP1';
UPDATE FREEBOARD_COMMENT SET RID = '없는 회원'
    WHERE rID='OP1';
UPDATE RECTEAM SET rNAME = '0',
                   rPW   = '0'
            WHERE rID='OP1';
            
SELECT * FROM RECTEAM;
-- (4)프로젝트 등록
INSERT INTO PROJECT (pNUM, pNAME, pSTARTDATE, pENDDATE, pCONTENT) 
    VALUES((SELECT NVL(MAX(pNUM),0)+1 FROM PROJECT),'공원내 소음 측정2','2023-01-01','2023-08-30','공원내에서 소음 측정2');
-- (5) 프로젝트 수정
UPDATE PROJECT SET pNAME        = '버스내 소음 측정',
                   pSTARTDATE   = '23-03-21',
                   pENDDATE     = '23-05-22',
                   pCONTENT     = '버스내 소음 측정하는 프로젝트'
            WHERE PNUM = 3;
COMMIT;
ROLLBACK;
-- (10-1) 녹음 작업자 전체 수
SELECT COUNT(*) CNT FROM RECTEAM WHERE rJOB='OPERATOR';
-- (10-2) 녹음 작업자 리스트(TOP-N)-- 프로젝트 없는사람부터
SELECT *
    FROM (SELECT ROWNUM RN, A.* FROM(SELECT * FROM RECTEAM ORDER BY pNUM DESC) A)
    WHERE RN BETWEEN 1 AND 10 AND RJOB = 'OPERATOR'; 

-- (10-3) 녹음 작업자 리스트(TOP-N)-- 프로젝트 없는 녹음 작업자
SELECT *
    FROM (SELECT ROWNUM RN, A.* FROM(SELECT * FROM RECTEAM ORDER BY pNUM DESC) A)
    WHERE RN BETWEEN 1 AND 10 AND PNUM IS NULL AND RJOB = 'OPERATOR';

-- (10-4) 녹음 작업자 리스트(TOP-N)-- 해당 프로젝트 진행중인 녹음 작업자(PNUM)으로 검색
SELECT *
    FROM (SELECT ROWNUM RN, A.* FROM(SELECT * FROM RECTEAM ORDER BY pNUM DESC) A)
    WHERE RN BETWEEN 1 AND 10 AND PNUM = 1 AND RJOB = 'OPERATOR';
SELECT RID, RNAME, RJOB, P.PNAME
    FROM PROJECT P, RECTEAM R 
    WHERE P.PNUM = R.PNUM AND P.PNUM=1 AND RJOB = 'OPERATOR';
-- (11) 작업자 프로젝트 퇴출
UPDATE RECTEAM SET PNUM = NULL WHERE RID = 'OP3';
-- (12) 작업자 프로젝트 배치
UPDATE RECTEAM SET PNUM = 2 WHERE RID = 'OP3' AND PNUM IS NULL;
-- (13) 프로젝트 완료시(전체 member rcnt +1씩, 멤버 ,직원 PNUM => NULL로, PROJECT PNUM=>0으로)
UPDATE MEMBER SET rCNT = rCNT +1 WHERE PNUM=1;
UPDATE RECTEAM SET PNUM = NULL WHERE PNUM = 1;
UPDATE MEMBER SET PNUM = NULL WHERE PNUM = 1;
UPDATE PROJECT SET PNUM = 0 WHERE PNUM=1;


-----------------------------------일정 관리자------------------------------------

-- (1) 전체 등록된 회원수
SELECT COUNT(*) CNT FROM MEMBER WHERE PNUMREG = 2;
-- (2) MEMBER 리스트(TOP-N) -- 프로젝트 상세 페이지에서 신청한 사람중 프로젝트 없는 사람만 녹음횟수 순으로
SELECT *
    FROM (SELECT ROWNUM RN, A.* FROM(SELECT * FROM MEMBER WHERE PNUM IS NULL ORDER BY PNUM DESC,  RCNT DESC) A)
    WHERE RN BETWEEN 1 AND 10 AND PNUMREG = 2;
    
SELECT COUNT(*) CNT FROM MEMBER;
---
SELECT *
    FROM (SELECT ROWNUM RN, A.* 
        FROM(SELECT PNAME, P.PNUM PNUM,M.PNUM MPNUM,PNUMREG, MID, MNAME,
                MBIRTH, MGENDER, MPHONE, MORIGIN, MADDRESS, MDRIVE, MPREFER1,
                MPREFER2, MPREFER3, RCNT, MBANK, MACCOUNT 
            FROM MEMBER M, PROJECT P 
                WHERE P.PNUM = M.PNUMREG AND M.PNUM IS NULL AND MACTIVATE = 'ON'
                ORDER BY M.PNUM DESC, RCNT DESC) 
            A)
    WHERE RN BETWEEN 1 AND 10 AND PNUM = 2;
---
SELECT PNAME, P.PNUM PNUM,M.PNUM MPNUM,PNUMREG,PNAME, MID, MNAME,
        MBIRTH, MGENDER, MPHONE, MORIGIN, MADDRESS, MDRIVE, MPREFER1,
        MPREFER2, MPREFER3, RCNT, MBANK, MACCOUNT
    FROM MEMBER M, PROJECT P WHERE P.PNUM = M.PNUMREG AND M.PNUM IS NULL AND P.PNUM=2 ORDER BY M.PNUM DESC, RCNT DESC;
SELECT * FROM MEMBER;
-- (2-2) 프로젝트 상세보기에 들어갈 신청한 인원 (PNUM으로 검색)
SELECT M.*, P.PNUM PNUM, PNAME, PSTARTDATE, PENDDATE, PMEMBER, POP, PCONTENT, PRDATE, MID, M.PNUM "MPNUM",RCNT 
    FROM PROJECT P, MEMBER M 
    WHERE P.PNUM = M.PNUMREG AND P.PNUM  = 2;
-- (2-3)MEMBER 리스트(TOP-N) -- 전체(프로젝트 없는 사람 먼저, 녹음 횟수 많은순)
SELECT *
    FROM (SELECT ROWNUM RN, A.* FROM(SELECT * FROM MEMBER ORDER BY PNUM DESC,  RCNT DESC) A)
    WHERE RN BETWEEN 1 AND 10;
-- (3) 신청한 MEMBER 등록으로 (pNUMREG => pNUM)
UPDATE MEMBER SET pNUM    = pNUMREG , 
                  pNUMREG = NULL 
        WHERE mID = 'ddd' AND pNUM IS NULL;
                
ROLLBACK;
-- (4) 신청자 프로젝트 중 퇴출
UPDATE MEMBER SET PNUM = NULL WHERE mID = 'ddd';


-------------------------------------녹음 작업자----------------------------------

-- (1) 프로젝트 목록(최신 등록순)
SELECT *
    FROM (SELECT ROWNUM RN, A.* FROM(SELECT * FROM PROJECT ORDER BY PNUM DESC) A)
    WHERE RN BETWEEN 1 AND 10;
-- (2) 자신이 진행중인 프로젝트
SELECT R.PNUM PNUM, PNAME, PSTARTDATE, PENDDATE, PMEMBER, POP, PCONTENT, PRDATE
    FROM PROJECT P, RECTEAM R WHERE R.PNUM = P.PNUM AND rID='OP3';

-------------------------------------------------------------------------------
-------------------------------- UploadBoard query------------------------------
-------------------------------------------------------------------------------
-- (1) 글 목록(startRow ~ endRow)
SELECT * 
    FROM (SELECT ROWNUM RN, A.* 
        FROM (SELECT * 
            FROM UPLOADBOARD ORDER BY UGROUP DESC, USTEP) A)
    WHERE RN BETWEEN 1 AND 3;
-- (2) 글 갯수
SELECT COUNT(*) FROM UPLOADBOARD;
-- (3) 글 쓰기(원글쓰기)
INSERT INTO UPLOADBOARD (uNUM, rID, uTITLE, uCONTENT, uFILENAME,
        uIP, uGROUP, uSTEP, uINDENT)
VALUES ((SELECT NVL(MAX(uNUM),0)+1 FROM UPLOADBOARD), 'PMKIM1', '업로드 제목1', '업로드 내용1', NULL, 
        '192.168.0.4', (SELECT NVL(MAX(uNUM),0)+1 FROM UPLOADBOARD), 0, 0);

-- (4) 글 번호(unum)로 글전체 내용(BoardDto) 가져오기
SELECT uNUM, rID, uTITLE, uCONTENT, uFILENAME, uRDATE, uIP
    FROM UPLOADBOARD WHERE uNUM = 3;
-- (5) 글 수정하기(unum, utitle, ucontent, ufilename, uip 수정)
UPDATE UPLOADBOARD SET uTITLE     = '수정된 제목',
                       uCONTENT   = NULL,
                       uFILENAME  = 'kim.JPG',
                       uIP        = '190.0.0.1'
            WHERE uNUM = 3;
ROLLBACK;
-- (6-1) 글 삭제하기 댓글 삭제(unum로)
DELETE FROM UPLOADBOARD_COMMENT WHERE uNUM = 1;
-- (6-2) 글 삭제하기(unum로)
DELETE FROM UPLOADBOARD WHERE uNUM = 1;

ROLLBACK;
-- (7) 답변글 쓰기 전 단계(원글의 ugroup과 같고, 원글의 ustep보다 크면 ustep을 하나 증가하기)
UPDATE UPLOADBOARD SET uSTEP = uSTEP + 1 WHERE uGROUP = 2 AND uSTEP > 0;
-- (8) 답변글 쓰기

INSERT INTO UPLOADBOARD (uNUM, rID, uTITLE, uCONTENT, uFILENAME,
        uIP, uGROUP, uSTEP, uINDENT)
VALUES ((SELECT NVL(MAX(uNUM),0)+1 FROM UPLOADBOARD), 'PMKIM1', '답변 제목1', '답변 내용1', NULL, 
        '192.168.0.4', 1, 1, 1);
-- (9) 댓글 가져오기


-------------------------------------------------------------------------------
-------------------------------- UploadBoard_COMMENT query-----------------------
-------------------------------------------------------------------------------
-- (1) 댓글 달기
INSERT INTO UPLOADBOARD_COMMENT (urNUM, rID, urCONTENT,
        urIP,uNUM)
VALUES ((SELECT NVL(MAX(urNUM),0)+1 FROM UPLOADBOARD_COMMENT), 'PMKIM1', '댓글 내용2',
        '192.168.0.4',1);
-- (2) 댓글 전체 목록(최신순)
SELECT * FROM UPLOADBOARD_COMMENT WHERE uNUM = 1 ORDER BY urRDATE DESC;
-------------------------------------------------------------------------------
-------------------------------- FreeBoard query------------------------------
-------------------------------------------------------------------------------
-- (1) 글 목록(startRow ~ endRow)
SELECT * 
    FROM (SELECT ROWNUM RN, A.* 
        FROM (SELECT * 
            FROM FREEBOARD ORDER BY FRDATE DESC) A)
    WHERE RN BETWEEN 1 AND 3;
SELECT V.*, 
  (SELECT MNAME FROM MEMBER WHERE V.mID=mID) MNAME,
  (SELECT RNAME FROM RECTEAM WHERE V.rID=rID) RNAME
  FROM (SELECT ROWNUM RN, B.* 
        FROM (SELECT * FROM FREEBOARD ORDER BY fRDATE DESC) B) V
  WHERE RN BETWEEN 1 AND 4;
-- (2) 글 갯수
SELECT COUNT(*) FROM FREEBOARD;
-- (3) 글 쓰기(원글쓰기)
INSERT INTO FREEBOARD (fNUM, mID, rID, fTITLE, fCONTENT, fIP)
VALUES ((SELECT NVL(MAX(fNUM),0)+1 FROM FREEBOARD), NULL,'PMKIM1', '원글 제목5', '원글 내용5', '192.168.0.4');

COMMIT;
-- (5) 글 번호(uid)로 글전체 내용(BoardDto) 가져오기
SELECT V.*, 
  (SELECT mID FROM MEMBER WHERE V.mID=mID) mID,
  (SELECT rID FROM RECTEAM WHERE V.rID=rID) rID
  FROM (SELECT * FROM FREEBOARD ORDER BY fRDATE DESC) V
  WHERE fNUM=2;
  
-- (6) 글 수정하기(fid, ftitle, fcontent, frdate(SYSDATE), fip 수정)
UPDATE FREEBOARD SET fTITLE     = '수정된 제목',
                     fCONTENT   = NULL,
                     fIP        = '190.0.0.1'
            WHERE fNUM = 1;
ROLLBACK;
-- (7) 글 삭제하기(fNUM로)
DELETE FROM FREEBOARD_COMMENT WHERE fNUM = 1;
DELETE FROM FREEBOARD WHERE fNUM = 1;
ROLLBACK;


-------------------------------------------------------------------------------
-------------------------------- FreeBoard_COMMENT query-----------------------
-------------------------------------------------------------------------------
--(1) 댓글달기
INSERT INTO FREEBOARD_COMMENT (frNUM, mID, rID, frCONTENT,
        frRDATE, frIP,fNUM)
VALUES ((SELECT NVL(MAX(frNUM),0)+1 FROM FREEBOARD_COMMENT), NULL, 'PMKIM1', '댓글 내용1',
        SYSDATE, '192.168.0.4',1);

-- (2) 댓글 전체 목록(최신순)
SELECT V.*, 
  (SELECT mID FROM MEMBER WHERE V.mID=mID) mID,
  (SELECT rID FROM RECTEAM WHERE V.rID=rID) rID
  FROM (SELECT ROWNUM RN, B.* 
        FROM (SELECT * FROM FREEBOARD_COMMENT ORDER BY frRDATE DESC) B) V
    WHERE fNUM = 1;
-------------------------------------------------------------------------------
-------------------------------- Project query---------------------------------
-------------------------------------------------------------------------------

-- (1-1) 진행중 프로젝트 목록(최신 등록순)
SELECT *
    FROM (SELECT ROWNUM RN, A.* FROM(SELECT * FROM PROJECT WHERE NOT PNUM IN (0) ORDER BY PRDATE DESC) A)
    WHERE RN BETWEEN 1 AND 10;
-- (1-2) 완료된 프로젝트 목록(최신 등록순)
SELECT *
    FROM (SELECT ROWNUM RN, A.* FROM(SELECT * FROM PROJECT WHERE PNUM = 0 ORDER BY PRDATE DESC) A)
    WHERE RN BETWEEN 1 AND 10;
-- (2-1) 진행중 프로젝트 갯수
SELECT COUNT(*) FROM PROJECT WHERE NOT PNUM IN (0);
-- (2-2) 완료 프로젝트 갯수
SELECT COUNT(*) FROM PROJECT WHERE PNUM = 0;
UPDATE PROJECT SET PNUM=0 WHERE PNUM=4;
-- (8) 프로젝트 검색
SELECT * FROM PROJECT WHERE LOWER(pNAME) LIKE '%'||LOWER('')||'%' AND NOT PNUM IN (0);
-- (9) 프로젝트 상세보기
SELECT * FROM PROJECT WHERE PNUM=1;