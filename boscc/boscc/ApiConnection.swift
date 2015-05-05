//
//  ApiConnection.swift
//  boscc
//
//  Created by Hayden Shelton on 4/26/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit


class ApiConnection
{
    var dict:  NSMutableArray = []

    init()
    {
        LoadFile()
        if(dict.count == 1)
        {
            var coursesIP = NSMutableDictionary()
            dict.addObject(coursesIP)
        }

    }
    
    func getUid () -> String
    {
       if(dict.count == 0)
       {
            return "NOT FOUND";
        }
        else
       {
        var dt = dict[0] as! NSDictionary
        var res = dt["uid"] as! String
        return res
        }
    }
    
    func getUname () -> String
    {
        if(dict.count == 0)
        {
            return "NOT FOUND";
        }
        else
        {
            var dt = dict[0] as! NSDictionary
            var res = dt["uname"] as! String
            return res
        }
    }
    
    func getMajor () -> String
    {
        if(dict.count == 0)
        {
            return "NOT FOUND";
        }
        else
        {
            var dt = dict[0] as! NSDictionary
            var res = dt["major"] as! String
            return res
        }
    }
    
    func wipeLocal()
    {
        dict = NSMutableArray()
        ToFile()
       
    }
    
    func ToggleCourse(coursenumber: String, uid: String)
    {
        //remove locally saved in progress status
        var cIP = dict[1] as! NSMutableDictionary
        cIP[coursenumber] = "na"
        dict.removeLastObject()
        dict.addObject(cIP)
        
        let request = NSMutableURLRequest(URL: NSURL(string: "http://boscc.io/bosccapi/ToggleCourseCompletion?coursenumber=\(coursenumber)&uid=\(uid)")!)
        request.HTTPMethod = "GET"
        // request.setValue("application/json", forHTTPHeaderField: "content-type")
        
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        if(data != nil)
        {
             let attr: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: .allZeros, error: nil)! as! NSDictionary
        }
    }
    
    func GetCourseTimes(CourseNumber : String, IsFlex:Bool) -> ([String])
    {
        //begin by getting the course description or the flex description
        var err: NSError
        let request = NSMutableURLRequest(URL: NSURL(string: "http://boscc.io/bosccapi/GetCourseTimes?cno=\(CourseNumber)")!)
        request.HTTPMethod = "GET"
 

        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        var s = [String]()
        if(data == nil)
        {
            
            s.append( "No times found this semester")
          
           
        }
        let attr: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: .allZeros, error: nil)! as! NSDictionary
        let list: NSArray = attr["times"] as! NSArray
        
        for t in list
        {
            s.append(t as! String)
        }

        return s 
        
        
    }
    
    
    
    func GetCourseDetails(CourseNumber : String, IsFlex:Bool) -> ([String : String])
    {
        //begin by getting the course description or the flex description
        var err: NSError
        let request = NSMutableURLRequest(URL: NSURL(string: "http://boscc.io/bosccapi/GetCourseDescription")!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        let jsonObject: NSDictionary = ["cno": CourseNumber, "isFlex": IsFlex]
        let requestDict = NSJSONSerialization.dataWithJSONObject(jsonObject, options: .allZeros, error: nil)
        request.HTTPBody = requestDict
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        var s = [String: String]()
        if(data == nil)
        {
            s["success"] = "false"
            return s
        }
        let attr: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: .allZeros, error: nil)! as! NSDictionary
        let desc: String? = attr["description"] as? String
        if(desc == nil)
        {
            s["description"] = "Not found"
        }
        else
        {
            s["description"] = desc
        }
        s["title"] = "Not found"
        let title: String? = attr["title"] as? String
        if(title != nil && !IsFlex)
        {
            s["title"] = title
        }
        
        s["department"] = "Not found"
        
        let department: String? = attr["department"] as? String
        if(department != nil)
        {
            s["department"] = department
        }
        if(IsFlex)
        {
            s["title"] = CourseNumber
            s["prerequisites"] = ""
            s["dependents"] = ""
        }
        else
        {
            let request = NSMutableURLRequest(URL: NSURL(string: "http://boscc.io/bosccapi/GetPrerequisitesOfCourse?cno=\(CourseNumber)")!)
            request.HTTPMethod = "GET"

            var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
            if(data == nil)
            {
                s["prerequisites"] = "None Found"
            }
            else
            {
                let attr: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: .allZeros, error: nil)! as! NSDictionary
                
                var cList: [String] = (attr["courses"] as? [String])!
                var prereq: String = ""
                for c in cList
                {
                    if(prereq == "")
                    {
                        prereq = c
                    }
                    else
                    {
                        prereq += ", \(c)"
                    }
                }
                s["prerequisites"] = prereq
            }
            
            let request2 = NSMutableURLRequest(URL: NSURL(string: "http://boscc.io/bosccapi/GetDependentsOfCourse?cno=\(CourseNumber)")!)
            request2.HTTPMethod = "GET"
            
            var data2 = NSURLConnection.sendSynchronousRequest(request2, returningResponse: nil, error: nil)
            if(data2 == nil)
            {
                s["dependents"] = "None Found"
            }
            else
            {
                let attr2: NSDictionary = NSJSONSerialization.JSONObjectWithData(data2!, options: .allZeros, error: nil)! as! NSDictionary
                
                var cList: [String] = (attr2["courses"] as? [String])!
                var req: String = ""
                for c in cList
                {
                    if(req == "")
                    {
                        req = c
                    }
                    else
                    {
                        req += ", \(c)"
                    }
                }
                s["dependents"] = req
            }
        }
  
       
        return s
    }
    
    func GetCourseNodes(uid: String) -> (courses: [CourseNode], success: Bool)
    {
        var err: NSError?
        let request = NSMutableURLRequest(URL: NSURL(string: "http://boscc.io/bosccapi/GetCourseNodes?uid=\(uid)")!)
        request.HTTPMethod = "GET"
       // request.setValue("application/json", forHTTPHeaderField: "content-type")

        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        var ret = [CourseNode]()
        if(data == nil)
        {
            
            return (ret, false)
        }
        
        let gameAttributions: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: .allZeros, error: nil)! as! NSDictionary
        
        var majorReturned: String = gameAttributions["major"] as! String
        var coursesNeeded: [NSDictionary] = gameAttributions["coursesNeeded"] as! [NSDictionary]
        
        for entr in coursesNeeded
        {
            
                var ok: String? = entr["CourseNumber"] as? String
                
                if(ok != nil)
                {
                    var isFlex = entr["isFlex"] as! Bool
                    var temp: CourseNode! = nil
                    if(isFlex == true)
                    {
                        temp = CourseNode(_completed: entr["Completed"] as! Bool, CourseTitleSameAsFlexName: entr["CourseNumber"] as! String, _flexDescription: entr["FlexDescription"] as! String)
                    }
                    else
                    {
                        temp = CourseNode(_completed: entr["Completed"] as! Bool, _CourseNumber: entr["CourseNumber"] as! String , _CourseTitle: entr["CourseTitle"] as! String)
                    }
                    

                    //check to see if it's in progress (this is saved locally)
                    var x = dict[1] as! NSMutableDictionary
                    var y: String? = x[entr["CourseNumber"]as! String] as? String
                    
                    if(y != nil && y == "ip")
                    {
                        temp.InProgress = true
                    }
                    
                    
                    
                     ret.append(temp)
                }
        
   
        }
       
       
        return (ret, true)
        
    }
    
    func RegisterStudent(email: String, password: String, major: String, username: String) -> String
    {
        var err: NSError?
        let request = NSMutableURLRequest(URL: NSURL(string: "http://boscc.io/bosccapi/PostRegister")!)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        let jsonObject: NSDictionary = ["username": username, "password": password, "email": email, "major": major]
        let requestDict = NSJSONSerialization.dataWithJSONObject(jsonObject, options: .allZeros, error: nil)
        request.HTTPBody = requestDict
        var data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil)
        
        if(data == nil)
        {
            return "unable to create a user with username \(username) and email \(email) see help for username and and password rules"
        }
        let gameAttributions: NSDictionary? = NSJSONSerialization.JSONObjectWithData(data!, options: .allZeros, error: nil) as? NSDictionary
        
        if(gameAttributions == nil)
        {
            return "unable to create a user with username \(username) and email \(email) see help for username and and password rules"
        }
        println(gameAttributions!)
        
        var ok = gameAttributions!["success"] as! Bool
        
        if(ok)
        {
            var entry = [String: String]()
            entry["uid"] = gameAttributions!["id"] as? String
            entry["major"] = major
            entry["uname"] = username
            dict.addObject(entry)
            ToFile()
            return "success"
        }
        return gameAttributions!["message"] as! String
    }
    
    func ToFile()
    {
        let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains( .DocumentDirectory, .UserDomainMask, true)?[0] as! String?
        let filePath: String? = documentsDirectory?.stringByAppendingPathComponent("boscc124.txt")
        var arr: NSMutableArray = []
        
        
        
    
        for entry in dict
        {
            arr.addObject(entry)
        }
        
        //write to disk
        arr.writeToFile(filePath!, atomically: true)
    }
    
    func addCourseIP(cno: String)
    {
        var cIP = dict[1] as! NSMutableDictionary
        cIP[cno] = "ip"
        dict.removeLastObject()
        dict.addObject(cIP)
        
    }
    
    func LoadFile()
    {
        let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains( .DocumentDirectory, .UserDomainMask, true)?[0] as! String?
        let filePath: String? = documentsDirectory?.stringByAppendingPathComponent("boscc124.txt")
        //load in the file to memory
        let fileText = String(contentsOfFile: filePath!, encoding: NSUTF8StringEncoding, error: nil)
        dict = []
        
        var readArray: NSArray? = NSArray(contentsOfFile: filePath!)
        if let activeArray = readArray
        {
            
            for(var i=0; i < activeArray.count; i++)
            {
                var readDict: NSDictionary = activeArray[i] as! NSDictionary
             
                
                //add all the read in game saves to the master array
                dict.addObject(readDict)
            }
            
            
        }
        
    }

}