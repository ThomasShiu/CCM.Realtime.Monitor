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
		             
			//mapping table name: PO_PUBLIC_OBJECT
			public class PO_PUBLIC_OBJECTEntity  : IEntityCcm<PO_PUBLIC_OBJECTEntity>, ICreationAuditedCcm ,IModificationAuditedCcm                         
			{
				          
				public String SID  { get; set; }                                        
				          
				public String ObjectType  { get; set; }                                        
				          
				public String ObjectNM  { get; set; }                                        
				          
				public String Description  { get; set; }                                        
				          
				public String Open_  { get; set; }                                        
				          
				public String PhotoUrl  { get; set; }                                        
				          
				public DateTime EnableDate  { get; set; }                                        
				          
				public Int32 Mileage  { get; set; }                                        
				          
				public Int32 MaintenanceMileage  { get; set; }                                        
				          
				public DateTime MaintenanceDate  { get; set; }                                        
				          
				public DateTime RemindDate  { get; set; }                                        
				          
				public String DontMaintenance  { get; set; }                                        
				          
				public String Location  { get; set; }                                        
				          
				public String OrganizeId  { get; set; }                                        
				          
				public DateTime CreatorTime  { get; set; }                                        
				          
				public String CreatorUserId  { get; set; }                                        
				          
				public DateTime LastModifyTime  { get; set; }                                        
				          
				public String LastModifyUserId  { get; set; }                                        
				                                
			}                            
}