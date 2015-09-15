//
//  AppDelegate.swift
//  SwiftHoedownDemoiOS
//
//  Created by Niels de Hoog on 15/09/15.
//  Copyright © 2015 Invisible Pixel. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        self.window!.rootViewController = WebViewController()
        self.window!.makeKeyAndVisible()
        return true
    }
}

