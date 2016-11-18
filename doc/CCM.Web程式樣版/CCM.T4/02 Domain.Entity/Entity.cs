using System;
using System.ComponentModel.DataAnnotations;

//todo: 請修改對應的namespace
namespace CCM.Domain.Entity 
{        
		             
			//mapping table name: FR_OFFIDOC_ISSUE
			public class FR_OFFIDOC_ISSUE                            
			{
				[Display(Name ="ISSUEID")]             
				public String ISSUEID  { get; set; }                                        
					
				[Display(Name ="COMPANY")]             
				public String COMPANY  { get; set; }                                        
					
				[Display(Name ="ISSUEDATE")]             
				public DateTime ISSUEDATE  { get; set; }                                        
					
				[Display(Name ="OFFICIAL_NM")]             
				public String OFFICIAL_NM  { get; set; }                                        
					
				[Display(Name ="SUBJECT")]             
				public String SUBJECT  { get; set; }                                        
					
				[Display(Name ="DESCR")]             
				public String DESCR  { get; set; }                                        
					
				[Display(Name ="AttachFIle")]             
				public String AttachFIle  { get; set; }                                        
					
				[Display(Name ="EMPID")]             
				public String EMPID  { get; set; }                                        
					
				[Display(Name ="DEPID")]             
				public String DEPID  { get; set; }                                        
					
				[Display(Name ="STATUS")]             
				public String STATUS  { get; set; }                                        
					
				[Display(Name ="DOCTYPE")]             
				public String DOCTYPE  { get; set; }                                        
					
				[Display(Name ="CONTACT")]             
				public String CONTACT  { get; set; }                                        
					
				[Display(Name ="PHONEAREACODE")]             
				public String PHONEAREACODE  { get; set; }                                        
					
				[Display(Name ="PHONE")]             
				public String PHONE  { get; set; }                                        
					
				[Display(Name ="PHONEEXTENSION")]             
				public String PHONEEXTENSION  { get; set; }                                        
					            
				public String FAX  { get; set; }                                        
					
				[Display(Name ="Original")]             
				public String Original  { get; set; }                                        
					
				[Display(Name ="Duplicate")]             
				public String Duplicate  { get; set; }                                        
					
				[Display(Name ="GUID")]             
				public String GUID  { get; set; }                                        
					
				                                
			}                            
}