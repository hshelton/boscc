//
//  Loading.swift
//  boscc
//
//  Created by Hayden Shelton on 4/29/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class LoadingView: UIView
{
    weak var delegate: AppStateChangedResponder? = nil
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        var background: UIImage = UIImage(named: "loading.gif")!
        backgroundColor = UIColor(patternImage: background)
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}
