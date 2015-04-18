//
//  VizView.swift
//  boscc
//
//  Created by Hayden Shelton on 4/17/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class VizView:  UIScrollView {


    var model: StudentDataModel = StudentDataModel()
    weak var del: AppStateChangedResponder? = nil
  
    
    override init()
    {
        super.init()
        

    
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawRect(rect: CGRect) {
        
    }

}
