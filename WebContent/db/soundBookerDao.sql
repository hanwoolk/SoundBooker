-------------------------------------------------------------------------------
-------------------------------- MemberDao query--------------------------------
-------------------------------------------------------------------------------

-- dao에 들어갈 query
-- (1) 회원id 중복체크
SELECT * FROM MEMBER WHERE MID='aaa';
-- (2) 회원가입
INSERT INTO MEMBER (mID, mPW, mNAME, pNUM,mBIRTH, mGENDER, mPHONE, mORIGIN,
        mADDRESS, mDRIVE, mPREFER1, mPREFER2, mPREFER3, mBANK, mACCOUNT) 
    VALUES('fff', '1', '이기자',NULL,'1991-02-05', 'M', '010-1221-3101', 'N',
        '경기도', 'N', NULL, NULL, NULL, '우리', '1002-1134-1234');
COMMIT;
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
-- (6)회원 리스트(TOP-N) -- 프로젝트 없는 사람중 경험 많은 순
SELECT *
    FROM (SELECT ROWNUM RN, A.* FROM(SELECT * FROM MEMBER ORDER BY PNUM DESC,  RCNT DESC) A)
    WHERE RN BETWEEN 1 AND 10;
-- (7) 전체 등록된 회원수
SELECT COUNT(*) CNT FROM MEMBER;
-- (8) 회원탈퇴
DELETE FROM MEMBER WHERE MID='aaa';
COMMIT;

-------------------------------------------------------------------------------
-------------------------------- RecteamDao query------------------------------
-------------------------------------------------------------------------------
-- dao에 들어갈 query
--------- 공통
-- (1) 로그인
SELECT * FROM RECTEAM WHERE rID='OP5' and rPW='1';

-- (2) rid로 dto가져오기(로그인 성공시 session에 넣기 위함)
SELECT * FROM RECTEAM WHERE rID='PMKIM1';    
    
    
---------프로젝트 관리자
-- (1) id 중복체크
SELECT * FROM RECTEAM WHERE rID='OP4';
-- (2) 작업자 등록
INSERT INTO RECTEAM (rID, rPW, rNAME, rJOB) 
    VALUES('OP5', '1', '박진영','OPERATOR');
COMMIT;
-- (3) 작업자 정보 수정
UPDATE RECTEAM 
    SET RPW       = '1',
        RNAME     = '송중기'
    WHERE RID = 'OP5';
-- (4) 작업자 삭제
DELETE FROM RECTEAM WHERE rID = 'OP1';

SELECT * FROM RECTEAM;
-- (4) 프로젝트 목록(최신 등록순)
SELECT *
    FROM (SELECT ROWNUM RN, A.* FROM(SELECT * FROM PROJECT ORDER BY PNUM DESC) A)
    WHERE RN BETWEEN 1 AND 10;
-- (5) 프로젝트 검색
SELECT * FROM PROJECT WHERE pNAME LIKE '%'||'차량'||'%';
-- (5) 프로젝트 상세보기
SELECT * FROM PROJECT WHERE PNUM=1;
-- (6) 작업자 프로젝트 퇴출
UPDATE RECTEAM SET PNUM = NULL WHERE RID = 'OP3';
-- (7) 작업자 프로젝트 배치
UPDATE RECTEAM SET PNUM = 2 WHERE RID = 'OP3' AND PNUM IS NULL;
-- (8) 프로젝트 완료시(전체 member rcnt +1씩, 멤버 ,직원 PNUM => NULL로, PROJECT PNUM=>0으로)
UPDATE MEMBER SET rCNT = rCNT +1 WHERE PNUM=1;
UPDATE RECTEAM SET PNUM = NULL WHERE PNUM = 1;
UPDATE MEMBER SET PNUM = NULL WHERE PNUM = 1;
UPDATE PROJECT SET PNUM = 0 WHERE PNUM=1;
-- (9) 날짜 지난 프로젝트 PNUM = 0 으로 변경()
UPDATE PROJECT SET PNUM = 0 WHERE SYSDATE>PENDDATE;
SELECT * FROM PROJECT;

---------일정 관리자

-- (1)MEMBER 리스트(TOP-N)
SELECT * FROM RECTEAM ORDER BY pNUM DESC; -- 프로젝트 없는사람부터
SELECT *
    FROM (SELECT ROWNUM RN, A.* FROM(SELECT * FROM RECTEAM ORDER BY pNUM DESC) A)
    WHERE RN BETWEEN 1 AND 10;
-- (2) 신청한 신청자들 등록으로 (pNUMREG => pNUM)
UPDATE MEMBER SET pNUM = pNUMREG , pNUMREG=NULL WHERE mID = 'ddd' AND pNUM IS NULL;
ROLLBACK;
-- (3) 신청자 프로젝트 중 퇴출
UPDATE MEMBER SET PNUM = NULL WHERE mID = 'ddd';
-- (4) 전체 등록된 회원수
SELECT COUNT(*) CNT FROM MEMBER;

---------녹음 작업자

-- (4) 프로젝트 목록(최신 등록순)
SELECT *
    FROM (SELECT ROWNUM RN, A.* FROM(SELECT * FROM PROJECT ORDER BY PNUM DESC) A)
    WHERE RN BETWEEN 1 AND 10;
-- (2) 자신의 진행중 프로젝트
SELECT R.PNUM PNUM, PNAME, PSTARTDATE, PENDDATE, PMEMBER, POP, PCONTENT, PRDATE
    FROM PROJECT P, RECTEAM R WHERE R.PNUM = P.PNUM AND rID='OP3';













-- (1) 글 목록(startRow ~ endRow)
SELECT * 
    FROM (SELECT ROWNUM RN, A.* 
        FROM (SELECT * 
            FROM FILEBOARD ORDER BY FGROUP DESC, FSTEP) A)
    WHERE RN BETWEEN 1 AND 3;
-- (2) 글 갯수
SELECT COUNT(*) FROM FILEBOARD;
-- (3) 글 쓰기(원글쓰기)
INSERT INTO FILEBOARD (fID, mID, fTITLE, fCONTENT, fFILENAME,
    fRDATE, fHIT, fGROUP, fSTEP, fINDENT, fIP)
    VALUES ((SELECT NVL(MAX(fID),0)+1 FROM FILEBOARD), 'go','글 제목','본문',
    'NOIMAGE.JPG',null,0,(SELECT NVL(MAX(fID),0)+1 FROM FILEBOARD),0,0,'192.0.0.1');
-- (4) hit 1회 올리기
UPDATE FILEBOARD SET fHIT = fHIT+1 WHERE fID = 1;
-- (5) 글 번호(fid)로 글전체 내용(BoardDto) 가져오기
SELECT MNAME, M.MID MID, FTITLE, FCONTENT, FFILENAME , FRDATE, FHIT, FGROUP, FSTEP ,FINDENT ,FIP FROM FILEBOARD F, MVC_MEMBER M WHERE F.mID = M.mID AND fID = 100;
-- (6) 글 수정하기(fid, ftitle, fcontent, ffilename, frdate(SYSDATE), fip 수정)
UPDATE FILEBOARD SET ftitle     = '수정된 제목',
                     fcontent   = NULL,
                     ffilename  = 'kim.JPG',
                     fip        = '190.0.0.1'
            WHERE fID = 1;
-- (7) 글 삭제하기(fid로)
DELETE FROM FILEBOARD WHERE fID = 1;
ROLLBACK;
-- (8) 답변글 쓰기 전 단계(원글의 fgroup과 같고, 원글의 fstep보다 크면 fstep을 하나 증가하기)
UPDATE FILEBOARD SET FSTEP = FSTEP + 1 WHERE FGROUP = 2 AND FSTEP > 0;
-- (9) 답변글 쓰기
INSERT INTO FILEBOARD (fID, mID, fTITLE, fCONTENT, fFILENAME,
    fRDATE, fHIT, fGROUP, fSTEP, fINDENT, fIP)
    VALUES ((SELECT NVL(MAX(fID),0)+1 FROM FILEBOARD), 'go','글 제목','본문',
    'NOIMAGE.JPG',null,0,1,1,1,'192.0.0.1');
-- (10) 회원탈퇴(mid로 작성글 삭제) return값 void
DELETE FROM FILEBOARD WHERE MID = 'go';
ROLLBACK;
COMMIT;

-------------------------------------------------------------------------------
-------------------------------- AdminDao query--------------------------------
-------------------------------------------------------------------------------

-- (1) admin 로그인
SELECT * FROM ADMIN WHERE aID = 'admin' AND aPW = 1;
-- (2) 로그인 후 세션에 넣을 AdiminDto 를 admin aid로 가져오기
SELECT * FROM ADMIN WHERE aID = 'admin';




