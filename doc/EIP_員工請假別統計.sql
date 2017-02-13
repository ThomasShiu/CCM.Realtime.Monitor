DECLARE @BDT DATETIME;
     -- 該月第一天
DECLARE @EDT DATETIME;
     -- 該月最後一天
SET @BDT = '2017/01/01';
 -- 設定該月第一天
SET @EDT = '2017/01/31';
 -- 設定該月最後一天
  -- 請假單來   
WITH    FRL ( EMP_NO, FRL_NO, BL_DT, FRHR )
          AS ( SELECT
                DL.EMPLYID , DL.FRL_NO , DL.BL_DT , DL.FRHR AS FRHR
               FROM
                HR_FRLMT MT
                JOIN HR_FRLDL DL
                ON MT.FMNO = DL.FMNO
               WHERE
                BL_DT BETWEEN @BDT AND @EDT AND
                MT.STATUS = 'CF')
     SELECT
        EMP_NO AS EMPID , FRL_NO , SUM(FRHR) AS FRHR
     INTO
        #FRLS
     FROM
        FRL
     GROUP BY
        EMP_NO , FRL_NO
      

    -- 加入有遲到沒有請假的部份
INSERT  INTO #FRLS
        SELECT
            EMPLYID , 08 , 0
        FROM
            HR_WRKDL
        WHERE
            YYMMDD BETWEEN @BDT AND @EDT AND
            EMPLYID NOT IN ( SELECT
                                EMPID
                             FROM
                                #FRLS ) AND
            ( LATE_CT <> 0 OR
              LATE_NN <> 0
            )         

SELECT
    RTRIM(EMPID) AS EMPID , ( SELECT RTRIM (EMPLYNM) FROM HR_EMPLYM YM WHERE YM.EMPLYID = EMPID ) AS EMP_NM ,
    ( SELECT RTRIM (DEPNM) FROM HR_DEP DE WHERE DE.DEPID = EMPID ) AS DEPID , ISNULL([01] , 0) AS '01' ,
    ISNULL([02] , 0) AS '02' , ISNULL([03] , 0) AS '03' , ISNULL([04] , 0) AS '04' , ISNULL([05] , 0) AS '05' ,
    ISNULL([06] , 0) AS '06' , ISNULL([07] , 0) AS '07' , ISNULL([08] , 0) AS '08' , ISNULL([09] , 0) AS '09' ,
    ISNULL([10] , 0) AS '10' , ISNULL([11] , 0) AS '11' , ISNULL([12] , 0) AS '12' , ISNULL([13] , 0) AS '13' ,
    ISNULL([14] , 0) AS '14' , ISNULL([15] , 0) AS '15' , ISNULL([16] , 0) AS '16' , ISNULL([17] , 0) AS '17' ,
    ISNULL([18] , 0) AS '18' , ISNULL([19] , 0) AS '19' , ISNULL([20] , 0) AS '20' ,
    ISNULL(( SELECT SUM (LATE_NN) FROM HR_WRKDL WHERE YYMMDD BETWEEN @BDT AND @EDT AND EMPLYID = EMPID ) , 0) AS LATE_NN ,
    ISNULL(( SELECT SUM (LATE_CT) FROM HR_WRKDL WHERE YYMMDD BETWEEN @BDT AND @EDT AND EMPLYID = EMPID ) , 0) AS LATE_CT
FROM
    #FRLS PIVOT( SUM(FRHR) FOR FRL_NO IN ( [06] , [20] , [13] , [07] , [11] , [03] , [15] , [16] , [18] , [17] , [04] ,
                                           [10] , [01] , [12] , [05] , [14] , [19] , [09] , [02] , [08] ) ) AS PivotTable
ORDER BY
    EMPID

DROP TABLE #FRLS
