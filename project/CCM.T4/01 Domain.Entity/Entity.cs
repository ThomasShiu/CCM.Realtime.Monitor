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
		             
			//mapping table name: FR_OFFIDOC_RECE
			public class FR_OFFIDOC_RECEEntity  : IEntityCcm<FR_OFFIDOC_RECEEntity>, ICreationAuditedCcm ,IModificationAuditedCcm                         
			{
				          
				public String SID  { get; set; }                                        
				          
				public String RECEIVEID  { get; set; }                                        
				          
				public DateTime RECEDATE  { get; set; }                                        
				          
				public String OFFICIAL_NM  { get; set; }                                        
				          
				public String OFFICIAL_DOCID  { get; set; }                                        
				          
				public String OFFICIAL_DOCTYPE  { get; set; }                                        
				          
				public String DESCR  { get; set; }                                        
				          
				public String AttachFIle  { get; set; }                                        
				          
				public String EMPID  { get; set; }                                        
				          
				public String COMID  { get; set; }                                        
				          
				public String DEPID  { get; set; }                                        
				          
				public String STATUS  { get; set; }                                        
				          
				public String GUID  { get; set; }                                        
				          
				public String OrganizeId  { get; set; }                                        
				          
				public DateTime CreatorTime  { get; set; }                                        
				          
				public String CreatorUserId  { get; set; }                                        
				          
				public DateTime LastModifyTime  { get; set; }                                        
				          
				public String LastModifyUserId  { get; set; }                                        
				                                
			}                            
}