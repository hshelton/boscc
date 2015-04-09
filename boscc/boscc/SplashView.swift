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

    weak var delegate: AppStateChangedResponder? = nil
    override init (frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    override init()
    {
        super.init()
        backgroundColor = colors.bosccGreen
        _titleLabel = UILabel()
        _titleLabel.text = "boscc"; _titleLabel.textAlignment = NSTextAlignment.Center
        _titleLabel.textColor = UIColor.whiteColor()
        _titleLabel.font = UIFont.boldSystemFontOfSize(80.0)

        addSubview(_titleLabel)
    }

    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews()
    {
        _titleLabel.frame = CGRect(x: 0, y: bounds.midY - 100, width: bounds.width, height: 200)
    }

    
    
}


class LandscapeSplashView: UIView {
    
    let colors: ColorPallette = ColorPallette()
    private var _titleLabel: UILabel! = nil
      weak var delegate: AppStateChangedResponder? = nil
    
    override init (frame: CGRect)
    {
        super.init(frame: frame)
    }
    
    override init()
    {
        super.init()
        backgroundColor = colors.bosccGreen
        _titleLabel = UILabel()
        _titleLabel.text = "boscc"; _titleLabel.textAlignment = NSTextAlignment.Center
        _titleLabel.textColor = UIColor.whiteColor()
        _titleLabel.font = UIFont.boldSystemFontOfSize(125.0)
        
        addSubview(_titleLabel)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews()
    {
        _titleLabel.frame = CGRect(x: 0, y: bounds.midY - 100, width: bounds.width, height: 200)
    }
    
    
    
}
