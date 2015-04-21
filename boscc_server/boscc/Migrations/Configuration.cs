namespace boscc.Migrations
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Migrations;
    using System.Linq;
    using boscc.Models;
    using Microsoft.AspNet.Identity;
    using Microsoft.AspNet.Identity.EntityFramework;
    using System.Collections.Generic;

    internal sealed class Configuration : DbMigrationsConfiguration<boscc.Models.ApplicationDbContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = true;
            AutomaticMigrationDataLossAllowed = true;
        }

        bool AddUserAndRole(boscc.Models.ApplicationDbContext context)
        {
            IdentityResult ir;
            var rm = new RoleManager<IdentityRole>
                (new RoleStore<IdentityRole>(context));
            ir = rm.Create(new IdentityRole("canEdit"));
            
            //add the student role
            rm.Create(new IdentityRole("student"));
            rm.Create(new IdentityRole("admin"));
            var um = new UserManager<ApplicationUser>(
                new UserStore<ApplicationUser>(context));
            
            var user = new ApplicationUser()
            {
                UserName = "admin@boscc.io",
            };
            ir = um.Create(user, "Goose2013!");
            if (ir.Succeeded == false)
                return ir.Succeeded;
            ir = um.AddToRole(user.Id, "admin");
            return ir.Succeeded;
        }



        //  This method will be called after migrating to the latest version.

        //  You can use the DbSet<T>.AddOrUpdate() helper extension method 
        //  to avoid creating duplicate seed data. E.g.
        //
        //    context.People.AddOrUpdate(
        //      p => p.FullName,
        //      new Person { FullName = "Andrew Peters" },
        //      new Person { FullName = "Brice Lambson" },
        //      new Person { FullName = "Rowan Miller" }
        //    );
        //
        protected override void Seed(boscc.Models.ApplicationDbContext context)
        {
            
            AddUserAndRole(context);
           
            context.Courses.AddOrUpdate(c => c.CourseNumber,
                new Course
                {
                    CourseNumber = "CS1311",
                    Department = "CS",
                    Description = "Dne",
                    Level = CourseLevel.OneThousand,
                    Title = "Fake Course",


                }

              

                );

            context.Contacts.AddOrUpdate(p => p.Name,
         new Contact
         {
             Name = "Debra Garcia",
             Address = "1234 Main St",
             City = "Redmond",
             State = "WA",
             Zip = "10999",
             Email = "debra@example.com",
         },
          new Contact
          {
              Name = "Thorsten Weinrich",
              Address = "5678 1st Ave W",
              City = "Redmond",
              State = "WA",
              Zip = "10999",
              Email = "thorsten@example.com",
          },
          new Contact
          {
              Name = "Yuhong Li",
              Address = "9012 State st",
              City = "Redmond",
              State = "WA",
              Zip = "10999",
              Email = "yuhong@example.com",
          },
          new Contact
          {
              Name = "Jon Orton",
              Address = "3456 Maple St",
              City = "Redmond",
              State = "WA",
              Zip = "10999",
              Email = "jon@example.com",
          },
          new Contact
          {
              Name = "Diliana Alexieva-Bosseva",
              Address = "7890 2nd Ave E",
              City = "Redmond",
              State = "WA",
              Zip = "10999",
              Email = "diliana@example.com",
          }
          );
        }
    }
}
