//
//  GamesListViewController.swift
//  BattleShip
//
//  Created by Hayden Shelton on 3/5/15.
//  Copyright (c) 2015 Hayden Shelton. All rights reserved.
//

import UIKit


class MenueViewController: UIViewController, AppStateChangedResponder
{
weak var delegate: AppStateChangedResponder? = nil
    var mv: MenueView = MenueView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func loadView() {
       mv.delegate = self
         view = mv
    }
    

    
  func AppStateChanged(reason: String) {
    switch(reason)
    {
    case "Toggle":
        delegate?.AppStateChanged("Close")
        break;
    case "Viz":
        delegate?.AppStateChanged("Viz")
        break;
        
    case "Settings":
        delegate?.AppStateChanged("Settings")
        break;
    default:
        return
    }
    
    }
}


