using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using System.Data.Entity.Core;
using System.ComponentModel.DataAnnotations;
namespace boscc.Models
{
    public enum CourseLevel
    {
       Remedial = 0,
       OneThousand = 1,
       TwoThousand = 2,
       ThreeThousand = 3,
       FourThousand = 4,
       FiveThousand =5
    };

   public enum Major
    {
        CS,
        EAE,
        Finance
    }

    public class Course
    {
        public string Department { get; set; }
        public string Title { get; set; }
        [Key]
        public string CourseNumber { get; set; }
        public string Description { get; set; }
        public List<string> Prerequisites { get; set; }
        public List<string> Dependents { get; set; }
        public CourseLevel Level { get; set; }
        public List<string> RequiredForMajors { get; set; }
 

        public bool AddPrerequisiteCourse(string courseNumber)
        {
            if(Prerequisites == null)
            {
                Prerequisites = new List<string>();
            }
            if(!Prerequisites.Contains(courseNumber))
            {
                Prerequisites.Add(courseNumber);
                return true;
            }
            return false;
        }

        public bool AddDependentCourse(string courseNumber)
        {
            if (Dependents == null)
            {
                Dependents = new List<string>();
            }
            if (!Dependents.Contains(courseNumber))
            {
                Dependents.Add(courseNumber);
                return true;
            }
            return false;
        }
    }
}