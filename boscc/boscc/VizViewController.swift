//
//  VizViewController.swift
//  boscc
//
//  Created by Hayden Shelton on 4/17/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class VizViewController: UIViewController, UIScrollViewDelegate {
    var graphView: UIView!
    var scrollView: VizView!
    var colors = ColorPallette()
    var _back: UIButton = UIButton();
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        graphView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 1400))
        graphView.backgroundColor = UIColor.whiteColor()
        scrollView = VizView(frame: view.bounds)
        scrollView.backgroundColor = colors.bosccGreen

        scrollView.contentSize = graphView.bounds.size
        scrollView.contentOffset = CGPoint(x: 0, y: -60)
        scrollView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        scrollView.delaysContentTouches = true
      
        scrollView.addSubview(graphView)
        view.addSubview(scrollView)
        
        _back.setBackgroundImage(UIImage(named: "back.png"), forState: UIControlState.Normal)
        _back.addTarget(self, action: "Toggle", forControlEvents: UIControlEvents.TouchUpInside)
        _back.frame = CGRect(x: 10, y: 25, width: 35, height: 35)
        view.addSubview(_back)
    }

   
    func Toggle()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }

}
