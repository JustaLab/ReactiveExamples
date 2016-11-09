//
//  AppDelegate.swift
//  ReactiveLogin
//
//  Created by Emilien Stremsdoerfer on 11/9/16.
//  Copyright © 2016 Emilien Stremsdoerfer. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    let bag = DisposeBag()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window?.makeKeyAndVisible()

        self.window?.rootViewController = (User.current != nil) ? ViewController() : LoginViewController()
        
        
        User.currentObs.asObservable().subscribe { (event:Event<User?>) in
            let vc:UIViewController = (event.element?.flatMap({$0}) != nil) ? ViewController() : LoginViewController()
            let animation:UIViewAnimationOptions = (event.element?.flatMap({$0}) != nil) ? .transitionFlipFromLeft : .transitionFlipFromRight
            self.swapRootViewController(with: vc, animation: animation)
        }.addDisposableTo(bag)
        return true
    }
    
    func swapRootViewController(with viewController: UIViewController, animation:UIViewAnimationOptions, duration:TimeInterval = 0.5){
        UIView.setAnimationsEnabled(false)
        UIView.transition(with:self.window!, duration:duration, options: animation, animations: {
            self.window!.rootViewController = viewController
        }, completion: { _ in
            UIView.setAnimationsEnabled(true)
        })
    }
}

