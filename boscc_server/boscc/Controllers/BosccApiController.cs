using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using System.Data.Entity;
using boscc.Models;
using System.Web;
using System.Web.Mvc;
using System.Globalization;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using System.Web.Script.Serialization;
namespace boscc.Controllers
{
    public class BosccApiController : Controller
    {

        private ApplicationDbContext db = new ApplicationDbContext();




        // POST: api/Api
        //create a username and password that the student can use to sign in. Return an id for the api
        public JsonResult PostRegister(string username, string password, string email, string major)
        {
            bool success = false;
            string message = "Registered user";
            string userId = "null";
            ApplicationUserManager usermanager = HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();

            var user = new ApplicationUser { UserName = username, Email = email };
            var result = usermanager.Create(user, password);
            usermanager.AddToRole(user.Id, "student");

            success = result.Succeeded;
            if(!success)
            {
                message = "password must contain 1 upercase 1 lowercase and one symbol, must be >= 6 chars";
                userId = new entityId().generateId();
                   return  new JsonResult
                {
                Data = new { success = success,
                              message = message,
                              id = userId
                              },
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
                 };
            }
            db.SaveChanges();
            //create a new user in major entry for them to use later
            var UIM = new UserInMajor { Id = user.Id, Major = major };
            db.UserInMajors.Add(UIM);
            db.SaveChanges();
         
            return  new JsonResult
            {
                Data = new { success = success,
                              message = message,
                              id = user.Id
                              },
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }
        
        public async Task<JsonResult> ToggleCourseCompletion(string coursenumber, string uid)
        {
            if(db.Courses.Where(c => c.CourseNumber == coursenumber).Count()>0)
            {
                var qRes = db.CourseTaken.Where(ct => (ct.userId == uid && ct.CourseNumber == coursenumber));
                if(qRes.Count()>0)
                {
                   db.CourseTaken.RemoveRange(qRes.ToList());
                   db.SaveChanges();
                }
                else
                {
                    var ct = new CourseTaken { CourseNumber = coursenumber, userId = uid };
                    db.CourseTaken.Add(ct);
                    await db.SaveChangesAsync();
                }
            }
            return new JsonResult
            {
                Data = new {success = true},
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }

        public JsonResult PutUserInMajor(string uid, string major)
        {
            string message = "success";
            bool keepGoing = true;
            var userExists = db.Users.Where(u => u.Id == uid);
            if(userExists == null)
            {
                message = "unable to find user";
                keepGoing = false;
            }

            var hasSomeCourses = db.Courses.Where(c => c.Department == major);

            if(hasSomeCourses == null)
            {
                message = "unable to find major";
                keepGoing = false;
            }

            if(keepGoing)
            {
                object[] p = new object[1];
                p[0] = uid;
                var person = db.Users.Find(p);
                if (person == null)
                    keepGoing = false;
            }

            if(keepGoing)
            {
                object[] p = new object[1];
                p[0] = uid;
                var tuple = db.UserInMajors.Find(p);
                if(tuple !=null)
                {
                    db.UserInMajors.Remove(tuple);
                    db.SaveChanges();
                }

                db.UserInMajors.Add(new UserInMajor { Id = uid, Major = major });
                db.SaveChanges();
            }
            return new JsonResult
            {
                Data = new
                {

                    message = message,

                },
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }
   


        // GET: api/Api
        public JsonResult Get()
        {
            return null;
        }

        public JsonResult GetPrerequisitesOfCourse(string cno)
        {
            List<string> pList = new List<string>();
            var dependents = db.Prerequisites.Where(p => p.DependentCourseNumber == cno);
            if (dependents.Count() >= 1)
            {
                var l = dependents.ToList();
                foreach (var d in l)
                    pList.Add(d.CourseNumber);
            }
            return new JsonResult
            {
                Data = new { courses = pList },
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }


        public JsonResult GetDependentsOfCourse(string cno)
        {
            List<string> depList = new List<string>();
            var dependents = db.Prerequisites.Where(p => p.CourseNumber == cno);
            if(dependents.Count()>=1)
            {
                var l = dependents.ToList();
                foreach(var d in l)
                    depList.Add(d.DependentCourseNumber);
            }
            return new JsonResult
            {
                Data = new { courses = depList },
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }

        // GET: api/Api/5
        public JsonResult GetCourseNodes(string uid)
        {
            //figure out major
            bool ok = false;
            object[] p = new object[1];
            p[0] = uid;
            var tuple = db.UserInMajors.Find(p);
            string major = "null";
            if (tuple != null)
            {
                ok = true;
                major = tuple.Major;
            }
            List<CourseNode> results = new List<CourseNode>();
            //figure out which courses they've taken
            var coursesTaken1 = db.getCoursesTakenForMajor(uid);
          
            if(ok)
            {
                //add these taken courses to the results list
                foreach(var ct in coursesTaken1)
                {
                    string title = db.getCourseTitle(ct.CourseNumber);
                    results.Add(new CourseNode{Completed = true, CourseNumber = ct.CourseNumber, CourseTitle = title, isFlex = false, NDegree = db.getNDegree(ct.CourseNumber) });
                }
            }

            //figure out what they still need to take
            List<string> courseNumbersNeeded1 = db.getCourseNumbersForMajor(major);
           if(ok)
           {
               foreach(var s in courseNumbersNeeded1)
               {
                   if( results.Any(c => c.CourseNumber == s) == false)
                   {
                       var course = db.getCourse(s);
                       if (course != null)
                           results.Add(new CourseNode { Completed = false, CourseNumber = course.CourseNumber, CourseTitle = course.Title, isFlex = false, NDegree = course.Level.ToString() });
                   }
               }

           }
           results.Sort(new sortHelper());
            //todo: get all the flex requirements they need and have taken. we don't need to know the course, simply the flexname short description, and whether or not they've taken it
         //   var flexTaken = from db.c


            var jsonSerialiser = new JavaScriptSerializer();
            var json = jsonSerialiser.Serialize(results);

            return new JsonResult
            {
                Data = new
                {
                 major = major,
                 coursesNeeded = results
                },
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }

        //
        // POST: /Account/Register
 
        // PUT: api/Api/5
        public void Put(int id, [FromBody]string value)
        {
        }

        // DELETE: api/Api/5
        public void Delete(string id)
        {
          
        }
    }
}
