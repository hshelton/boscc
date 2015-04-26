using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using System.Data.Entity.Core;
using System.ComponentModel.DataAnnotations;
namespace boscc.Models
{


    public class entityId
    {
        public  string generateId()
        {
            Guid g = Guid.NewGuid();
            string GuidString = Convert.ToBase64String(g.ToByteArray());
            GuidString = GuidString.Replace("=", "");
            GuidString = GuidString.Replace("+", "");
            return GuidString;
        }
    }


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

        public CourseLevel Level { get; set; }
    }

    public class UserInMajor
    {
        [Key]
        public string Id { get; set; }
        public string Major { get; set; }
    }

    public class MajorRequirement
    {
        [Key]
        public int Id { get; set; }
        public string department { get; set; }
        public string coursenumber { get; set; }
    }
    public class CourseTaken
    {
        [Key]
        public int Id { get; set; }
        public string userId { get; set; }
        public string CourseNumber { get; set; }
    }
    public class FlexRequirement
    {
        [Key]
        public int Id { get; set; }
        public string flexname { get; set; }
        public string major { get; set; }
        public string flexdescription { get; set; }
    }
    //if the course doesn't meet a major requirement, assume it's taken for a flex requirements
    public class CourseTakenForFlex
    {
        [Key]
        public int Id { get; set; }
        public string flexname { get; set; }
        public string CourseNumber { get; set; }
    
        public string uid { get; set; }
    }

    public class SatisfiesFlex
    {
        [Key]
        public int Id { get; set; }
        public string CourseNumber { get; set; }
        public string flexname { get; set; }
    }
    public class PrerequisiteCourse
    {
        [Key]
        public string PrerequisiteId { get; set; }
        public string CourseNumber { get; set; }
        public string DependentCourseNumber { get; set; }

        public PrerequisiteCourse()
        {

        }
        /// <summary>
        /// Creates a new PrerequisiteCourse association
        /// </summary>
        /// <param name="courseNumber">The prerequisite course. eg. CS1410</param>
        /// <param name="prerequisiteCourseNumber">The the dependent course. eg. CS2420</param>
        public PrerequisiteCourse(string prereqNumber, string dependentNumber)
        {
            CourseNumber = prereqNumber;
            DependentCourseNumber = dependentNumber;
            generateId();
        }

        private void generateId()
        {
            Guid g = Guid.NewGuid();
            string GuidString = Convert.ToBase64String(g.ToByteArray());
            GuidString = GuidString.Replace("=","");
            GuidString = GuidString.Replace("+","");
            PrerequisiteId = GuidString;
        }

    }
}