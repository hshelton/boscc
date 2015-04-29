//
//  SettingsView.swift
//  boscc
//
//  Created by Hayden Shelton on 4/26/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//


import UIKit

class SettingsView: UIView, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{
    
    let colors: ColorPallette = ColorPallette()
    
    var unameInput: UITextField = UITextField()
    var passInput: UITextField = UITextField()
    var passInput2: UITextField = UITextField()
    var emailInput: UITextField = UITextField()
    var majorPicker: UIPickerView = UIPickerView()
    var loggedIn: Bool = false
    var _back: UIButton = UIButton()
    var _ok: UIButton = UIButton()
     var major: String = "CS"
    var _label: UILabel = UILabel()
    
    weak var delegate: AppStateChangedResponder? = nil
    weak var registerDelegate: TryRegister? = nil

    init (frame: CGRect, loggedIn: Bool)
    {
        super.init(frame: frame)
        backgroundColor = UIColor.whiteColor()
        _ok.backgroundColor = colors.darkGray
        var titleLabel = UILabel()
        titleLabel.text = "Save"
            titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
        _ok.addSubview(titleLabel)
        _ok.addTarget(self, action: "Save", forControlEvents: UIControlEvents.TouchUpInside)
        _back.setBackgroundImage(UIImage(named: "back.png"), forState: UIControlState.Normal)
        _back.addTarget(self, action: "Toggle", forControlEvents: UIControlEvents.TouchUpInside)

        if(loggedIn)
        {
            addSubview(majorPicker)
            addSubview(_back)
        }
        else
        {
            passInput.backgroundColor = UIColor.whiteColor()
            passInput2.backgroundColor = UIColor.whiteColor()
            emailInput.backgroundColor = UIColor.whiteColor()
            majorPicker.backgroundColor = UIColor.whiteColor()
            unameInput.backgroundColor = UIColor.whiteColor()
            passInput.secureTextEntry = true
            passInput2.secureTextEntry = true
            var pL1 = UILabel()
            pL1.text = "  password"
          
            pL1.frame = CGRect(x: 0, y: 10, width: bounds.width/2, height: 30)
            passInput.addSubview(pL1)
            var pL2  = UILabel()
            pL2.frame = CGRect(x: 0, y: 10, width: bounds.width/2, height: 30)
            pL2.text = "  confirm"

         
            passInput2.addSubview(pL2)
            
            var pL3  = UILabel()
            pL3.frame = CGRect(x: 0, y: 10, width: bounds.width/2, height: 30)
            pL3.text = "  username"
            unameInput.addSubview(pL3)
            
            var pL4  = UILabel()
            pL4.frame = CGRect(x: 0, y: 10, width: bounds.width/2, height: 30)
            pL4.text = "  email"
            
            emailInput.addSubview(pL4)
            
            var pL5  = UILabel()
            pL5.frame = CGRect(x: 0, y: 10, width: bounds.width/2, height: 30)
            pL5.text = "  Major"
            majorPicker.addSubview(pL5)
            
            _label.backgroundColor = colors.bosccGreen
            _label.text = "Settings"
            _label.textAlignment = NSTextAlignment.Center
            _label.textColor = UIColor.whiteColor()
          
            majorPicker.dataSource = self
            majorPicker.delegate = self
            
            passInput.delegate = self
            passInput2.delegate = self
            emailInput.delegate = self
            unameInput.delegate = self
            
             addSubview(majorPicker)
            addSubview(unameInput)
            addSubview(passInput)
            addSubview(passInput2)
            addSubview(emailInput)
         
            addSubview(_label)
            addSubview(_back)
            addSubview(_ok)
         
        }

    }
    
    
    override init(frame: CGRect)
    {
        
        super.init(frame: frame)
        
      
        
    }
    
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if(row == 0)
        {
     
        return "B.S. CS - UofU"
        }
 
        return "B.A. Economics - UofU"
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       if(row == 0)
       {
        major = "CS"
        }
        else
       {
        major = "ECON"
        }
    }
    
    required init(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews()
    {
        if(loggedIn)
        {
            majorPicker.frame = CGRect(x: CGFloat(0.0), y: bounds.midY - 100, width: bounds.width, height: CGFloat(100))
              _back.frame = CGRect(x: 10, y: 20, width: 30, height: 30)
            
        }
        else
        {
           
            var temp = CGRectZero
            var r: CGRect = bounds
            (temp, r) = bounds.rectsByDividing(r.height/7.5, fromEdge: .MinYEdge)
            _label.frame = temp
             _back.frame = CGRect(x: 10, y: 20, width: 30, height: 30)
            _ok.frame = CGRect(x: bounds.width - 80, y: 20, width: 70, height: 30)
            (unameInput.frame, r) = r.rectsByDividing(r.height/4, fromEdge: .MinYEdge)
            (emailInput.frame, r) = r.rectsByDividing(r.height/3, fromEdge: .MinYEdge)
            var passBlock: CGRect = CGRectZero
            (passBlock, r) = r.rectsByDividing(r.height/2, fromEdge: .MinYEdge)
            (passInput.frame, passInput2.frame) = passBlock.rectsByDividing(passBlock.width/2, fromEdge: .MinXEdge)
      
            majorPicker.frame = r
        
            unameInput.frame = unameInput.frame.rectByInsetting(dx: 10, dy: 0)
            emailInput.frame = emailInput.frame.rectByInsetting(dx: 10, dy: 0)
            passInput.frame = passInput.frame.rectByInsetting(dx: 10, dy: 0)
            passInput2.frame = passInput2.frame.rectByInsetting(dx: 10, dy: 0)
            majorPicker.frame = majorPicker.frame.rectByInsetting(dx: 10, dy: 0)
            
            var border = CALayer()
            var width = CGFloat(2.0)
            border.borderColor = UIColor.darkGrayColor().CGColor
            border.frame = CGRect(x: -4, y: 10 ,width:  passInput.frame.size.width, height: passInput.frame.size.height*0.5)
            border.borderWidth = width
            passInput.layer.addSublayer(border)
            passInput.layer.masksToBounds = true
            
            border = CALayer()
            border.frame = CGRect(x: -4, y: 10 ,width:  passInput2.frame.size.width, height: passInput2.frame.size.height*0.5)
             border.borderWidth = width
            passInput2.layer.addSublayer(border)
            passInput2.layer.masksToBounds = true
            border = CALayer()
            border.frame = CGRect(x: -4, y: 10 ,width:  unameInput.frame.size.width, height: unameInput.frame.size.height*0.5)
             border.borderWidth = width
            unameInput.layer.addSublayer(border)
            unameInput.layer.masksToBounds = true
            border = CALayer()
            border.frame = CGRect(x: -4, y: 10 ,width:  unameInput.frame.size.width, height: emailInput.frame.size.height*0.5)
             border.borderWidth = width
            emailInput.layer.addSublayer(border)
            emailInput.layer.masksToBounds = true

        }

        setNeedsDisplay()
    }
    func Save()
    {
        var ok: Bool = true
        if(unameInput.text == nil || count(unameInput.text)<5)
        {
            ok = false
        }
        if(emailInput.text == nil || count(emailInput.text)<3)
        {
            ok = false
        }
        if(passInput2.text == nil || count(passInput2.text)<5)
        {
            ok = false
        }
        if(passInput.text == nil || count(passInput.text)<5)
        {
            ok = false
        }
        
        if(passInput.text != nil && passInput2.text != nil)
        {
            if(passInput.text != passInput2.text)
            {
                let alert = UIAlertView()
                alert.title = "Alert"
                alert.message = "The two passwords don't match"
                alert.addButtonWithTitle("ok")
                alert.show()
            }
        }
        if(!ok)
        {
        let alert = UIAlertView()
        alert.title = "Alert"
        alert.message = "Password must be at least 6 characters and contain an uppercase and a symbol. Other fields must not be empty";
        alert.addButtonWithTitle("ok")
        alert.show()
        }
        else
        {
            unameInput.enabled = false
            passInput2.enabled = false
            passInput.enabled = false
            emailInput.enabled = false
            _ok.enabled = false
            majorPicker.userInteractionEnabled = false
        
            let alert = UIAlertView()
            alert.title = "Alert"
            var message: String = ""
            alert.addButtonWithTitle("ok")
          
            
            var result = registerDelegate?.Register(unameInput.text, password: passInput.text, email: emailInput.text, major: major)
            //if registration is successful
            if(result == "success")
            {
               delegate?.AppStateChanged("Close")
            }
            else
            {
                message = result!;
                  alert.show()
            }
        }
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        endEditing(true)
        return false
    }
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        return true
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
