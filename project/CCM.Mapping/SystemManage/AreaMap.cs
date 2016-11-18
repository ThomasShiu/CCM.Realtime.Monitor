/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版权所有
 * Author: CCM
 * Description: CCM快速开发平台
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using CCM.Domain.Entity.SystemManage;
using System.Data.Entity.ModelConfiguration;

namespace CCM.Mapping.SystemManage
{
    /// <summary>
    /// 自動映射實體使用
    /// </summary>
    public class AreaMap : EntityTypeConfiguration<AreaEntity>
    {
        public AreaMap()
        {
            this.ToTable("Sys_Area");
            this.HasKey(t => t.F_Id);

            // Primary Key
            //this.HasKey(t => t.Id);

            // Properties
            //this.Property(t => t.Name).IsRequired().HasMaxLength(256);
            //this.Property(t => t.Phone).IsRequired().HasMaxLength(256);

            // Table & Column Mappings
            //this.ToTable("Customer", "STORE");
            //this.Property(t => t.Id).HasColumnName("Id");
            //this.Property(t => t.Name).HasColumnName("Name");
            //this.Property(t => t.Address).HasColumnName("Address");
            //this.Property(t => t.Phone).HasColumnName("Phone");

            // Relationships
            //this.HasRequired(t => t.Status)
            //    .WithMany(t => t.CustomerStatus)
            //    .HasForeignKey(d => d.Status);
        }
    }
}
