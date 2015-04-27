using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using boscc.Models;

namespace boscc.Controllers
{
    public class MajorRequirementsController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();

         [Authorize(Roles = "admin")]
        // GET: MajorRequirements
        public ActionResult Index()
        {
            return View(db.MajorRequired.ToList());
        }

        // GET: MajorRequirements/Details/5
         [Authorize(Roles = "admin")]
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            MajorRequirement majorRequirement = db.MajorRequired.Find(id);
            if (majorRequirement == null)
            {
                return HttpNotFound();
            }
            return View(majorRequirement);
        }

        // GET: MajorRequirements/Create
         [Authorize(Roles = "admin")]
        public ActionResult Create()
        {
            return View();
        }

        // POST: MajorRequirements/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "Id,department,coursenumber")] MajorRequirement majorRequirement)
        {
            if (ModelState.IsValid)
            {
                db.MajorRequired.Add(majorRequirement);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            return View(majorRequirement);
        }

        // GET: MajorRequirements/Edit/5
         [Authorize(Roles = "admin")]
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            MajorRequirement majorRequirement = db.MajorRequired.Find(id);
            if (majorRequirement == null)
            {
                return HttpNotFound();
            }
            return View(majorRequirement);
        }

        // POST: MajorRequirements/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,department,coursenumber")] MajorRequirement majorRequirement)
        {
            if (ModelState.IsValid)
            {
                db.Entry(majorRequirement).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(majorRequirement);
        }

        // GET: MajorRequirements/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            MajorRequirement majorRequirement = db.MajorRequired.Find(id);
            if (majorRequirement == null)
            {
                return HttpNotFound();
            }
            return View(majorRequirement);
        }

        // POST: MajorRequirements/Delete/5
         [Authorize(Roles = "admin")]
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            MajorRequirement majorRequirement = db.MajorRequired.Find(id);
            db.MajorRequired.Remove(majorRequirement);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
