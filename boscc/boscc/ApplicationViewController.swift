//
//  ViewController.swift
//  boscc
//
//  Created by u0658884 on 4/8/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class ApplicationViewController: UIViewController, AppStateChangedResponder {

    var portraitView: PortraitSplashView = PortraitSplashView()
    var landscapeView: LandscapeSplashView = LandscapeSplashView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    
  override func loadView() {
    view = portraitView
    portraitView.delegate = self
    landscapeView.delegate = self
 
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func AppStateChanged(reason: String) {
        switch(reason)
        {
            case "initial":
            self.navigationController?.pushViewController(InitialViewController(), animated: true)
            
            default:
            return
        }
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        if (self.interfaceOrientation == UIInterfaceOrientation.LandscapeLeft || self.interfaceOrientation == UIInterfaceOrientation.LandscapeRight)
        {
            view = landscapeView
        }
        else
        {
            view = portraitView
        }
        
       view.setNeedsDisplay()
    }
}

protocol AppStateChangedResponder :class
{
    func AppStateChanged(reason: String)
    
}