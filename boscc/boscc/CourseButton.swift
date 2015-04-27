//
//  CourseButton.swift
//  boscc
//
//  Created by Hayden Shelton on 4/18/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class CourseButton : UIButton
{
    
    var tL: UILabel = UILabel()
    var courseNumber: String = "NA"
    var flexName: String = "NA"
    var networkColored = false
    var isFlex: Bool = false
    var inProgress: Bool = false
    var complete: Bool = false
    let colors = ColorPallette()
    
    var toggleSwitch: Int = 1
    
    init(frame: CGRect, courseNumberOrFlexName: String,  _isFlex: Bool, _inProgress: Bool, _complete: Bool)
    {
        super.init(frame: frame)
        tL.text = courseNumberOrFlexName
        tL.textAlignment = NSTextAlignment.Center
        tL.frame = frame
        tL.frame.offset(dx: 0, dy: -5)
        if(_isFlex)
        {
            flexName = courseNumberOrFlexName
            isFlex = true
        }
        else
        {
            courseNumber = courseNumberOrFlexName
        }
        if(_inProgress)
        {
            toggleSwitch = 3
            inProgress = true
        }
        else if(_complete)
        {
            toggleSwitch = 2
            complete = true
        }
            //take care of nonsensical parameters
        else if(!_inProgress && !complete || _inProgress && _complete)
        {
            inProgress = false; complete = false
        }
        addSubview(tL)
        var gesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "showMessage")
        
        gesture.minimumPressDuration = 1.5
        
        self.addGestureRecognizer(gesture)
        
        self.addTarget(self, action: "toggleColor", forControlEvents: UIControlEvents.TouchDownRepeat)
    }
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func showMessage()
    {
        if(toggleSwitch == 1)
        {
        let alert = UIAlertView()
        alert.title = "View Schedule"
        alert.message = "Show Class Times for \(tL.text!)?"
        alert.addButtonWithTitle("Ok")
        alert.addButtonWithTitle("Cancel")
     
        alert.show()
        
        }
    
    }
    
    func toggleColor()
    {
        if(toggleSwitch > 3)
        {
            toggleSwitch = 1
        }
        toggleSwitch++
       setNeedsDisplay()
    }

    func markTaken()
    {
        toggleSwitch = 2
        setNeedsDisplay()
    }
    
    func markIp()
    {
        toggleSwitch = 3
        setNeedsDisplay()
    }
    override func drawRect(rect: CGRect) {
        
        var color: UIColor = colors.notTakenColor
        if(toggleSwitch == 2)
        {
            color = colors.takenColor
        }
        
        if(toggleSwitch == 3)
        {
            color = colors.inPorgressColor
        }
        
        var path = UIBezierPath(ovalInRect: rect.rectByInsetting(dx: 3, dy: 3))
    
      
        let context: CGContext = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, 0.0)
   
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextAddPath(context,  path.CGPath)
        CGContextDrawPath(context, kCGPathFillStroke)

    }
    
  
    
    
    
    
    
    
}
