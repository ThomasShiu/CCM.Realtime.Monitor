using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCM.Domain
{
    public class MisIpAddressEntity : IEntityCcm<MisIpAddressEntity>, ICreationAuditedCcm,IModificationAuditedCcm
    {
        public String SID { get; set; }

        public String IP_ADDR { get; set; }

        public String MAC_ADDR { get; set; }

        public String DEPT { get; set; }

        public String USER { get; set; }

        public String DEVICE { get; set; }

        public String OS { get; set; }

        public String GROUP { get; set; }

        public String ANTIVIRUS { get; set; }

        public String REMARK { get; set; }

        public String OrganizeId { get; set; }

        public DateTime? CreatorTime { get; set; }

        public String CreatorUserId { get; set; }

        public DateTime? LastModifyTime { get; set; }

        public String LastModifyUserId { get; set; }

    }
}
