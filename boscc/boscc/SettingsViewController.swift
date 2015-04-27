//
//  SettingsViewController.swift
//  boscc
//
//  Created by Hayden Shelton on 4/26/15.
//  Copyright (c) 2015 u0658884. All rights reserved.
//

import UIKit


class SettingsViewController: UIViewController, AppStateChangedResponder, TryRegister
{
    weak var delegate: AppStateChangedResponder? = nil
    weak var modelDelegate: UserModelExchanger? = nil
    var settingsView: SettingsView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func loadView() {
      
        var model = modelDelegate?.RequestUserModel()
        if(model!.loggedIn)
        {
           settingsView = SettingsView(frame: UIScreen.mainScreen().bounds, loggedIn: true)
        }
        else
        {
            settingsView = SettingsView(frame: UIScreen.mainScreen().bounds, loggedIn: false)
        }
        settingsView!.delegate = self
        settingsView!.registerDelegate = self
        view = settingsView!
    }
    
    //make the api call to attempt to register this user
    func Register(username: String, password: String, email: String, major: String) -> String {
        var con: ApiConnection = ApiConnection()
        var result = con.RegisterStudent(email, password: password, major: major, username: username)
        return result;
    }
    
    
    
    func AppStateChanged(reason: String) {
        switch(reason)
        {
        case "Toggle":
            self.navigationController?.popViewControllerAnimated(true)
            break;
        case "Viz":
            delegate?.AppStateChanged("Viz")
            break;
        case "Close":
            delegate?.AppStateChanged("reload")
            self.navigationController?.popToRootViewControllerAnimated(false)
            break
        default:
            return
        }
        
    }
}



