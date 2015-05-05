//
//  LoadingViewController.swift
//  boscc
//
//  Created by Hayden Shelton on 4/30/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class LoadingViewController: UIViewController {
    
    
    override func loadView() {
        super.loadView()
        var image: UIImage = UIImage.animatedImageNamed("image", duration: 2.0)
        var label: UILabel = UILabel(frame: CGRect(x: 10, y: 320, width: UIScreen.mainScreen().bounds.width - 20, height: 40))
        var font = UIFont.boldSystemFontOfSize(22)
        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        label.text = "Talking to Server"
    
        view = UIView(frame: CGRect(x: 0, y: 80, width: UIScreen.mainScreen().bounds.width/2, height: UIScreen.mainScreen().bounds.height/4))
    
        view.backgroundColor = ColorPallette().bosccGreen
        var UIV: UIImageView = UIImageView(image: image)
        UIV.frame.inset(dx: 50, dy: 50)
        
        view.addSubview(UIV)
        view.addSubview(label)
    }
    override func viewDidLoad() {
      

    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
