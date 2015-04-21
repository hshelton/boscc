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
        public JsonResult PostRegister(string username, string password, string email)
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
            var UIM = new UserInMajor { Id = user.Id, Major = "Undecided" };
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

        // GET: api/Api/5
        public JsonResult GetCourseNodes(string uid)
        {


            object[] p = new object[1];
            p[0] = uid;
            var tuple = db.UserInMajors.Find(p);
            string major = "null";
            if (major != null)
            {
                major = tuple.Major;
            }


            var results = db.CoursesThatMustBeTakenForMajors.Where(c => c.Major == major);
            List<CourseThatMustBeTaken> found = new List<CourseThatMustBeTaken>();
            if(results != null)
            {
                found = results.ToList();
            }
            var jsonSerialiser = new JavaScriptSerializer();
            var json = jsonSerialiser.Serialize(found);

            return new JsonResult
            {
                Data = new
                {
                 major = major,
                 results = found

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
