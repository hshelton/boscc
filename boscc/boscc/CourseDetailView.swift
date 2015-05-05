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
    var _results: [String: String] = [String: String]()
    var dependents: [String] = [String]()
     var prerequisites: [String] = [String]()
      private var _back: UIButton = UIButton()
    var isFlex : Bool = false
    weak var delegate: AppStateChangedResponder? = nil
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        xibSetup()
        
        
     
    }
    
    //The initializer that will be called from 
    init (frame: CGRect, _courseNumber: String, _isFlex:Bool, results: [String: String])
    {
        courseNumber = _courseNumber
        super.init(frame: frame)
        xibSetup()
        _results = results
        var viewOfferings: UIButton = UIButton(frame: CGRect(x: 10, y: 20, width: frame.width - 20 , height: 30))
        var label: UILabel = UILabel(frame: viewOfferings.frame)
        label.text = courseNumber + " - " + results["title"]!
        
        label.textColor = UIColor.whiteColor()
        label.textAlignment = NSTextAlignment.Center
        
        viewOfferings.addSubview(label)
        view.addSubview(viewOfferings)
        isFlex = _isFlex
        _back.setBackgroundImage(UIImage(named: "back.png"), forState: UIControlState.Normal)
        _back.addTarget(self, action: "Toggle", forControlEvents: UIControlEvents.TouchUpInside)
        _back.frame = CGRect(x: 10, y: 20, width: 30, height: 30)
        addSubview(_back)
        
        view.backgroundColor = ColorPallette().bosccGreen
        viewOfferings.backgroundColor = view.backgroundColor
        var dTemp: String? = _results["dependents"]
        if(dTemp != nil)
        {
            var Arr = dTemp!.componentsSeparatedByString(", ")
            for d in Arr
            {
                dependents.append(d)
            }
        }
        
        var pTemp: String? = _results["prerequisites"]
        if(pTemp != nil)
        {
            var Arr2 = pTemp!.componentsSeparatedByString(", ")
            for p in Arr2
            {
                prerequisites.append(p)
            }
        }
        
    }
 
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    var view: UIView!
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
     
        var cell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: nil)
        if(indexPath.section == 0)
        {
        cell.textLabel?.textColor = ColorPallette().lightBlue
        cell.textLabel?.text = _results["description"]
          
        }
        if(indexPath.section == 1)
        {
            cell.textLabel?.text = prerequisites[indexPath.row]
        }
        
        if(indexPath.section == 2)
        {
          
            cell.textLabel?.text = dependents[indexPath.row]
        }
        if(indexPath.section == 3)
        {
            cell.textLabel?.textColor = ColorPallette().lightBlue
            cell.textLabel?.text = "Tap Here"
        }
        return cell
    }

    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
   
        if (indexPath.section == 0 && indexPath.row == 0)
        {
            var alert: UIAlertView = UIAlertView(title: " Course Description", message: _results["description"], delegate: nil, cancelButtonTitle: "Ok")
            alert.show()
        }
        
        if(indexPath.section == 3)
        {
            var msg: [String] = ApiConnection().GetCourseTimes(courseNumber, IsFlex: isFlex)
            var msg2: String = ""
            for  m in msg
            {
                msg2 += m + "\n \n"
            }
            
            if(msg2 == "")
            {
                msg2 = "No results found. Check back in a few weeks"
            }
            
            var alert: UIAlertView = UIAlertView(title: "Scheduling Options", message: msg2, delegate: nil, cancelButtonTitle: "Ok")
            alert.show()
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section)
        {
        case 0: return 1
        case 1: return prerequisites.count
        case 2: return dependents.count
        case 3: return 1
        default: return 1
        }
        
    }
    

    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section)
        {
        case 0: return "Description"
        case 1: return "Prerequisites"
        case 2: return "Dependents"
        case 3: return "Scheduling Options"
        default: return ""
        }
       
    }
    

    //implementing the protocol required functions
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 4
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
    
    func Toggle()
    {
        delegate?.AppStateChanged("Close")
    }
    

    
}

