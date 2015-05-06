//
//  MenueView.swift
//  boscc
//
//  Created by Hayden Shelton on 4/16/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class MenueView: UIView {
    
    let colors: ColorPallette = ColorPallette()
  
    private var _visualizeButton: UIButton = UIButton()
    private var _settings: UIButton = UIButton()
    private var _helpButton: UIButton = UIButton()
    private var _back: UIButton = UIButton()
    private var _titleLabel: UILabel = UILabel()
    
    weak var delegate: AppStateChangedResponder? = nil
 
    
    override init(frame: CGRect)
    {
    
        super.init(frame: frame)
        
        _back.setBackgroundImage(UIImage(named: "back.png"), forState: UIControlState.Normal)
        _back.addTarget(self, action: "Toggle", forControlEvents: UIControlEvents.TouchUpInside)
        
        _visualizeButton.setTitle("Visualize", forState: UIControlState.Normal)
  
        _visualizeButton.backgroundColor = colors.darkGray
      
        _visualizeButton.addTarget(self, action: "Viz", forControlEvents: UIControlEvents.TouchUpInside)
       
        _settings.setTitle("Settings", forState: .Normal)
        _settings.backgroundColor = colors.darkGray
        _settings.addTarget(self, action: "Settings", forControlEvents: UIControlEvents.TouchUpInside)
     
        _helpButton.setTitle("Help/Tutorial", forState: UIControlState.Normal)
        _helpButton.backgroundColor = colors.darkGray
        _helpButton.addTarget(self, action: "Help", forControlEvents: UIControlEvents.TouchUpInside)
  
        _titleLabel = UILabel()
        _titleLabel.text = "boscc"; _titleLabel.textAlignment = NSTextAlignment.Center
        _titleLabel.textColor = UIColor.whiteColor()
        _titleLabel.font = UIFont.boldSystemFontOfSize(60.0)
        
        backgroundColor = colors.bosccGreen
        
        addSubview(_visualizeButton)
             addSubview(_settings)
        addSubview(_helpButton)
   
        addSubview(_back)
        addSubview(_titleLabel)
        
        
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews()
    {
        var r: CGRect = bounds; var temp :CGRect = CGRectZero
        
        _back.frame = CGRect(x: 10, y: 20, width: 30, height: 30)
        
        (temp, r) = bounds.rectsByDividing(r.height/2, fromEdge: .MinYEdge)
        _titleLabel.frame = temp
        
        (_visualizeButton.frame, r) = r.rectsByDividing(r.height/3, fromEdge: CGRectEdge.MinYEdge)
        _visualizeButton.frame.offset(dx: 0, dy: -2.0)
         (_settings.frame, r) = r.rectsByDividing(r.height/2, fromEdge: CGRectEdge.MinYEdge)
        _helpButton.frame = r
        _settings.frame.offset(dx: 0.0, dy: 0.0)
        _helpButton.frame.offset(dx: 0.0, dy: 2.0)
        setNeedsDisplay()
    }
    func Help()
    {
        delegate?.AppStateChanged("Help")
    }
    
    func Settings()
    {
        delegate?.AppStateChanged("Settings")
    }
    
    func Toggle()
    {
        delegate?.AppStateChanged("Toggle")
    }
    func Viz()
    {
        delegate?.AppStateChanged("Viz")
    }
}
