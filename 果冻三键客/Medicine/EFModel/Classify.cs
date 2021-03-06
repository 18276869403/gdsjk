namespace EFModel
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.Spatial;

    [Table("Classify")]
    public partial class Classify
    {
        public int ID { get; set; }

        [Required]
        [StringLength(50)]
        public string ClassifyName { get; set; }
    }
}
