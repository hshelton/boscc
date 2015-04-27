//
//  VizViewController.swift
//  boscc
//
//  Created by Hayden Shelton on 4/17/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class VizViewController: UIViewController, UIScrollViewDelegate {
    var graphView: VizView!
    var sView: UIScrollView!
    var colors = ColorPallette()
    var _back: UIButton = UIButton();
    var _label: UILabel = UILabel()
     weak var modelDelegate: UserModelExchanger? = nil
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var buttonHeight: CGFloat = 85.0
        var user: BosccStudent = modelDelegate!.RequestUserModel()
        var courses: [CourseNode] = [CourseNode]()
        var ok: Bool = false
        var con: ApiConnection = ApiConnection()
        (courses, ok) = con.GetCourseNodes(user.uid!)
        
        if(!ok)
        {
            var msg = "Something went wrong while talking to the server. If the error persists, email support for assistance. See help page for more details"
            var alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertControllerStyle.ActionSheet)
            alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default, handler: {(alert: UIAlertAction!) in
                
                self.navigationController?.popToRootViewControllerAnimated(false)}))
            
            self.navigationController?.presentViewController(alert, animated: false, completion: nil)
          
   
 
        
        }
        if(UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft || UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight)
        {
            graphView = VizView(frame: CGRect(x: 0, y: 0, width: view.bounds.width * 2, height: 1000))
            buttonHeight = 60
            
            for c in courses
            {
                var dn: String = ""
                
            
                var temp: CourseButton = CourseButton(frame: CGRect(x: 0.0, y: 8, width: view.bounds.width*2/6, height: buttonHeight), courseNumberOrFlexName: c.CourseNumber,  _isFlex: c.IsFlex, _inProgress: false, _complete: c.Complete)
                
                graphView.addCourseButton(temp, name: c.CourseNumber)
            }
          
        }
        else
        {
            graphView = VizView(frame: CGRect(x: 0, y: 0, width: view.bounds.width * 2, height: 1400))
            for c in courses
            {
                var dn: String = ""
                
                
                var temp: CourseButton = CourseButton(frame: CGRect(x: 0.0, y: 8, width: view.bounds.width*2/6, height: buttonHeight), courseNumberOrFlexName: c.CourseNumber,  _isFlex: c.IsFlex, _inProgress: false, _complete: c.Complete)
                
                graphView.addCourseButton(temp, name: c.CourseNumber)
            }
        }
        

        //graphView.backgroundColor = UIColor(patternImage: (UIImage(named:"texture.jpg"))!)
        graphView.backgroundColor = colors.vizualizeBGColor
        
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
        
        _label.text = "Major: CS - 2014"
        _label.frame = CGRect(x:30, y: 30, width: view.bounds.width - 45,height: 20)
        _label.textColor = UIColor.whiteColor()
        _label.textAlignment = NSTextAlignment.Center
        

        sView.delegate = self
        view.addSubview(sView)
        view.addSubview(_back)
        view.addSubview(_label)
    }
  
    override func viewWillAppear(animated: Bool) {
              sView.zoomToRect(CGRect(x: 0, y: 25, width: 2000, height: 25), animated: false)
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        var test = scrollView.contentScaleFactor
        
        var x = 32
        return graphView
    }



    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        if(UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft || UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight)
        {
            viewDidLoad()
        }
        else
        {
           viewDidLoad()
        }
    }
    
    func poptoroot()
    {
        self.navigationController?.popToRootViewControllerAnimated(false)
    }
   
    func Toggle()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }

}
