//
//  VizViewController.swift
//  boscc
//
//  Created by Hayden Shelton on 4/17/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class VizViewController: UIViewController, UIScrollViewDelegate,  AppStateChangedResponder, CourseResponder, courseChanger{
    var graphView: VizView!
    var sView: UIScrollView!
    var colors = ColorPallette()
    var _back: UIButton = UIButton();
    var _label: UILabel = UILabel()
    var loadingVC = UIViewController()
    var lv: LoadingView = LoadingView()
    var courses: [CourseNode]! = nil
    var flexCourses: [CourseNode]! = nil
    var courseStates: [String: Int] = [String: Int]()
    weak var modelDelegate: UserModelExchanger? = nil
    weak var courseNodeDelegate: CourseResponder? = nil
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func loadView() {
    
        super.loadView()
        var buttonHeight: CGFloat = 85.0
      
     
        var courses: [CourseNode] = courseNodeDelegate!.supplyCourseNodes()
        var flexCourses: [CourseNode] = courseNodeDelegate!.supplyFlexNodes()
        var con: ApiConnection = ApiConnection()
 
        
        if(flexCourses.count == 0 || courses.count == 0)
        {
            var msg = "Something went wrong while talking to the server. If the error persists, email support for assistance. See help page for more details"
            var alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertControllerStyle.ActionSheet)
            alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in
                
                self.navigationController?.popToRootViewControllerAnimated(false)}))
            
            self.navigationController?.presentViewController(alert, animated: false, completion: nil)

        }
        var _ok: UIButton = UIButton()
        _ok.backgroundColor = ColorPallette().darkGray
        var titleLabel = UILabel()
        titleLabel.text = "Save"
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.font = UIFont.systemFontOfSize(14)
        titleLabel.frame = CGRect(x: 0, y: 0, width: 40, height: 20)

        
        if(UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft || UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight)
        {
            _ok.frame = CGRect(x: UIScreen.mainScreen().bounds.width - 50, y: 27, width: 40, height: 20)
            _ok.addSubview(titleLabel)
            _ok.addTarget(self, action: "Save", forControlEvents: UIControlEvents.TouchUpInside)
            _ok.addSubview(titleLabel)
            graphView = VizView(frame: CGRect(x: 0, y: 0, width: view.bounds.width * 2, height: 1500))
            buttonHeight = 80
            graphView.addseparator("Major Requirements - Courses You Have to Take")
            for c in courses
            {
                var dn: String = ""
                
             var ip = c.getIP()
                var temp: CourseButton = CourseButton(frame: CGRect(x: 0.0, y: 8, width: view.bounds.width*2/6, height: buttonHeight), courseNumberOrFlexName: c.CourseNumber,  _isFlex: c.IsFlex, _inProgress: ip, _complete: c.Complete)
                temp.delegate = self
                temp.courseChangedDelagate = self
                graphView.addCourseButtonLandscape(temp, name: c.CourseNumber)
            }
            graphView.addseparator("Flexible Requirements  - One or More Choices")
            for c in flexCourses
            {
                var dn: String = ""
                 var ip = c.getIP()
                
                var temp: CourseButton = CourseButton(frame: CGRect(x: 0.0, y: 8, width: view.bounds.width*2/6, height: buttonHeight), courseNumberOrFlexName: c.CourseTitle,  _isFlex: c.IsFlex, _inProgress: ip, _complete: c.Complete)
                temp.courseNumber = c.CourseTitle
                temp.delegate = self
                temp.courseChangedDelagate = self
                graphView.addCourseButtonLandscape(temp, name: c.CourseTitle)
            }
        }
        else
        {
            _ok.frame = CGRect(x: UIScreen.mainScreen().bounds.width - 50, y: 30, width: 40, height: 20)
            _ok.addSubview(titleLabel)
            _ok.addTarget(self, action: "Save", forControlEvents: UIControlEvents.TouchUpInside)
            _ok.addSubview(titleLabel)
            
            graphView = VizView(frame: CGRect(x: 0, y: 0, width: view.bounds.width * 2, height: 1800))
            graphView.addseparator("Major Requirements - Courses You Have to Take")
            for c in courses
            {
                var dn: String = ""
                
                var ip = c.getIP()
                var temp: CourseButton = CourseButton(frame: CGRect(x: 0.0, y: 8, width: view.bounds.width*2/6, height: buttonHeight), courseNumberOrFlexName: c.CourseNumber,  _isFlex: c.IsFlex, _inProgress: ip, _complete: c.Complete)
                temp.delegate = self
                temp.courseChangedDelagate = self
                graphView.addCourseButton(temp, name: c.CourseNumber)
            }
            graphView.addseparator("Flexible Requirements - One or More Choices")
            for c in flexCourses
            {
                var dn: String = ""
                
                 var ip = c.getIP()
                var temp: CourseButton = CourseButton(frame: CGRect(x: 0.0, y: 8, width: view.bounds.width*2/6, height: buttonHeight), courseNumberOrFlexName: c.CourseTitle,  _isFlex: c.IsFlex, _inProgress: ip, _complete: c.Complete)
                temp.courseNumber = c.CourseTitle
                temp.delegate = self
                temp.courseChangedDelagate = self
                graphView.addCourseButton(temp, name: c.CourseTitle)
            }
            
        }
        

        //graphView.backgroundColor = UIColor(patternImage: (UIImage(named:"texture.jpg"))!)
        graphView.backgroundColor = colors.lightGray
        
        sView = UIScrollView(frame: view.bounds)
        sView.backgroundColor = colors.bosccGreen
        sView.contentSize = graphView.bounds.size
        sView.setZoomScale(0.5, animated: true)
        sView.contentOffset = CGPoint(x: 0, y: -60)
        sView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        sView.scrollEnabled = true
  
        sView.maximumZoomScale = 3.0
        sView.minimumZoomScale = 0.5

        sView.addSubview(graphView)
       
        _back.setBackgroundImage(UIImage(named: "back.png"), forState: UIControlState.Normal)
        _back.addTarget(self, action: "Toggle", forControlEvents: UIControlEvents.TouchUpInside)
        _back.frame = CGRect(x: 10, y: 20, width: 30, height: 30)
        
        _label.text = "Major: \(con.getMajor()) - 2014"
    
        _label.frame = CGRect(x:30, y: 30, width: view.bounds.width - 45,height: 20)
        _label.textColor = UIColor.whiteColor()
        _label.textAlignment = NSTextAlignment.Center
        

        sView.delegate = self
        
        view.addSubview(sView)
        view.addSubview(_back)
         view.addSubview(_ok)
        view.addSubview(_label)
       
    }
  
    override func viewWillAppear(animated: Bool) {

        if(sView == nil)
        {
            sView = UIScrollView()
        }
              sView.zoomToRect(CGRect(x: 0, y: 25, width: 2000, height: 25), animated: false)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        var test = scrollView.contentScaleFactor
        
        var x = 32
        return graphView
    }

    func AppStateChanged(reason: String) {
        
        if(reason == "Close")
        {
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
    }
    //called from inside a graph view
    func Save()
    {
        var uid = ApiConnection().getUid()
        var con = ApiConnection()
        
        //coursestates keeps track of any courses that have been edited by the user
        for c in courseStates.keys
        {
            //if the course isn't in progress
            if(courseStates[c] != 2)
            {
            con.ToggleCourse(c, uid: uid)
            }
            else
            {
                con.addCourseIP(c)
            }
        }
        
        con.ToFile()
        
        var alert = UIAlertView(title: "Saved", message: "Your info has been saved", delegate: nil, cancelButtonTitle: "ok")
        alert.show()
    }
    

    //creates a new viewcontroller to display a course detail view for this course
    func presentDetailsForCourse(courseNumber: String, flex: Bool)
    {
        var lvc = LoadingViewController();
        self.navigationController?.pushViewController(lvc, animated: false)
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) {
            dispatch_async(dispatch_get_main_queue()) {
                var con = ApiConnection()
                var uid = con.getUid()
                var results = con.GetCourseDetails(courseNumber, IsFlex: flex)
                self.navigationController?.popViewControllerAnimated(false)
                
                var pC = UIViewController()
                
                var r  = UIScreen.mainScreen().bounds
                var pcView = CourseDetailView(frame: r, _courseNumber: courseNumber, _isFlex: flex, results: results)
                pcView.delegate = self
                pC.view = pcView
          
        
                
                self.presentViewController(pC, animated: true, completion: nil)
            }
            
        }
        
        
        
        

      
    }
    func supplyCourseNodes() -> [CourseNode] {
        return [CourseNode]()
    }
    func supplyFlexNodes() -> [CourseNode] {
        return [CourseNode]()
    }
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
       loadView()
    }
    
    
    func poptoroot()
    {
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
   
    func Toggle()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //keep track of changes in course taken states
    func changed(cb: CourseButton) {
        
        var cname :String = cb.courseNumber
        var state: Int  = cb.toggleSwitch
        
        courseStates[cname] = state
    }

}


