//
//  SplashView.swift
//  boscc
//
//  Created by u0658884 on 4/8/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class PortraitSplashView: UIView {
    
    let colors: ColorPallette = ColorPallette()
    private var _titleLabel: UILabel! = nil
    private var _menueButton: UIButton = UIButton()

    weak var delegate: AppStateChangedResponder? = nil
 
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        backgroundColor = colors.bosccGreen
        _titleLabel = UILabel()
        _titleLabel.text = "boscc"; _titleLabel.textAlignment = NSTextAlignment.Center
        _titleLabel.textColor = UIColor.whiteColor()
        _titleLabel.font = UIFont.boldSystemFontOfSize(80.0)

        addSubview(_titleLabel)
    
        _menueButton.backgroundColor = UIColor(patternImage: UIImage(named: "hamburger.png")!)
        _menueButton.addTarget(self, action: "Toggle", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(_menueButton)
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews()
    {
        _titleLabel.frame = CGRect(x: 0, y: bounds.midY - 100, width: bounds.width, height: 200)
 
        _menueButton.frame = CGRectMake(10, 25, 40, 40)
    }

    func Toggle()
    {
        delegate?.AppStateChanged("Toggle")
    }
    
}


class LandscapeSplashView: UIView {
    
    let colors: ColorPallette = ColorPallette()
    private var _titleLabel: UILabel! = nil
      weak var delegate: AppStateChangedResponder? = nil
    private var _menueButton: UIButton = UIButton()
    
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        backgroundColor = colors.bosccGreen
        _titleLabel = UILabel()
        _titleLabel.text = "boscc"; _titleLabel.textAlignment = NSTextAlignment.Center
        _titleLabel.textColor = UIColor.whiteColor()
        _titleLabel.font = UIFont.boldSystemFontOfSize(125.0)
        
        addSubview(_titleLabel)
        
        _menueButton.backgroundColor = UIColor(patternImage: UIImage(named: "hamburger.png")!)
        _menueButton.addTarget(self, action: "Toggle", forControlEvents: UIControlEvents.TouchUpInside)
        addSubview(_menueButton)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews()
    {
        _titleLabel.frame = CGRect(x: 0, y: bounds.midY - 100, width: bounds.width, height: 200)
        _menueButton.frame = CGRectMake(10, 25, 40, 40)
    }
    
    func Toggle()
    {
        delegate?.AppStateChanged("Toggle")
    }
    
}
