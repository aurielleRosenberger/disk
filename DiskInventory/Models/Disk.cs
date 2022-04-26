using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

#nullable disable

namespace DiskInventory.Models
{
    public partial class Disk
    {
        public Disk()
        {
            DiskHasBorrowers = new HashSet<DiskHasBorrower>();
        }

        public int DiskId { get; set; }
        [Required(ErrorMessage ="Please enter a Disk Name.")]
        public string DiskName { get; set; }
        [Required(ErrorMessage = "Please enter a Release Date.")]

        public DateTime ReleaseDate { get; set; }
        [Required(ErrorMessage = "Please select a Genre.")]

        public int? GenreId { get; set; }
        [Required(ErrorMessage = "Please select a Status.")]

        public int? StatusId { get; set; }
        [Required(ErrorMessage = "Please select a Disk Type.")]

        public int? DiskTypeId { get; set; }

        public virtual DiskType DiskType { get; set; }
        public virtual Genre Genre { get; set; }
        public virtual Status Status { get; set; }
        public virtual ICollection<DiskHasBorrower> DiskHasBorrowers { get; set; }
    }
}
