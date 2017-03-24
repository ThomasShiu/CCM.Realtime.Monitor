using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CCM.Web.EIP.Areas.DocManage.Models
{
    public class FileTreeViewModel
    {
        public string Name { get; set; }
        public string Ext { get; set; }
        public string Path { get; set; }
        public bool IsDirectory { get; set; }

        public string PathAltSeparator()
        {
            return Path.Replace("\\", "/");
        }
    }
}