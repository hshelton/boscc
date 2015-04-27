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
                     ret.append(CourseNode(_completed: entr["Completed"] as! Bool, _CourseNumber: entr["CourseNumber"] as! String , _CourseTitle: entr["CourseTitle"] as! String))
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
        let gameAttributions: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: .allZeros, error: nil)! as! NSDictionary
        println(gameAttributions)
        
        var ok = gameAttributions["success"] as! Bool
        
        if(ok)
        {
            var entry = [String: String]()
            entry["uid"] = gameAttributions["id"] as? String
            entry["major"] = major
            entry["uname"] = username
            dict.addObject(entry)
            ToFile()
            return "success"
        }
        return gameAttributions["message"] as! String
    }
    
    func ToFile()
    {
        let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains( .DocumentDirectory, .UserDomainMask, true)?[0] as! String?
        let filePath: String? = documentsDirectory?.stringByAppendingPathComponent("bosccConf.txt")
        var arr: NSMutableArray = []
        
        
        
        //add all the game saves to the master array
        for entry in dict
        {
            arr.addObject(entry)
        }
        
        //write to disk
        arr.writeToFile(filePath!, atomically: true)
    }
    
    
    func LoadFile()
    {
        let documentsDirectory: String? = NSSearchPathForDirectoriesInDomains( .DocumentDirectory, .UserDomainMask, true)?[0] as! String?
        let filePath: String? = documentsDirectory?.stringByAppendingPathComponent("bosccConf.txt")
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