using System.Data.Entity;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity.Core;
using System.ComponentModel.DataAnnotations;

namespace boscc.Models
{
    // You can add profile data for the user by adding more properties to your ApplicationUser class, please visit http://go.microsoft.com/fwlink/?LinkID=317594 to learn more.
    public class ApplicationUser : IdentityUser
    {
        public async Task<ClaimsIdentity> GenerateUserIdentityAsync(UserManager<ApplicationUser> manager)
        {
            // Note the authenticationType must match the one defined in CookieAuthenticationOptions.AuthenticationType
            var userIdentity = await manager.CreateIdentityAsync(this, DefaultAuthenticationTypes.ApplicationCookie);
            // Add custom user claims here
            return userIdentity;
        }
    }

    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public ApplicationDbContext()
            : base("DefaultConnection", throwIfV1Schema: false)
        {
        }

        public static ApplicationDbContext Create()
        {
            return new ApplicationDbContext();
        }

        public System.Data.Entity.DbSet<boscc.Models.Contact> Contacts { get; set; }

        public System.Data.Entity.DbSet<boscc.Models.Course> Courses { get; set; }
        public System.Data.Entity.DbSet<boscc.Models.PrerequisiteCourse> Prerequisites { get; set; }
        public System.Data.Entity.DbSet<boscc.Models.UserInMajor> UserInMajors { get; set; }
        public System.Data.Entity.DbSet<boscc.Models.FlexRequirement> FlexRequirements { get; set; }
        public System.Data.Entity.DbSet<boscc.Models.CourseTakenForFlex> CoursesTakenForFlex { get; set; }
        public System.Data.Entity.DbSet<boscc.Models.CourseTaken> CourseTaken { get; set; }
        public System.Data.Entity.DbSet<boscc.Models.SatisfiesFlex> CourseMeetsFlex { get; set; }
        public System.Data.Entity.DbSet<boscc.Models.MajorRequirement> MajorRequired { get; set; }




        public Course getCourse(string cno)
        {
            var q = (from a in Courses
                     where a.CourseNumber == cno
                     select a).First();

            return q;
        }


        public List<CourseTaken> getCoursesTakenForMajor(string uid)
        {
            var q1 = from a in CourseTaken
                     where a.userId == uid
                     select a;
            if (q1.Count() != 0)
            {
                return q1.ToList();

            }
            return new List<CourseTaken>();
        }


        /// <summary>
        /// Return a list of required course numbers for a given major
        /// </summary>
        /// <param name="major"></param>
        /// <returns></returns>
        public List<string> getCourseNumbersForMajor(string major)
        {
            try
            {
                var l = new List<string>();
                var q1 = from a in MajorRequired
                         where a.department == major
                         select a;
                var res = q1.ToList();

                foreach(var a in res)
                {
                    l.Add(a.coursenumber);
                }
                return l;
            }
            catch { return new List<string>(); }
        }
        /// <summary>
        /// Return a list of required course numbers for a given major
        /// </summary>
        /// <param name="major"></param>
        /// <returns></returns>
        public List<string> getCourseNumbersForFlex(string major)
        {
            try
            {
                var l = new List<string>();
                var q1 = from a in FlexRequirements
                         where a.major == major
                         select a;
                var res = q1.ToList();

                foreach (var a in res)
                {
                    var q2 = from b in CourseMeetsFlex
                             where b.flexname == a.flexname
                             select b;
                    var l2 = q2.ToList();
                    foreach( var c in l2)
                    {
                        l.Add(c.CourseNumber);
                    }

                }
                return l;
            }
            catch { return new List<string>(); }
        }


        public List<CourseTakenForFlex> getCoursesTakenForFlex(string uid)
        {
            var q1 = from a in CoursesTakenForFlex
                     where a.uid == uid
                     select a;
            if (q1.Count() != 0)
            {
                return q1.ToList();

            }
            return new List<CourseTakenForFlex>();
        }


        public string getCourseTitle(string courseNumber)
        {
            string ret = "";
            try
            {
                var q1 = from a in Courses
                         where a.CourseNumber == courseNumber
                         select a;
                ret = q1.First().Title;
            }
            catch
            {
                ret = "Course Name Not Found";
            }

            return ret;
        }

        public string getNDegree(string courseNumber)
        {
            string ret = "";
            try
            {
                var q1 = from a in Courses
                         where a.CourseNumber == courseNumber
                         select a;
                ret = q1.First().Level.ToString();
            }
            catch
            {
   
            }

            return ret;
        }


        public List<CourseTakenForFlex> getFlexRequirementsTaken(string uid)
        {
            var q1 = from a in CoursesTakenForFlex
                     where a.uid == uid
                     select a;
            if (q1.Count() != 0)
            {
                return q1.ToList();
            }

            return null;
        }
    }
}