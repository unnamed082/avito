//
//  AppDelegate.swift
//  avito
//
//  Created by Талгат Лукманов on 24.08.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: AnnouncementViewController())
        window?.makeKeyAndVisible()

        return true
    }
}
