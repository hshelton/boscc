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
        public bool isFlex { get; set; }
        public string CourseNumber { get; set; }
        public string FlexDescription { get; set; }


      
       
    }

    public class sortHelper : IComparer<CourseNode>
    {

    int IComparer<CourseNode>.Compare(CourseNode a, CourseNode b)
        {
            if (a.CourseNumber == null || b.CourseNumber == null)
            {
                return 0;
            }
            var cna = a.CourseNumber;
            string cnaPartial = "";
            for (int i = 0; i < cna.Length; i++ )
            {
                if (Char.IsNumber(cna[i]))
                {
                    cnaPartial += cna[i];
                }
               
            }
            var cnb = b.CourseNumber;
            string cnbPartial = "";
            for (int i = 0; i < cnb.Length; i++)
            {
                if (Char.IsNumber(cnb[i]))
                {
                    cnbPartial += cnb[i];
                }
          
            }
            var aP = Int32.Parse(cnaPartial);
            var bP = Int32.Parse(cnbPartial);

            return aP - bP;
           
        }

    }
}