--加班單
SELECT B.SIGNID,B.FLOWID,B.SUBJECT,B.EMP_ID,B.SENDDATE,B.DOCID,C.SIGNDATE,C.REPLY,A.DEPID ,dbo.SF_GETDEPT(A.EMPLYID) DEPTNM,C.SITEID,dbo.SF_GETEMPNAME(c.EMPLYID)  "簽核人",dbo.SF_GETEMPNAME(A.EMPLYID) "申請人",A.STATUS,B.STATUS,C.STATUS,A.DEMIN,A.REHRS,A.OVRTNO,A.FETB,A.FETE
FROM HRSDBR53.dbo.HR_OVRTM A
LEFT OUTER JOIN WF_SIGNM B ON A.OVRTNO = (B.DOCID collate Chinese_Taiwan_Stroke_CI_AS)
LEFT OUTER JOIN WF_SIGND C ON B.SIGNID = C.SIGNID
WHERE  1= 1
--AND A.EMPLYID = 'B040802' AND A.DEPID = 'N02'
--AND A.STATUS = 'CF' AND C.STATUS = 'SN'
AND A.OVRTNO LIKE 'OT161214072%' ORDER BY C.SITEID

SELECT *
FROM HRSDBR53.dbo.HR_OVRTM 
WHERE 1=1 --STATUS = 'SN' 
AND OVRTNO = 'OT161214072' 

SELECT * 
FROM WF_SIGNM
WHERE DOCID in ('OT161214072')

SELECT * FROM WF_SIGND
WHERE SIGNID in (
  SELECT SIGNID   FROM WF_SIGNM  WHERE DOCID in ('OT161214076')
) ORDER BY SIGNID,SITEID ;




--產生簽核途程
DECLARE @return_value int;
EXEC  @return_value = SP_GEN_SIGNROUTE 
    @OVRTNO = 'OT161214072';
SELECT @return_value as N'@Return Value';
GO

SELECT *
 FROM HRSDBR53.dbo.HR_EMPLYM
 WHERE DEPID = 'P00' AND C_STA = 'A';
 

 
 
-- 簽核途程超過3層
SELECT * ,dbo.SF_GETDEPT(EMP_ID)
FROM WF_SIGNM
WHERE 1=1 AND DOCID like 'OT1612%' AND STATUS = 'SN' --AND FINISHDATE IS NULL
AND SIGNID in (
  SELECT SIGNID 
  FROM WF_SIGND
  WHERE SIGNID in (       
    SELECT SIGNID
    FROM WF_SIGND
    GROUP BY SIGNID
    HAVING COUNT(SIGNID)=2
  )
)

--測試用
SELECT * ,dbo.SF_GETDEPT(EMP_ID)
FROM WF_SIGNM_TEST
WHERE FINISHDATE IS NULL
AND SIGNID in (
  SELECT SIGNID 
  FROM WF_SIGND_TEST
  WHERE SIGNID in (       
    SELECT SIGNID
    FROM WF_SIGND
    GROUP BY SIGNID
    HAVING COUNT(SIGNID)>2
  )
)

--DELETE WF_DEPTMAP;
DBCC CHECKIDENT ('[WF_DEPTMAP]', RESEED, 0);
GO

INSERT INTO WF_DEPTMAP(DEPID,RULEID,DECSR)
SELECT DEPID,'RULE_2SITE','簽核途程2層'
FROM HRSDBR53..HR_DEP 

--部門對應主管
SELECT B.DEPID,B.RULEID,B.DECSR,C.SITE,A.ROLENM,A.DEP_NM, A.EMPLYID8,A.EMP_NM,A.EMPLYID9,  A.SIGNEMPLYID1, A.SIGNEMPLYID1NM, A.SIGNEMPLYID2, A.SIGNEMPLYID2NM, 
A.SIGNEMPLYID3, A.SIGNEMPLYID3NM, A.SIGNEMPLYID4, A.SIGNEMPLYID4NM, A.PROXY1ID, A.PROXY1NM, A.PROXY2ID, A.PROXY2NM, A.PROXY3ID, A.PROXY3NM
 FROM EIP01.dbo.VIEW_WF_SIGNER1 A LEFT OUTER JOIN WF_DEPTMAP B ON A.DEP_NO = B.DEPID 
 LEFT OUTER JOIN WF_RULEM C ON B.RULEID = C.RULEID
 
-- 部門對應規則
SELECT A.DEPID,A.RULEID,B.RULENM,B.SITE
FROM WF_DEPTMAP A INNER JOIN WF_RULEM B ON A.RULEID = B.RULEID
WHERE A.DEPID = 'C00'

--部門別
SELECT *
FROM HRSDBR53..HR_DEP

-- 員工
SELECT * FROM V_HR_EMPLYM
WHERE EMPLYID = 'B050301'

-- 員工所屬部門 , C00
SELECT DPRTID, PDEPNM, PEMPLYID, PEMPLYNM, DEPID, DEPNM, EMPLYID, EMPLYNM
 FROM EIP.dbo.V_HR_DEPTREE
 WHERE 1=1
AND EMPLYID = 'B050503' 
 AND DPRTID <> DEPID

SELECT * 
FROM HRSDBR53..HR_EMPLYM
WHERE EMPLYID = 'B050502'

--部門對應規則 RULE_2
SELECT SID, DEPID, RULEID, ORDID,DECSR
 FROM EIP01_TEST..WF_DEPTMAP
 WHERE DEPID = 'N05'  
 
--規則 1> 8 > 2
SELECT M.SID,M.RULEID, M.RULENM, M.DECSR,
      D.PRULEID, D.SITE, D.ROLEID
 FROM EIP..WF_RULEM M,EIP..WF_RULED D
 WHERE M.RULEID = D.PRULEID
AND M.RULEID = 'RULE_1'
 
 --單據流程
SELECT M.FLOWID, M.FLOWNM, M.FLOWDSC, M.DEACT, M.DB, M.TABLENM,M.SID,
        D.SITEID,D.ROLEID
 FROM EIP..WF_FLOWM M LEFT JOIN EIP..WF_FLOWD D ON M.FLOWID = D.FLOWID 
WHERE M.FLOWID = 5

--角色 
SELECT M.ROLEID, M.ROLENM, M.REMARK,
       D.DEP_NO, D.EMPLYID8,E.EMPLYNM, D.ACTIVE, D.ASSIGNDATE, D.PROXY1, D.PROXY2,D.PROXY3
 FROM EIP..WF_ROLEM M LEFT JOIN EIP..WF_ROLED D ON M.ROLEID = D.ROLEID
 LEFT JOIN HRSDBR53..HR_EMPLYM E ON D.EMPLYID8 = (E.EMPLYID collate Chinese_Taiwan_Stroke_CI_AS)
 WHERE ACTIVE = 'Y' 
 AND M.ROLEID IN (8)
 AND D.DEP_NO = 'C00'

--複製表格
SELECT *
INTO WF_DEPTMAP
FROM EIP01_TEST..WF_DEPTMAP
 
SELECT *
INTO WF_RULEM
FROM EIP01_TEST..WF_RULEM

SELECT M.FLOWID, M.FLOWNM, M.FLOWDSC, M.DEACT, M.DB, M.TABLENM,M.SID,
        D.SITEID,D.ROLEID
        ,E.ROLENM, E.REMARK,
        E.DEP_NO, E.EMPLYID8,dbo.SF_EMP_NAME(E.EMPLYID8) EMPLYNM, E.ACTIVE, E.ASSIGNDATE,
        E.PROXY1,dbo.SF_EMP_NAME(E.PROXY1) EMPLYNM_1, 
        E.PROXY2,dbo.SF_EMP_NAME(E.PROXY2) EMPLYNM_2,
        E.PROXY3,dbo.SF_EMP_NAME(E.PROXY3) EMPLYNM_3
 FROM EIP..WF_FLOWM M LEFT JOIN EIP..WF_FLOWD D ON M.FLOWID = D.FLOWID 
 LEFT JOIN (
    SELECT M.ROLEID, M.ROLENM, M.REMARK,
         D.DEP_NO, D.EMPLYID8, D.ACTIVE, D.ASSIGNDATE, D.PROXY1, D.PROXY2,D.PROXY3
    FROM EIP..WF_ROLEM M LEFT JOIN EIP..WF_ROLED D ON M.ROLEID = D.ROLEID
    WHERE ACTIVE = 'Y' 
 ) E ON D.ROLEID = E.ROLEID
 WHERE M.FLOWID = 5  --加班單
 AND (E.DEP_NO='C00' OR E.DEP_NO='M00' OR E.DEP_NO IS NULL)
 

--待簽核列表 
 WITH DepList(DEPID,Lev,TopDept) AS (
     select DEPID ,1 as Lev,CONVERT(nvarchar(128),DEPID)
     from HRSDBR53..HR_DEP 
     union all 
     select m.DEPID,(d.Lev+1) as Lev,
      CONVERT(nvarchar(128), RTRIM(d.TopDept))
     from  HRSDBR53..HR_DEP m
     inner join DepList d on m.DPRTID=d.DEPID and m.DEPID <> m.DPRTID
    )
    SELECT DISTINCT A.OVRTNO, A.EMPLYID,--EIP.dbo.SF_EMP_NAME(A.EMPLYID) EMPLYNM, 
    A.APPDATE, A.MRDT,A.FETB,A.FETE, 
    RIGHT(REPLICATE('0', 2) + CAST(Datepart(hh,A.FETB) as NVARCHAR), 2)+ ':' +RIGHT(REPLICATE('0', 2) + CAST(Datepart(n,A.FETB) as NVARCHAR), 2) AS FETB_TIME, 
    CONVERT(smalldatetime,CONVERT(CHAR(10),A.FETE, 111)) AS FETE_DATE,
    RIGHT(REPLICATE('0', 2) + CAST(Datepart(hh,A.FETE) as NVARCHAR), 2)+ ':' +RIGHT(REPLICATE('0', 2) + CAST(Datepart(n,A.FETE) as NVARCHAR), 2) AS FETE_TIME, 
    A.DETB, A.DETE, A.DEMIN, A.REHRS, A.LNO, A.DEREASON, A.STATUS, A.DEPID, A.EXC_INSDBID, A.EXC_INSDATE, A.DEPIDAPP,   
    A.OTTP, A.REHRS1,B.SENDDATE,B.FINISHDATE FROM HRSDBR53..HR_OVRTM A 
    LEFT JOIN EIP01..WF_SIGNM B ON A.OVRTNO=B.DOCID COLLATE Chinese_Taiwan_Stroke_CI_AS 
    WHERE (A.EMPLYID='B020503'
    OR A.DEPIDAPP in (
      select DEPID from DepList Where TopDept in (
      SELECT C.DEP_NO  COLLATE Chinese_Taiwan_Stroke_CI_AS FROM EIP01..PU_PERMISSION_PROGRAM A
      JOIN EIP01..PU_PERMISSION_PRGMROLE B ON A.SID=B.PRGMID
      JOIN EIP01..WF_ROLED C ON C.ROLEID=B.ROLEID
      WHERE Program_ID='HR_OverTime' AND C.EMPLYID8='B020503'
     )
    )
    or A.DEPIDAPP in (
     select DEPID from DepList Where TopDept in (
      SELECT DEPID FROM HRSDBR53..HR_DEP WHERE EMPLYID='B020503'
     )
    )) ORDER BY OVRTNO DESC


-- RUN SP
DECLARE @return_value int;
EXEC  @return_value = EIP01.dbo.SP_GEN_SIGNROUTE 
    @OVRTNO = 'OT161208109';
SELECT @return_value as N'@Return Value';
GO

--光華電腦資料庫使用
--加班單
SELECT B.*,C.* ,dbo.SF_GETEMPNAME(c.EMPLYID)  "簽核人",dbo.SF_GETEMPNAME(A.EMPLYID) "申請人",A.*
FROM HRSDBR53.dbo.HR_OVRTM A
LEFT OUTER JOIN WF_SIGNM B ON A.OVRTNO = (B.DOCID collate Chinese_Taiwan_Stroke_CI_AS)
LEFT OUTER JOIN WF_SIGND C ON B.SIGNID = C.SIGNID
WHERE  1= 1
AND A.OVRTNO = 'OT161208108' 
--AND A.STATUS = 'OP'

-- 途程主檔
SELECT * 
FROM WF_SIGNM
WHERE DOCID = 'OT161208108';

-- 途程明細
SELECT * ,dbo.SF_GETEMPNAME(EMPLYID)
FROM WF_SIGND
WHERE SIGNID = 29433;

SELECT dbo.SF_GETEMPNAME('B021201')