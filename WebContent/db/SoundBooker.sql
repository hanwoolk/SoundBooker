--------------------------------------------------------------------------------
----------------------------------PROJECT---------------------------------------
--------------------------------------------------------------------------------
-- DROP & CREATE
DROP TABLE PROJECT CASCADE CONSTRAINTS;
CREATE TABLE PROJECT(
    pNUM        NUMBER(3)       PRIMARY KEY,
    pNAME       VARCHAR2(100)   NOT NULL,
    pSTARTDATE  DATE            NOT NULL,
    pENDDATE    DATE            NOT NULL,
    pMEMBER     NUMBER(4)       DEFAULT 0 NOT NULL,
    pOP         NUMBER(2)       DEFAULT 0 NOT NULL,
    pCONTENT    CLOB            NOT NULL,
    pRDATE      DATE            DEFAULT SYSDATE NOT NULL
);

--------------------------------------------------------------------------------
----------------------------------RECTEAM---------------------------------------
--------------------------------------------------------------------------------
-- DROP & CREATE

DROP TABLE RECTEAM CASCADE CONSTRAINTS;
CREATE TABLE RECTEAM(
    rID     VARCHAR2(30)    PRIMARY KEY,
    rPW     VARCHAR2(30)    NOT NULL,
    rNAME   VARCHAR2(30)    NOT NULL,
    rJOB    VARCHAR2(30)    NOT NULL,
    pNUM    NUMBER(3),
    FOREIGN KEY (pNUM) REFERENCES PROJECT(pNUM)
);

--------------------------------------------------------------------------------
----------------------------------MEMBER----------------------------------------
--------------------------------------------------------------------------------
-- DROP & CREATE
DROP TABLE MEMBER CASCADE CONSTRAINTS;
CREATE TABLE MEMBER(
    mID         VARCHAR2(30)    PRIMARY KEY,
    mPW         VARCHAR2(30)    NOT NULL,
    mNAME       VARCHAR2(30)    NOT NULL,
    pNUM        NUMBER(3),
    pNUMREG     NUMBER(3),
    mBIRTH      DATE            NOT NULL,
    mGENDER     VARCHAR2(30)    NOT NULL,
    mPHONE      VARCHAR2(30)    NOT NULL,
    mORIGIN     VARCHAR2(30)    NOT NULL,
    mADDRESS    VARCHAR2(100),
    mDRIVE      VARCHAR2(30),
    mPREFER1    VARCHAR2(30),
    mPREFER2    VARCHAR2(30),
    mPREFER3    VARCHAR2(30),
    rCNT        NUMBER(3)       DEFAULT 0 NOT NULL,
    mBANK       VARCHAR2(30)    NOT NULL,
    mACCOUNT    VARCHAR2(30)    NOT NULL,
    mACTIVATE    VARCHAR2(10)    NOT NULL,
    FOREIGN KEY(pNUM) REFERENCES PROJECT(pNUM)
);

--------------------------------------------------------------------------------
----------------------------------FREEBOARD------------------------------------
--------------------------------------------------------------------------------
-- DROP & CREATE
DROP TABLE FREEBOARD CASCADE CONSTRAINTS;
CREATE TABLE FREEBOARD(
    fNUM        NUMBER(4)       PRIMARY KEY,
    mID         VARCHAR2(30),
    rID         VARCHAR2(30),
    fTITLE      VARCHAR2(100)   NOT NULL,
    fCONTENT    CLOB,
    fRDATE      DATE            DEFAULT SYSDATE NOT NULL,
    fIP         VARCHAR2(30)    NOT NULL,
    FOREIGN KEY (mID) REFERENCES MEMBER(mID),
    FOREIGN KEY (rID) REFERENCES RECTEAM(rID)
);

--------------------------------------------------------------------------------
----------------------------------FREEBOARD_REPLY-------------------------------
--------------------------------------------------------------------------------
-- DROP & CREATE
DROP TABLE FREEBOARD_REPLY CASCADE CONSTRAINTS;
CREATE TABLE FREEBOARD_REPLY(
    frNUM       NUMBER(4)       PRIMARY KEY,
    mID         VARCHAR2(30),
    rID         VARCHAR2(30),
    frCONTENT   CLOB            NOT NULL,
    frRDATE     DATE            DEFAULT SYSDATE NOT NULL,
    frIP        VARCHAR2(30)    NOT NULL,
    fNUM        NUMBER(4)       NOT NULL,
    FOREIGN KEY (mID) REFERENCES MEMBER(mID),
    FOREIGN KEY (rID) REFERENCES RECTEAM(rID),
    FOREIGN KEY (fNUM) REFERENCES FREEBOARD(fNUM)
);

--------------------------------------------------------------------------------
----------------------------------UPLOADBOARD------------------------------------
--------------------------------------------------------------------------------
-- DROP & CREATE
DROP TABLE UPLOADBOARD CASCADE CONSTRAINTS;
CREATE TABLE UPLOADBOARD(
    uNUM        NUMBER(4)       PRIMARY KEY,
    rID         VARCHAR2(30)    NOT NULL,
    uTITLE      VARCHAR2(100)   NOT NULL,
    uCONTENT    CLOB,
    uFILENAME   VARCHAR2(100),
    uRDATE      DATE            DEFAULT SYSDATE NOT NULL,
    uIP         VARCHAR2(30)    NOT NULL,
    uGROUP      NUMBER(4)       NOT NULL,
    uSTEP       NUMBER(2)       NOT NULL,
    uINDENT     NUMBER(1)       NOT NULL,
    FOREIGN KEY (rID) REFERENCES RECTEAM(rID)
);

--------------------------------------------------------------------------------
----------------------------------UPLOADBOARD_REPLY-----------------------------
--------------------------------------------------------------------------------
-- DROP & CREATE
DROP TABLE UPLOADBOARD_REPLY CASCADE CONSTRAINTS;
CREATE TABLE UPLOADBOARD_REPLY(
    urNUM       NUMBER(4)       PRIMARY KEY,
    rID         VARCHAR2(30),
    urCONTENT   CLOB            NOT NULL,
    urRDATE     DATE            DEFAULT SYSDATE NOT NULL,
    urIP        VARCHAR2(30)    NOT NULL,
    uNUM        NUMBER(4)       NOT NULL,
    FOREIGN KEY (rID) REFERENCES RECTEAM(rID),
    FOREIGN KEY (uNUM) REFERENCES UPLOADBOARD(uNUM)
);






