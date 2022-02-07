//
//  AppDelegate.swift
//  CatchPokemonApp
//
//  Created by Bening Ranum on 05/02/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupNavBarAppearance()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootVC = PokemonListRouter.createModule()
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()
        return true
    }

    // MARK: - UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication,
                     didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
}

// MARK: - Private extension
private extension AppDelegate {
    func setupNavBarAppearance() {
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = AppColor.PRIMARY
            appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            UINavigationBar.appearance().backgroundColor = AppColor.PRIMARY
        }
        
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = .white
    }
}
