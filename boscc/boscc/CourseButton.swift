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
    weak var delegate: CourseResponder? = nil
    weak var courseChangedDelagate: courseChanger? = nil
    
    var toggleSwitch: Int = 1
    
    init(frame: CGRect, courseNumberOrFlexName: String,  _isFlex: Bool, _inProgress: Bool, _complete: Bool)
    {
        super.init(frame: frame)
        tL.text = courseNumberOrFlexName
        tL.textAlignment = NSTextAlignment.Center
        tL.frame = frame
        tL.frame.offset(dx: 20, dy: -5)
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
            toggleSwitch = 2
            inProgress = true
        }
        else if(_complete)
        {
            toggleSwitch = 3
            complete = true
        }
            //take care of nonsensical parameters
        else if(!_inProgress && !complete || _inProgress && _complete)
        {
            inProgress = false; complete = false
        }
        addSubview(tL)
        var gesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "showMessage")
        
        gesture.minimumPressDuration = 0.7
        
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
            delegate?.presentDetailsForCourse(courseNumber, flex: isFlex)
        
        }
    
    }
    
    func toggleColor()
    {
        
        if(toggleSwitch > 3)
        {
            toggleSwitch = 1
            setNeedsDisplay()
            return
        }
        toggleSwitch++
        
        courseChangedDelagate!.changed(self)
       setNeedsDisplay()
    }

    func markTaken()
    {
        toggleSwitch = 3
        setNeedsDisplay()
    }
    
    func markIp()
    {
        toggleSwitch = 2
        setNeedsDisplay()
    }
    override func drawRect(rect: CGRect) {
        
        var color: UIColor = colors.notTakenColor
        if(toggleSwitch == 3)
        {
            color = colors.takenColor
        }
        
        if(toggleSwitch == 2)
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

protocol courseChanger: class
{
    func changed(cb: CourseButton)
}
