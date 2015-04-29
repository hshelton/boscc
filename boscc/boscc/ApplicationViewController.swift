//
//  ViewController.swift
//  boscc
//
//  Created by u0658884 on 4/8/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class ApplicationViewController: UIViewController, AppStateChangedResponder, UIPopoverPresentationControllerDelegate, UserModelExchanger{

    var portraitView: PortraitSplashView = PortraitSplashView()
    var landscapeView: LandscapeSplashView = LandscapeSplashView()
    var menueViewController: MenueViewController = MenueViewController()
    var vizVC: VizViewController = VizViewController()
    var settingsVC: SettingsViewController = SettingsViewController()
    var con: ApiConnection = ApiConnection()
    var user: BosccStudent = BosccStudent()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = true
        
    }

  override func loadView() {
    con = ApiConnection()
    var uid = con.getUid()
    if(uid == "NOT FOUND")
    {
        user.loggedIn = false
    }
    else
    {
        user.loggedIn = true
        user.uname = con.getUname()
        user.uid = con.getUid()
        user.major = con.getMajor()
        

        
        
    }
    portraitView.delegate = self
    landscapeView.delegate = self
    portraitView.modelDelegate = self
    landscapeView.modelDelegate = self
    menueViewController.delegate = self
    settingsVC.delegate = self
    settingsVC.modelDelegate = self
    vizVC.modelDelegate = self
    
    if(user.uid != nil)
    {
        portraitView._welcomeLabel.text = "Welcome, \n" +
        user.uname!
        portraitView._welcomeLabel.numberOfLines = 0
        portraitView._welcomeLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        portraitView._welcomeLabel.font = UIFont.boldSystemFontOfSize(14.0)
        portraitView._welcomeLabel.frame = CGRect(x: UIScreen.mainScreen().bounds.width - 50, y: 10, width: 180, height:60)
   
        landscapeView._welcomeLabel.text = "Welcome, \n" +
        user.uname!
        landscapeView._welcomeLabel.numberOfLines = 0
        landscapeView._welcomeLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        landscapeView._welcomeLabel.font = UIFont.boldSystemFontOfSize(14.0)
        
        landscapeView._welcomeLabel.frame = CGRect(x: UIScreen.mainScreen().bounds.width - 250, y: 10, width: 200, height: 60)
    }
    view = portraitView

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func AppStateChanged(reason: String) {
        switch(reason)
        {
            case "initial":
       
                break
            case "Toggle":
            
            navigationController?.pushViewController(menueViewController, animated: true)
            break
            case "Close":
            navigationController?.popToRootViewControllerAnimated(true)
            
            case "Viz":
            navigationController?.pushViewController(vizVC, animated: true)
            break
        
            case "Settings":
                    navigationController?.pushViewController(settingsVC, animated: true)
            break
            case "reload":
             loadView()
            break
        default:
            return
        }
    }
    

    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        if(UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeLeft || UIDevice.currentDevice().orientation == UIDeviceOrientation.LandscapeRight)
        {
            view = landscapeView
        }
        else
        {
            view = portraitView
        }
        
       view.setNeedsDisplay()
    }
    
    func RequestUserModel() -> BosccStudent {
        return user
    }
    func UpdateYourModel(model: BosccStudent) {
        user = model
    }
}

protocol CourseResponder: class
{
    func presentDetailsForCourse(courseNumber: String, flex: Bool)
    
}
protocol TryRegister: class
{
    func Register(username: String, password: String, email: String, major: String) -> String
}

protocol UserModelExchanger: class
{
    func RequestUserModel() -> BosccStudent
    
    func UpdateYourModel(model: BosccStudent)
}

protocol AppStateChangedResponder :class
{
    func AppStateChanged(reason: String)
    
}