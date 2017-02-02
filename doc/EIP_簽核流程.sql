-- 加班單顯示，只要途程中有包含登入帳號就顯示，如果簽核途程為登入帳號才顯示簽核按鈕
--加班單
SELECT B.FLOWID,B.SUBJECT,B.EMP_ID,B.SENDDATE,B.DOCID,C.SIGNDATE,C.REPLY,A.DEPID ,
dbo.SF_GETDEPT(A.EMPLYID) DEPTNM,C.SITEID,dbo.SF_GETEMPNAME(C.EMPLYID)  "簽核人",dbo.SF_GETEMPNAME(A.EMPLYID) "申請人",
A.STATUS as "加班單",B.STATUS AS "主檔",C.STATUS AS "明細",A.DEMIN,A.REHRS,A.OVRTNO,A.FETB,A.FETE
FROM HRSDBR53.dbo.HR_OVRTM A
LEFT OUTER JOIN WF_SIGNM B ON A.OVRTNO = (B.DOCID collate Chinese_Taiwan_Stroke_CI_AS)
LEFT OUTER JOIN WF_SIGND C ON B.SIGNID = C.SIGNID
WHERE  1= 1
--AND A.EMPLYID = 'B040802' AND A.DEPID = 'B70'
--AND A.STATUS = 'SN' AND B.STATUS = 'SN' AND C.STATUS = 'CF'
AND A.OVRTNO LIKE 'OT170116050%' ORDER BY B.DOCID,C.SITEID

SELECT *
FROM HRSDBR53.dbo.HR_OVRTM_TEST
WHERE 1=1 --STATUS = 'SN' 
AND OVRTNO = 'OT170112115' 

SELECT * 
FROM WF_SIGNM
WHERE DOCID in ('OT170111112')

SELECT * FROM WF_SIGND
WHERE SIGNID in (
  SELECT SIGNID  FROM WF_SIGNM  WHERE DOCID in ('OT170111021')
) ORDER BY SIGNSID,SITEID ;

SELECT * FROM WF_SIGND
WHERE PSID in (
  SELECT SID  FROM WF_SIGNM  WHERE DOCID in ('OT170111112')
) ORDER BY SID,SITEID ;

--產生簽核途程
DECLARE @return_value int;
EXEC  @return_value = SP_GEN_SIGNROUTE
    @OVRTNO = 'OT161220099';
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
    HAVING COUNT(SIGNID)>=3
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
SELECT B.RULEID,B.DECSR,C.SITE,A.ROLENM,B.DEPID,A.DEP_NM, A.EMPLYID8,A.EMP8_NM,A.EMPLYID9,A.EMP9_NM, A.SIGNEMPLYID1, A.SIGNEMPLYID1NM, A.SIGNEMPLYID2, A.SIGNEMPLYID2NM, 
A.SIGNEMPLYID3, A.SIGNEMPLYID3NM, A.SIGNEMPLYID4, A.SIGNEMPLYID4NM, A.PROXY1ID, A.PROXY1NM, A.PROXY2ID, A.PROXY2NM, A.PROXY3ID, A.PROXY3NM
 FROM EIP.dbo.VIEW_WF_SIGNER1 A LEFT OUTER JOIN WF_DEPTMAP B ON A.DEP_NO = B.DEPID collate Chinese_Taiwan_Stroke_CI_AS
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


SELECT C.SID,B.SID,B.FLOWID,B.SUBJECT,B.SENDDATE,B.DOCID,C.SIGNDATE,C.REPLY,A.DEPID ,dbo.SF_GETDEPT(A.EMPLYID) DEPTNM,C.SITEID,dbo.SF_GETEMPNAME(C.EMPLYID)  "簽核人", --dbo.SF_GETEMPNAME(A.EMPLYID) "申請人",
A.STATUS as "加班單",B.STATUS AS "主檔",C.STATUS AS "明細",A.DEMIN,A.REHRS,A.OVRTNO,A.FETB,A.FETE
FROM HRSDBR53.dbo.HR_OVRTM A
LEFT OUTER JOIN WF_SIGNM B ON A.OVRTNO = (B.DOCID collate Chinese_Taiwan_Stroke_CI_AS)
LEFT OUTER JOIN WF_SIGND C ON B.SID = C.PSID
WHERE  1= 1
--AND A.EMPLYID = 'B040802' AND A.DEPID = 'B70'
--AND A.STATUS = 'SN' AND B.STATUS = 'SN' AND C.STATUS = 'CF'
AND A.OVRTNO LIKE 'OT161230001%' ORDER BY B.DOCID,C.SITEID

--主管檢視代簽核列表
SELECT B.SID,B.FLOWID,'加班單' FLOWNM,B.DOCID,A.MRDT,B.SUBJECT,B.EMP_ID,B.SENDDATE,A.DEPID ,
dbo.SF_GETDEPT(A.EMPLYID) DEPTNM,A.EMPLYID,dbo.SF_GETEMPNAME(A.EMPLYID) EMPLYNM,
C.EMPLYID AS SIGNEMPID,dbo.SF_GETEMPNAME(C.EMPLYID) SIGNEMPNM,C.STATUS,C.SITEID
FROM HRSDBR53.dbo.HR_OVRTM_TEST A
LEFT OUTER JOIN WF_SIGNM B ON A.OVRTNO = (B.DOCID collate Chinese_Taiwan_Stroke_CI_AS)
LEFT OUTER JOIN WF_SIGND C ON B.SID = C.PSID
WHERE  1 = 1
AND C.EMPLYID = 'A970701' --AND A.DEPID = 'B70'

--AND A.STATUS = 'SN'
--AND A.OVRTNO LIKE 'OT1701%' 
ORDER BY A.MRDT ,B.DOCID DESC

--簽核途程
SELECT A.OVRTNO,C.SITEID,A.DEPID,dbo.SF_GETDEPT(C.EMPLYID) DEPTNM,C.EMPLYID,dbo.SF_GETEMPNAME(C.EMPLYID)  EMPLYNM,C.REPLY,
CASE WHEN C.STATUS = 'OP' THEN '未送簽' WHEN  C.STATUS = 'SN' THEN '簽核中' 
WHEN  C.STATUS = 'CF' THEN '已核准' WHEN  C.STATUS = 'CL' THEN '已退回' 
WHEN  C.STATUS = 'NL' THEN '已作廢' WHEN  C.STATUS = 'PB' THEN '撤簽' END AS SIGN_STATUS ,convert(varchar(10), C.SIGNDATE, 111) AS SIGNDATE
--INTO  WF_SIGNROUTE 
FROM HRSDBR53.dbo.HR_OVRTM_TEST A
LEFT OUTER JOIN WF_SIGNM B ON A.OVRTNO = (B.DOCID collate Chinese_Taiwan_Stroke_CI_AS)
LEFT OUTER JOIN WF_SIGND C ON B.SID = C.PSID
WHERE  1= 1
AND A.OVRTNO LIKE 'OT170116050%' 
ORDER BY A.OVRTNO DESC,C.SITEID

