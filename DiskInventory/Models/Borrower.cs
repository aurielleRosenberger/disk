using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

#nullable disable

namespace DiskInventory.Models
{
    public partial class Borrower
    {
        public Borrower()
        {
            DiskHasBorrowers = new HashSet<DiskHasBorrower>();
        }

        public int BorrowerId { get; set; }
        [Required(ErrorMessage = "Please enter a First Name.")]
        public string Fname { get; set; }
        [Required(ErrorMessage = "Please enter a Last Name.")]

        public string Lname { get; set; }
        [Required(ErrorMessage = "Please enter a Phone Number.")]

        public string PhoneNum { get; set; }

        public virtual ICollection<DiskHasBorrower> DiskHasBorrowers { get; set; }
    }
}
