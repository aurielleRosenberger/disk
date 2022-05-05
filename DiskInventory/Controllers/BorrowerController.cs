using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using DiskInventory.Models;
using Microsoft.EntityFrameworkCore;

namespace DiskInventory.Controllers
{
    public class BorrowerController : Controller
    {
        private diskInventoryARContext context { get; set; }
        public BorrowerController(diskInventoryARContext ctx)
        {
            context = ctx;
        }
        public IActionResult Index()
        {
            List<Borrower> borrowers = context.Borrowers.OrderBy(b => b.Lname).ThenBy(b => b.Fname).ToList();
            return View(borrowers);
        }
        [HttpGet]
        public IActionResult Add()
        {
            ViewBag.Action = "Add";
            return View("Edit", new Borrower());
        }

        [HttpGet]
        public IActionResult Edit(int id)
        {
            ViewBag.Action = "Edit";
            var borrower = context.Borrowers.Find(id);
            return View(borrower);
        }

        [HttpPost]
        public IActionResult Edit(Borrower borrower)
        {
            if (ModelState.IsValid)
            {
                if (borrower.BorrowerId == 0)
                {
                    // context.Borrowers.Add(borrower);
                    context.Database.ExecuteSqlRaw("execute sp_ins_borrower @p0, @p1, @p2",
                        parameters: new[] { borrower.Fname, borrower.Lname, borrower.PhoneNum });
                TempData["message"] = "Borrower added.";
                }

                else
                {
                    // context.Borrowers.Update(borrower);
                    context.Database.ExecuteSqlRaw("execute sp_upd_borrower @p0, @p1, @p2, @p3",
                        parameters: new[] { borrower.BorrowerId.ToString(), borrower.Fname, borrower.Lname, borrower.PhoneNum });
                    TempData["message"] = "Borrower updated.";
                }
                // context.SaveChanges();
                return RedirectToAction("Index", "Borrower");
            }
            else
            {
                ViewBag.Action = (borrower.BorrowerId == 0) ? "Add" : "Edit";
                return View(borrower);
            }
        }
        [HttpGet]
        public IActionResult Delete(int id)
        {
            var borrower = context.Borrowers.Find(id);
            return View(borrower);
        }
        [HttpPost]
        public IActionResult Delete(Borrower borrower)
        {
            // context.Borrowers.Remove(borrower);
            // context.SaveChanges();
            context.Database.ExecuteSqlRaw("execute sp_del_borrower @p0",
                parameters: new[] { borrower.BorrowerId.ToString() });
            TempData["message"] = "Borrower removed.";
            return RedirectToAction("Index", "Borrower");
        }
    }
}
