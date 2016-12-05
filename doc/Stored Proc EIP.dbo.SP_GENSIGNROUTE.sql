/*
SELECT OVRTNO, APPDATE, MRDT, FETB, FETE, DETB, DETE, DEMIN, REHRS, LNO, OVRTP, DEREASON, STATUS, REM, DEPID, OTTP, OVT1, OVT2, OVT3, OWMON, EMPLYID, C_HLD, C_SOURCE, REHRS1, DEPIDAPP, FILFRL
 FROM HRSDBR53.dbo.HR_OVRTM
 WHERE EMPLYID = 'B050502'
 AND OVRTNO = 'OT161031027'
*/

ALTER PROCEDURE [dbo].[SP_GEN_SIGNROUTE]
(
@OVRTNO nvarchar(20),      --加班單號
@EMPID nvarchar(10)='',    --員工編號
@FLOWID int,               --單據別
@JOINSIGN nvarchar(1) = 'N'--是否為會簽      
)
WITH EXEC AS CALLER
AS
-- 定義變數
DECLARE @PEMPLYID nvarchar(50), @SITEID INT;

-- 加班單資料
DECLARE C2 CURSOR FOR
SELECT OVRTNO, APPDATE, MRDT, FETB, FETE, DETB, DETE, DEMIN, REHRS, LNO, OVRTP, DEREASON, STATUS, REM, DEPID, OTTP, OVT1, OVT2, OVT3, OWMON, EMPLYID, C_HLD, C_SOURCE, REHRS1, DEPIDAPP, FILFRL
 FROM HRSDBR53.dbo.HR_OVRTM
 WHERE EMPLYID = 'B050502'
 AND OVRTNO = 'OT161031027';

-- 簽核途程 
DECLARE C1 CURSOR FOR
SELECT C.SITEID,C.ROLEID
       /*A.DPRTID, A.PDEPNM, A.PEMPLYID, A.PEMPLYNM, A.DEPID, A.DEPNM, A.EMPLYID, A.EMPLYNM,
       B.RULEID, B.ORDID,B.DECSR,
       C.SITE, C.ROLEID*/
 FROM EIP.dbo.V_HR_DEPTREE A LEFT JOIN EIP..WF_DEPTMAP B ON A.DEPID = B.DEPID
  LEFT JOIN EIP..WF_RULED C ON B.RULEID = C.PRULEID
 WHERE 1=1
 AND A.EMPLYID = 'B050502'--@EMPID 
 AND A.DPRTID <> A.DEPID;
 
OPEN C1;
FETCH NEXT FROM C1 INTO @PEMPLYID,@SITEID
WHILE (@@FETCH_STATUS = 0)
BEGIN
   
   --產生途程
   INSERT INTO EIP..WF_SIGND(  SITEID, STATUS, EMPLYID)
   VALUES( @SITEID,'SN',@PEMPLYID);
   --COMMIT TRAN
   FETCH NEXT FROM C1 INTO @PEMPLYID,@SITEID
END
CLOSE C1;
DEALLOCATE C1;
GO