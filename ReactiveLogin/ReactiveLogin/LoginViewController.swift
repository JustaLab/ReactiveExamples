//
//  LoginViewController.swift
//  ReactiveLogin
//
//  Created by Emilien Stremsdoerfer on 11/9/16.
//  Copyright © 2016 Emilien Stremsdoerfer. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    let loginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        loginButton.setTitle("Log in", for: .normal)
        loginButton.setTitleColor(.black, for: .normal)
        loginButton.backgroundColor = .white
        loginButton.addTarget(self, action: #selector(LoginViewController.loginTapped), for: .touchUpInside)
        loginButton.frame = CGRect(x: 50, y: 50, width: 200, height: 50)
        self.view.addSubview(loginButton)
    }
    
    func loginTapped(){
        
        self.login(email: "emilien@weareher.com", password: "password", onComplete: { user in
            if let user = user {
                User.current = user
                //UserDefaults.standard.set(token, forKey: "token")
                //(UIApplication.shared.delegate as! AppDelegate).transitionToHome()
            }else{
                //Show error
            }
        })
    }
    
    func login(email:String, password:String, onComplete:((User?)->Void)){
        onComplete(User(id: 0, name: "Em", token: "token_abcde"))
    }


}
