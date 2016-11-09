//
//  AppDelegate.swift
//  ReactiveRequest
//
//  Created by Emilien Stremsdoerfer on 11/9/16.
//  Copyright © 2016 Emilien Stremsdoerfer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window?.makeKeyAndVisible()
        
        let realmManager = RealmManager()
        let service = DeezerService()
        let viewModel = ViewModel(realmManager: realmManager, service: service)
        self.window?.rootViewController = ViewController(viewModel:viewModel)
        return true
    }


}

