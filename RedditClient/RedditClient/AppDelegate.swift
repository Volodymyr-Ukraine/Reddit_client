//
//  AppDelegate.swift
//  RedditClient
//
//  Created by Vladimir on 03.02.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: -
    // MARK: Properties

    var window: UIWindow?
    var navContr: UINavigationController?
    var appConfigurator: AppConfigurator?

    // MARK: -
    // MARK: Lifecycle Methods

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if #available(iOS 13.0, *) {}
            else {
                let _window = UIWindow(frame: UIScreen.main.bounds)
                self.window = _window
                _window.makeKey()
                let navigationController = UINavigationController()
                _window.rootViewController = navigationController
                navigationController.navigationBar.isHidden = true
                self.navContr = navigationController
                self.window?.rootViewController = navigationController
                self.appConfigurator = AppConfigurator(window: _window, controller: navigationController) // todo: move doublicates
                self.window?.makeKeyAndVisible()
        }
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

