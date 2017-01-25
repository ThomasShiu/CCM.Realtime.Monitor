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
		             
			//mapping table name: BU_ORDERS_MENU
			public class BU_ORDERS_MENUEntity  : IEntityCcm<BU_ORDERS_MENUEntity>, ICreationAuditedCcm ,IModificationAuditedCcm                         
			{
				          
				public String SID  { get; set; }                                        
				          
				public Int64 ParentSID  { get; set; }                                        
				          
				public String MealsName  { get; set; }                                        
				          
				public Int32 UnitPrice  { get; set; }                                        
				          
				public String Remark  { get; set; }                                        
				          
				public String OrganizeId  { get; set; }                                        
				          
				public DateTime CreatorTime  { get; set; }                                        
				          
				public String CreatorUserId  { get; set; }                                        
				          
				public DateTime LastModifyTime  { get; set; }                                        
				          
				public String LastModifyUserId  { get; set; }                                        
				                                
			}                            
}