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
		             
			//mapping table name: BU_LUNCH_AMOUNT
			public class BU_LUNCH_AMOUNTEntity  : IEntityCcm<BU_LUNCH_AMOUNTEntity>, ICreationAuditedCcm ,IModificationAuditedCcm                         
			{
				          
				public String SID  { get; set; }                                        
				          
				public DateTime LUNCHDATE  { get; set; }                                        
				          
				public String LOCATION  { get; set; }                                        
				          
				public Int32 MEATPEOPLES  { get; set; }                                        
				          
				public Int32 VEGEPEOPLES  { get; set; }                                        
				          
				public Int32 AbsentMEATPEOPLES  { get; set; }                                        
				          
				public Int32 AbsentVEGEPEOPLES  { get; set; }                                        
				          
				public Int32 ChangeMEATPEOPLES  { get; set; }                                        
				          
				public Int32 ChangeVEGEPEOPLES  { get; set; }                                        
				          
				public Int32 TuneMEATPEOPLES  { get; set; }                                        
				          
				public Int32 TuneVEGEPEOPLES  { get; set; }                                        
				          
				public Int32 REALMEATPEOPLES  { get; set; }                                        
				          
				public Int32 REALVEGEPEOPLES  { get; set; }                                        
				          
				public Int32 TunePAYEMPLYS  { get; set; }                                        
				          
				public Int32 REALPAYEMPLYS  { get; set; }                                        
				          
				public Int32 UNITPRICE  { get; set; }                                        
				          
				public Int32 TOTAL  { get; set; }                                        
				          
				public String REMARK  { get; set; }                                        
				          
				public String OrganizeId  { get; set; }                                        
				          
				public DateTime CreatorTime  { get; set; }                                        
				          
				public String CreatorUserId  { get; set; }                                        
				          
				public DateTime LastModifyTime  { get; set; }                                        
				          
				public String LastModifyUserId  { get; set; }                                        
				                                
			}                            
}