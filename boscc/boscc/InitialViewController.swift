//
//  ViewController.swift
//  boscc
//
//  Created by u0658884 on 4/8/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController, AppStateChangedResponder {
    
    var portraitView: PortraitSplashView = PortraitSplashView()
    var landscapeView: LandscapeSplashView = LandscapeSplashView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func loadView() {
        view = portraitView
        view.backgroundColor = UIColor.blackColor()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func AppStateChanged(reason: String) {
     
    }
    

}

