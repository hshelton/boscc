//
//  ViewController.swift
//  boscc
//
//  Created by u0658884 on 4/8/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class ApplicationViewController: UIViewController, AppStateChangedResponder, UIPopoverPresentationControllerDelegate {

    var portraitView: PortraitSplashView = PortraitSplashView()
    var landscapeView: LandscapeSplashView = LandscapeSplashView()
    var menueViewController: MenueViewController = MenueViewController()
    var vizVC: VizViewController = VizViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = true
    
    }

    
  override func loadView() {
    view = portraitView
    portraitView.delegate = self
    landscapeView.delegate = self
    menueViewController.delegate = self
    
    navigationController?.navigationBarHidden = true
 
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
}

protocol AppStateChangedResponder :class
{
    func AppStateChanged(reason: String)
    
}