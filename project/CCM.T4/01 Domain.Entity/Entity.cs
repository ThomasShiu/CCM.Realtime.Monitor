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
		             
			//mapping table name: V_HR_TICKET
			public class V_HR_TICKETEntity  : IEntityCcm<V_HR_TICKETEntity>, ICreationAuditedCcm ,IModificationAuditedCcm                         
			{
				          
				public DateTime YYMMDD  { get; set; }                                        
				          
				public String EMPLYID  { get; set; }                                        
				          
				public Decimal TKT_HH  { get; set; }                                        
				          
				public Decimal TKT_NN  { get; set; }                                        
				          
				public Decimal TKT_SS  { get; set; }                                        
				          
				public DateTime BL_DT  { get; set; }                                        
				          
				public String C_UPDATE  { get; set; }                                        
				          
				public String C_FUNC  { get; set; }                                        
				          
				public String REMARK  { get; set; }                                        
				          
				public String SN  { get; set; }                                        
				                                
			}                            
}