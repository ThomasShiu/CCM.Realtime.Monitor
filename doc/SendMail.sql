EXEC msdb.dbo.sp_send_dbmail  
    @profile_name = 'MISMan',  
    @recipients = 'B050502@ccm3s.com',  
    @body = '系統設定系統設定系統設定系統設定系統設定系統設定.',  
    @subject = '系統設定' ;  
    
    
exec msdb.dbo.sp_send_dbmail
@profile_name='MISMan',   --設定檔
@recipients='B050502@ccm3s.com', --收件者
@subject='mail測試',  --主旨
@body='測試', --內文
@query='select getdate()',  --還可以下查詢式哦
--@file_attachments='D:\temp\54c24f21c78930b3.jpg',  --夾檔
--@attach_query_result_as_file=1,  --把查詢的結果設為附件夾檔，不設的話就是在mail內容中看到囉
@body_format=TEXT    --使用text格式
--@body_format=HTML'  --也可以使用HTML格式
go

exec msdb.dbo.sp_send_dbmail
@profile_name='MISMan',   --設定檔
@recipients='b050502@ccm3s.com', --收件者
@subject='DB MAIL測試',  --主旨
@body='你好~請查收  </br>     From Thomas Shiu', --內文
@query='select getdate()',  --還可以下查詢式哦
@body_format=HTML  --也可以使用HTML格式
go