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


namespace boscc.Controllers
{
    public class BosccApiController : Controller
    {

        private ApplicationDbContext db = new ApplicationDbContext();



        // GET: api/Api
        public JsonResult  Get()
        {
            return null;
        }

        // GET: api/Api/5
        public JsonResult GetCourseNodes(string userId)
        {

            return new JsonResult
            {
                Data = new
                {

                    id = userId
                },
                JsonRequestBehavior = JsonRequestBehavior.AllowGet
            };
        }

        // POST: api/Api
     
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
            }

            return  new JsonResult
            {
                Data = new { success = success,
                              message = message,
                              id = userId
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
