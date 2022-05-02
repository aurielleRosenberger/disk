using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

#nullable disable

namespace DiskInventory.Models
{
    public partial class DiskHasBorrower
    {
        public int DiskHasBorrowerId { get; set; }

        [Required(ErrorMessage = "Please select a Borrower.")]
        public int? BorrowerId { get; set; }
        [Required(ErrorMessage = "Please select a Disk.")]
        public int? DiskId { get; set; }
        [Required(ErrorMessage = "Please select a Borrowed Date.")]
        public DateTime? BorrowedDate { get; set; }
        public DateTime? ReturnedDate { get; set; }

        public virtual Borrower Borrower { get; set; }
        public virtual Disk Disk { get; set; }
    }
}
