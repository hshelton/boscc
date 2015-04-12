using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace boscc.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
            if(!User.IsInRole("student") && !User.IsInRole("admin"))
            {
                return RedirectToAction("Login", "Account");
            }
            
            if(User.IsInRole("student"))
            {
                return RedirectToAction("Visualize");
            }

            return View();
        }

        public ActionResult GettingStarted()
        {
            return View();
        }
        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Visualize()
        {
            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}