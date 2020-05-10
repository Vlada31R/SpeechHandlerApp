//
//  AppDelegate.swift
//  SpeechHandlerApp
//
//  Created by Vlada Radchenko on 5/10/20.
//  Copyright © 2020 Vlada Radchenko. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appAssembly: AppAssembly?
    var appCoordinator: Coordinator?

    open func application(_ application: UIApplication,
                          didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        appAssembly = AppAssembly()
        FirebaseApp.configure()

        let window = UIWindow(frame: UIScreen.main.bounds)

        appCoordinator = appAssembly?.coordinatorsAssembly.makeAppCoordinator(window: window)
        appCoordinator?.start()

        return true
    }
}

