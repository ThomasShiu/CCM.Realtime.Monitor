/* 2016/12/05 
 * 與權限有關TABLES
 * USRPMS -- 使用者權限
 * GRPPMS -- 群組權限
 * VCHUSR -- 單別使用者設定
 * 人員： B050607 段酈伊
 * ERP權限設定： 加入單據權限 X23 售服調撥單 
 * 
 */
DECLARE @usr_no varchar(10), @prg_no varchar(32);
SET @usr_no = 'B050502';
--SET @prg_no = 'SFCMAT15'
--程式權限查詢--使用晶華UI設定後，可於此執行、截圖，MAIL給使用者
SELECT  USR_NO,PRG_NO,
        (SELECT PRG_NM FROM CCM_MAIN.dbo.PRGNO WHERE CCM_MAIN.dbo.PRGNO.PRG_NO = CCM_MAIN.dbo.USRPMS.PRG_NO) AS PRG_NM, 
        C_RUN, 
        C_ADD, 
        C_QRY, 
        C_MDY, 
        C_CFM, 
        C_UCF, 
        C_DEL, 
        C_CST, 
        C_CPY, 
        C_EML, 
        C_ATT, 
        C_SIN
    FROM CCM_MAIN.dbo.USRPMS
    WHERE 1=1 --AND USR_NO = @usr_no 
        --AND PRG_NO = @prg_no
UNION --由群組取得的權限
    SELECT  PRG_NO,
        (SELECT PRG_NM FROM CCM_MAIN.dbo.PRGNO WHERE CCM_MAIN.dbo.PRGNO.PRG_NO = CCM_MAIN.dbo.GRPPMS.PRG_NO) AS PRG_NM, 
        C_RUN, 
        C_ADD, 
        C_QRY, 
        C_MDY, 
        C_CFM, 
        C_UCF, 
        C_DEL, 
        C_CST, 
        C_CPY, 
        C_EML, 
        C_ATT, 
        C_SIN
        FROM CCM_MAIN.dbo.GRPPMS
        --WHERE GRP_NO = (SELECT GRP_NO FROM USRNO WHERE USR_NO = @usr_no) 
        --    AND PRG_NO NOT IN (SELECT PRG_NO FROM CCM_MAIN.dbo.USRPMS WHERE  USR_NO = @usr_no)
            --AND PRG_NO = @prg_no

--單據權限查詢--使用晶華UI設定後，可於此執行、截圖，MAIL給使用者
SELECT  
        VCH_TY,
        (SELECT VCH_NM FROM VCHCONFG WHERE VCH_TY = VCHUSR.VCH_TY) AS VCH_NM, 
        --USR_NO AS '工號', 
        --(SELECT EMP_NM FROM EMPNO WHERE EMPNO.EMP_NO = VCHUSR.USR_NO) AS '姓名', 
        C_RUN, 
        C_ADD, 
        C_QRY, 
        C_MDY, 
        C_CFM, 
        C_UCF, 
        C_DEL, 
        C_CST, 
        C_CPY, 
        C_EML, 
        C_ATT, 
        C_SIN  
    FROM VCHUSR
    WHERE USR_NO IN (@usr_no, (SELECT GRP_NO FROM USRNO WHERE USR_NO = @usr_no))
       --AND VCH_TY = 'X23'
       
--單據權限查詢--使用晶華UI設定後，可於此執行、截圖，MAIL給使用者
SELECT  
        VCH_TY AS '單別',
        (SELECT VCH_NM FROM VCHCONFG WHERE VCH_TY = VCHUSR.VCH_TY) AS 單據名稱, 
        --USR_NO AS '工號', 
        --(SELECT EMP_NM FROM EMPNO WHERE EMPNO.EMP_NO = VCHUSR.USR_NO) AS '姓名', 
        C_RUN AS '執行權限', 
        C_ADD AS '新增權限', 
        C_QRY AS '查詢權限', 
        C_MDY AS '修改權限', 
        C_CFM AS '確認權限', 
        C_UCF AS '反調權限', 
        C_DEL AS '刪除權限', 
        C_CST AS '金額權限', 
        C_CPY AS '複製權限', 
        C_EML AS '郵件權限', 
        C_ATT AS '附檔權限', 
        C_SIN AS '送簽權限' 
    FROM VCHUSR
    WHERE USR_NO IN (@usr_no, (SELECT GRP_NO FROM USRNO WHERE USR_NO = @usr_no))
       --AND VCH_TY = 'X23'


