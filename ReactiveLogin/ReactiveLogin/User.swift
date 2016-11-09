//
//  File.swift
//  ReactiveLogin
//
//  Created by Emilien Stremsdoerfer on 11/9/16.
//  Copyright © 2016 Emilien Stremsdoerfer. All rights reserved.
//

import Foundation
import RxSwift

struct User{
    
    let id:Int
    let name:String
    let token:String
    
    static var currentObs = BehaviorSubject<User?>(value:current)
    
    static var current:User? {
        get {
            //Get from storage,
            //UserDefaults.standard.object(forKey: "user")
            return User(id: 0, name: "Em", token: "abcde")
        }
        set {
            //Set in storage
            //UserDefaults.standard.set(newValue, forKey: "user")
            currentObs.onNext(newValue)
        }
    }
}
