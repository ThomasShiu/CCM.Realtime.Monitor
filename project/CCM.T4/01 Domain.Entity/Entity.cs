/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM快速開發平臺
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using System;
using System.ComponentModel.DataAnnotations;

//todo: 請修改對應的namespace
namespace CCM.Domain 
{        
		             
			//mapping table name: RD_MACHINEAUTH
			public class RD_MACHINEAUTHEntity  : IEntityCcm<RD_MACHINEAUTHEntity>, ICreationAuditedCcm ,IModificationAuditedCcm                         
			{
				          
				public String SID  { get; set; }                                        
				          
				public String Subject  { get; set; }                                        
				          
				public String Machine_Id  { get; set; }                                        
				          
				public String oldFileName  { get; set; }                                        
				          
				public String newFileName  { get; set; }                                        
				          
				public String UploadPath  { get; set; }                                        
				          
				public String DownloadPath  { get; set; }                                        
				          
				public String CPU_SN  { get; set; }                                        
				          
				public String HD_SN  { get; set; }                                        
				          
				public String HD_Fireware  { get; set; }                                        
				          
				public String HD_Moduleno  { get; set; }                                        
				          
				public String OrganizeId  { get; set; }                                        
				          
				public DateTime CreatorTime  { get; set; }                                        
				          
				public String CreatorUserId  { get; set; }                                        
				          
				public DateTime LastModifyTime  { get; set; }                                        
				          
				public String LastModifyUserId  { get; set; }                                        
				                                
			}                            
}