//
//  CourseDetailView.swift
//  boscc
//
//  Created by Hayden Shelton on 4/27/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit




@IBDesignable class CourseDetailView: UIView, UITableViewDelegate, UITableViewDataSource
{
    var courseNumber: String! = nil
   
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        xibSetup()
        
    
        var viewOfferings: UIButton = UIButton(frame: CGRect(x: 10, y: 30, width: 200, height: 30))
        var label: UILabel = UILabel(frame: viewOfferings.frame)
        label.text = "Course Details"
        viewOfferings.backgroundColor = view.backgroundColor
         label.textColor = UIColor.blueColor()
        viewOfferings.addSubview(label)
       
        view.addSubview(viewOfferings)
       
    }
 
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
     
        
        
    }
    var view: UIView!
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     
        var res = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
        res.textLabel?.text = "CS1311"
        return UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: nil)
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    

    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Prerequisites"
    }
    

    //implementing the protocol required functions
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 3
    }

    func xibSetup() {
        view = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        view.frame = frame
        
  
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "CD", bundle: bundle)
        
        // Assumes UIView is top level and only object in CustomView.xib file
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
     
        return view
    }
    
    
}

