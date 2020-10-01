//
//  AppDelegate.swift
//  FoodRecipe
//
//  Created by Amir  on 10/1/20.
//  Copyright © 2020 Amir . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    private func setupWindow(initailController initVC: UIViewController) {
        let window  = UIWindow(frame: UIScreen.main.bounds)
        
        window.backgroundColor = .black
        window.rootViewController = UIStoryboard(name:"Main", bundle: nil).instantiateInitialViewController()
        window.makeKeyAndVisible()
        self.window = window
        
    }

}

