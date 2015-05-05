//
//  GamesListViewController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 3/5/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit


class MenueViewController: UIViewController, AppStateChangedResponder, CourseResponder
{
weak var delegate: AppStateChangedResponder? = nil
    var mv: MenueView = MenueView()
    var lv: LoadingView = LoadingView()
    var lvc: LoadingViewController = LoadingViewController()
    var courses: [CourseNode] = [CourseNode]()
    var flexCourses: [CourseNode] = [CourseNode]()
    var VzV: VizViewController = VizViewController()
    var coursesLoaded: Bool = false
    override func loadView() {
       mv.delegate = self
         view = mv
    }
    

    
  func AppStateChanged(reason: String) {
    switch(reason)
    {
    case "Toggle":
        delegate?.AppStateChanged("Close")
        break;
    case "Viz":
        if(ApiConnection().getUid() == "NOT FOUND")
        {
            let alert = UIAlertView()
            alert.title = "Alert"
            alert.message = "Please register first by going to the settings section";
            alert.addButtonWithTitle("ok")
            alert.show()
            return
        }
        self.navigationController?.pushViewController(lvc, animated: true)
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) { // 1
            dispatch_async(dispatch_get_main_queue()) {
                var con = ApiConnection()
                var uid = con.getUid()
                self.courses = self.supplyCourseNodes()
                self.flexCourses = self.supplyFlexNodes()
                self.coursesLoaded = true
                self.navigationController?.popViewControllerAnimated(false)
                self.VzV.courseNodeDelegate = self
                self.navigationController?.pushViewController(self.VzV, animated: false)
            }
            
        }

        break;
        
    case "Settings":
      
        delegate?.AppStateChanged("Settings")
        break;
    case "Help":
        delegate?.AppStateChanged("Help")
        break;
    default:
        return
    }
    
    }
    

    
    func presentDetailsForCourse(courseNumber: String, flex: Bool) {
        
    }
    
    func supplyCourseNodes() -> [CourseNode] {
        
        if(coursesLoaded)
        {
            var cnArr = [CourseNode]()
            for c in courses
            {
                if(c.IsFlex == false)
                {
                    cnArr.append(c)
                }
            }
            
            
            return cnArr
        }
        var apiCon = ApiConnection()
        var status = false
        var ret : [CourseNode] = [CourseNode]()
        (ret, status) = apiCon.GetCourseNodes(apiCon.getUid())
        
      
            return ret
    }
    func supplyFlexNodes() -> [CourseNode] {
        if(coursesLoaded)
        {
            var cnArr = [CourseNode]()
            for c in courses
            {
                if(c.IsFlex == true)
                {
                    cnArr.append(c)
                }
            }
            
            
            return cnArr
        }
        var apiCon = ApiConnection()
        var status = false
        var ret : [CourseNode] = [CourseNode]()
        (ret, status) = apiCon.GetCourseNodes(apiCon.getUid())
        
     
        
        return ret
    }
}


