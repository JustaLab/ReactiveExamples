//
//  ViewController.swift
//  ReactiveLogin
//
//  Created by Emilien Stremsdoerfer on 11/9/16.
//  Copyright © 2016 Emilien Stremsdoerfer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let logoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        
        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.backgroundColor = .white
        logoutButton.addTarget(self, action: #selector(ViewController.logoutTapped), for: .touchUpInside)
        logoutButton.frame = CGRect(x: 50, y: 50, width: 200, height: 50)
        self.view.addSubview(logoutButton)
    }
    
    func logoutTapped(){
        User.current = nil
    }
}

