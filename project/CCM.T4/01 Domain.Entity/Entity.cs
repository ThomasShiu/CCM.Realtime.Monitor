using System;
using System.ComponentModel.DataAnnotations;

//todo: 請修改對應的namespace
namespace CCM.Domain.Entity 
{        
		             
			//mapping table name: Mis_IpAddre
			public class Mis_IpAddreEntity  : IEntityCcm<MisIpAddressEntity>, ICreationAuditedCcm, ,IModificationAuditedCcm                         
			{
				          
				public String SID  { get; set; }                                        
				          
				public String IP_ADDR  { get; set; }                                        
				          
				public String MAC_ADDR  { get; set; }                                        
				          
				public String DEPT  { get; set; }                                        
				          
				public String USER  { get; set; }                                        
				          
				public String DEVICE  { get; set; }                                        
				          
				public String OS  { get; set; }                                        
				          
				public String GROUP  { get; set; }                                        
				          
				public String ANTIVIRUS  { get; set; }                                        
				          
				public String REMARK  { get; set; }                                        
				          
				public String OrganizeId  { get; set; }                                        
				          
				public DateTime CreatorTime  { get; set; }                                        
				          
				public String CreatorUserId  { get; set; }                                        
				          
				public DateTime LastModifyTime  { get; set; }                                        
				          
				public String LastModifyUserId  { get; set; }                                        
				                                
			}                            
}