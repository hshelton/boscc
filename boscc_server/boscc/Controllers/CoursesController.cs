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
    public class CoursesController : Controller
    {
        private ApplicationDbContext db = new ApplicationDbContext();

        // GET: Courses
        [Authorize(Roles = "admin")]
        public ActionResult Index()
        {
            return View(db.Courses.OrderBy(cn => cn.CourseNumber).ToList());
        }

        // GET: Courses/Details/5
         [Authorize(Roles = "admin")]
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Course course = db.Courses.Find(id);
            if (course == null)
            {
                return HttpNotFound();
            }
            return View(course);
        }

        // GET: Courses/Create
         [Authorize(Roles = "admin")]
        public ActionResult Create()
        {
            return View();
        }

        // POST: Courses/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "CourseNumber,Department,Title,Description,Level")] Course course)
        {
            if (ModelState.IsValid)
            {
                db.Courses.Add(course);
                db.SaveChanges();
                return RedirectToAction("Edit", new  { id = course.CourseNumber });
            }

            return View(course);
        }

        // GET: Courses/Edit/5
         [Authorize(Roles = "admin")]
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Course course = db.Courses.Find(id);
            if (course == null)
            {
                return HttpNotFound();
            }
            return View(course);
        }

        // POST: Courses/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "CourseNumber,Department,Title,Description,Level")] Course course)
        {
            if (ModelState.IsValid)
            {
                db.Entry(course).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(course);
        }

        // GET: Courses/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Course course = db.Courses.Find(id);
            if (course == null)
            {
                return HttpNotFound();
            }
            return View(course);
        }

        // POST: Courses/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            Course course = db.Courses.Find(id);
            db.Courses.Remove(course);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        public JsonResult AddPrerequisite(string courseNumber, string prereqCourseNumber)
        {
            Course course = db.Courses.Find(courseNumber);
            Course prereq = db.Courses.Find(prereqCourseNumber);
            bool success = false;

            //if the prerequisite relationship is already established, do nothing vhfb ngjmvwvxscthvtk3
            if(course != null && prereq != null )
            {
 

                var prereqsFound = from p in db.Prerequisites
                                   where p.CourseNumber == prereqCourseNumber && p.DependentCourseNumber == courseNumber
                                   select p;
                var list = prereqsFound.ToList();
                if(list.Count == 0)
                {
                    db.Prerequisites.Add(new PrerequisiteCourse(prereqCourseNumber, courseNumber));
                   if( db.SaveChanges() >= 1)
                   {
                       success = true;
                   }

                   //now add all of the prerequisite course's prerequisites

                   var addThese = from p in db.Prerequisites
                                  where p.DependentCourseNumber == prereq.CourseNumber
                                  select p;
                   var list2 = addThese.ToList();
                    if(list2.Count() >0)
                    {
                        foreach(var p in list2)
                        {
                            db.Prerequisites.Add(new PrerequisiteCourse(p.CourseNumber, courseNumber));
                        }
                    }
                    db.SaveChanges();
                }
            }


            JsonResult n = new JsonResult{
                Data = new {success = success },
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };

            return n;
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
