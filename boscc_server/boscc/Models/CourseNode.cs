using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace boscc.Models
{
    public class CourseNode
    {
        public string CourseTitle { get; set; }
        public bool Completed { get; set; }
        public string NDegree { get; set; }
        public string ParentCourseNumber { get; set; }
    }
}