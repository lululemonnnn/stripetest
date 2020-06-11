//
//  AppDelegate.swift
//  udemyStripe
//
//  Created by Shannon Le on 6/3/20.
//  Copyright © 2020 Shannon Le. All rights reserved.
//

import UIKit
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initializeStripe()
        return true
        
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }

    func initializeStripe() {
         Stripe.setDefaultPublishableKey(Constants.publishableKey)
        StripeClient.sharedClient.baseURLString = Constants.baseURLString
    }

}

