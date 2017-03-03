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
    public class HR_EMPLYMEntity : IEntityCcm<HR_EMPLYMEntity>
    {

        public String EMPLYID { get; set; }

        public String EMPLYNM { get; set; }

        public String DEPID { get; set; }

        public String C_STA { get; set; }

        public String OrganizeId { get; set; }
    }
}