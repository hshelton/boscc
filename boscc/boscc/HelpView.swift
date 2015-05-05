//
//  HelpView.swift
//  boscc
//
//  Created by Hayden Shelton on 5/2/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class HelpView: UIView
{

var prerequisites: [String] = [String]()
private var _back: UIButton = UIButton()
weak var delegate: AppStateChangedResponder? = nil
override init(frame: CGRect)
{
    super.init(frame: frame)
   
        backgroundColor = ColorPallette().bosccGreen
    var viewOfferings: UIButton = UIButton(frame: CGRect(x: 10, y: 20, width: frame.width - 20 , height: 30))
    var label: UILabel = UILabel(frame: viewOfferings.frame)
    label.text = "Help"
    
    label.textColor = UIColor.whiteColor()
    label.textAlignment = NSTextAlignment.Center
    
    viewOfferings.addSubview(label)
    addSubview(viewOfferings)
    
    _back.setBackgroundImage(UIImage(named: "back.png"), forState: UIControlState.Normal)
    _back.addTarget(self, action: "Toggle", forControlEvents: UIControlEvents.TouchUpInside)
    _back.frame = CGRect(x: 10, y: 20, width: 30, height: 30)
    addSubview(_back)
    
    var helpButton: UIButton = UIButton(frame: CGRect(x: 0, y: frame.height/2  - 80, width: frame.width - 60, height: 40))
    helpButton.backgroundColor = ColorPallette().darkGray
    helpButton.addTarget(self, action: "link", forControlEvents: UIControlEvents.TouchUpInside)
    helpButton.setTitle("View Tutorial", forState: UIControlState.Normal)
    helpButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    addSubview(helpButton)
    
    var helpButton2: UIButton = UIButton(frame: CGRect(x: 0, y: frame.height/2 - 80, width: frame.width - 60, height: 40))
    helpButton2.frame.offset(dx: 0, dy: 45)
    helpButton2.backgroundColor = ColorPallette().darkGray
    helpButton2.addTarget(self, action: "link2", forControlEvents: UIControlEvents.TouchUpInside)
    helpButton2.setTitle("FAQs and Support", forState: UIControlState.Normal)
    helpButton2.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    addSubview(helpButton2)
    
    

    
    setNeedsDisplay()
}



required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
}

    func link()
    {
        let url = NSURL(string: "http://boscc.io/iosTutorial")
       
        
        let application=UIApplication.sharedApplication()
        
        application.openURL(url!);
    }
    func link2()
    {
        let url = NSURL(string: "http://boscc.io/iosHelp")
        
        
        let application=UIApplication.sharedApplication()
        
        application.openURL(url!);
    }
    
  
func Toggle()
{
    delegate?.AppStateChanged("Close")
}

}