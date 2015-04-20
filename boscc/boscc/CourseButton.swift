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
    var networkColored = false
    
    let colors = ColorPallette()
    
    var toggleSwitch: Int = 1
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        tL.text = "CS1410"
        tL.textAlignment = NSTextAlignment.Center
        tL.frame = frame
        tL.frame.offset(dx: 0, dy: -5)
        addSubview(tL)
        var gesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "showMessage")
        
        gesture.minimumPressDuration = 1.5
        
        self.addGestureRecognizer(gesture)
        
        
       self.addTarget(self, action: "toggleColor", forControlEvents: UIControlEvents.TouchDownRepeat)
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
