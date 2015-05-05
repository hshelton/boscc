//
//  CourseNode.swift
//  boscc
//
//  Created by Hayden Shelton on 4/27/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import Foundation

class CourseNode
{
    var Complete: Bool! = false
    var CourseNumber: String! = nil
    var CourseTitle: String! = nil
    var InProgress: Bool?
    var IsFlex: Bool! = false
    var FlexDescription: String! = nil

    
    init(_completed: Bool, _CourseNumber: String, _CourseTitle: String)
    {
        Complete = _completed
        CourseNumber = _CourseNumber
        CourseTitle = _CourseTitle
    }
    
    //initializer for a flex course
    init(_completed: Bool,  CourseTitleSameAsFlexName: String, _flexDescription: String)
    {
        IsFlex = true
        Complete = _completed
        //note that a flex course node's title is the flexname from the database
        CourseTitle = CourseTitleSameAsFlexName
        FlexDescription = _flexDescription
    }
    
    
    func getIP() -> Bool
    {
        if(InProgress == nil)
        {
            InProgress = false
            return false
        }
        else
        {
            return InProgress!
        }
    }
    
    
    
    
}