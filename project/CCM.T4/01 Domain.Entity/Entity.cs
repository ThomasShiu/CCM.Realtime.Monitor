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
		             
			//mapping table name: HR_EMPLYM
			public class HR_EMPLYMEntity  : IEntityCcm<HR_EMPLYMEntity>, ICreationAuditedCcm ,IModificationAuditedCcm                         
			{
				          
				public String EMPLYID  { get; set; }                                        
				          
				public Byte[] PICIMG  { get; set; }                                        
				          
				public String EMPLYNM  { get; set; }                                        
				          
				public String EMPLYENM  { get; set; }                                        
				          
				public String PIDNO  { get; set; }                                        
				          
				public String BPLACE  { get; set; }                                        
				          
				public String SEX  { get; set; }                                        
				          
				public DateTime BRTHDT  { get; set; }                                        
				          
				public String MARY  { get; set; }                                        
				          
				public String REGADRS  { get; set; }                                        
				          
				public String MAILADRS  { get; set; }                                        
				          
				public String MAILADRS2  { get; set; }                                        
				          
				public String HP  { get; set; }                                        
				          
				public String CONTEL  { get; set; }                                        
				          
				public String DEPID  { get; set; }                                        
				          
				public String LBRTP  { get; set; }                                        
				          
				public DateTime REGDT  { get; set; }                                        
				          
				public String JOBID  { get; set; }                                        
				          
				public String DEGREE  { get; set; }                                        
				          
				public String SERVICE  { get; set; }                                        
				          
				public Decimal RNO  { get; set; }                                        
				          
				public DateTime SPSDT  { get; set; }                                        
				          
				public DateTime LRTDT  { get; set; }                                        
				          
				public DateTime LLFDT  { get; set; }                                        
				          
				public String NATION  { get; set; }                                        
				          
				public String FORMAL  { get; set; }                                        
				          
				public Decimal EXMN  { get; set; }                                        
				          
				public String C_STA  { get; set; }                                        
				          
				public String PERD_05  { get; set; }                                        
				          
				public String PERD_06  { get; set; }                                        
				          
				public String RANKID  { get; set; }                                        
				          
				public String EMAIL  { get; set; }                                        
				          
				public String SFT_NO  { get; set; }                                        
				          
				public String COMID  { get; set; }                                        
				          
				public String WBSID  { get; set; }                                        
				          
				public String FA_NO  { get; set; }                                        
				          
				public String EXC_INSDBID  { get; set; }                                        
				          
				public DateTime EXC_INSDATE  { get; set; }                                        
				          
				public String EXC_UPDDBID  { get; set; }                                        
				          
				public DateTime EXC_UPDDATE  { get; set; }                                        
				          
				public String EXC_SYSOWNR  { get; set; }                                        
				          
				public String EXC_ISLOCKED  { get; set; }                                        
				          
				public String EXT  { get; set; }                                        
				          
				public String EFMNO  { get; set; }                                        
				          
				public String TFMNO  { get; set; }                                        
				          
				public String DIET  { get; set; }                                        
				                                
			}                            
}