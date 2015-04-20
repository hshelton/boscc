//
//  VizView.swift
//  boscc
//
//  Created by Hayden Shelton on 4/17/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit

class VizView:  UIView {


    var model: StudentDataModel = StudentDataModel()
    weak var del: AppStateChangedResponder? = nil
    private var cc: Int = 0
    private var rowCount: Int = 1


    override init(frame: CGRect)
    {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addCourseButtonLandscape(cb: CourseButton, name: String)
    {
        var cbX = 15
        var cbY = 15
        var prettyOffset = 0
        
        var buttonHeight = cb.frame.height
        
        let widthC = Int(bounds.width/6.2)
        //there are four 'slots' per row for course nodes
        var slotsLeftOnRow = rowCount * 6 - cc
        if(slotsLeftOnRow == 0)
        {
            rowCount++
            cbX = 15
            
        }
        else if (slotsLeftOnRow == 1)
        {
            cbX = 5 * widthC + 15
        }
        else if(slotsLeftOnRow == 2)
        {
            cbX = 4 * widthC + 15
        }
        else if (slotsLeftOnRow == 3)
        {
            cbX = 3 * widthC + 15
        }
        else if(slotsLeftOnRow == 4)
        {
            cbX = 2 * widthC + 15
        }
        else if (slotsLeftOnRow == 5)
        {
            cbX = widthC + 15
        }
        
        if(cc >= 6)
        {
            cbY = (rowCount-1) * 60 + 15
        }
        
        if(cc % 2  != 0)
        {
            prettyOffset = 25
        }
        cb.tL.text = name
        cc++
        
        println("row count: \(rowCount) cc: \(cc) cbx: \(cbX) cby: \(cbY)")
        
        cb.frame = CGRect(x: cbX, y: cbY + (50 * rowCount) - prettyOffset, width: widthC, height:Int(buttonHeight))
        
        addSubview(cb)
        setNeedsDisplay()
        
        
        
        
    }

    
    func addCourseButton(cb : CourseButton, name: String)
    {
        var cbX = 15
        var cbY = 15
        var prettyOffset = 0
      
        var buttonHeight = cb.frame.height
        
        let widthC = Int(bounds.width/4.2)
        //there are four 'slots' per row for course nodes
        var slotsLeftOnRow = rowCount * 4 - cc
        if(slotsLeftOnRow == 0)
        {
            rowCount++
            cbX = 15
 
        }
        else if (slotsLeftOnRow == 1)
        {
            cbX = 3 * widthC + 15
        }
        else if(slotsLeftOnRow == 2)
        {
            cbX = 2 * widthC + 15
        }
        else if (slotsLeftOnRow == 3)
        {
            cbX = widthC + 15
        }

        if(cc >= 4)
        {
        cbY = (rowCount-1) * 60 + 15
        }
        
        if(cc % 2  != 0)
        {
            prettyOffset = 40
        }
        cb.tL.text = name
        cc++
        
        println("row count: \(rowCount) cc: \(cc) cbx: \(cbX) cby: \(cbY)")
        
        cb.frame = CGRect(x: cbX, y: cbY + (50 * rowCount) - prettyOffset, width: widthC, height:Int(buttonHeight))
   
        addSubview(cb)
        setNeedsDisplay()
    }

}
