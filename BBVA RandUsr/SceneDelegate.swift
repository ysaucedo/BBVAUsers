//
//  SceneDelegate.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 28/06/23.
//

import UIKit
import FirebaseFirestore
import FirebaseDatabase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let viewController = LoginViewController()
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.navigationBar.barStyle = .black
        
        if #unavailable(iOS 15.0) {
            navigation.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
            navigation.navigationBar.backgroundColor = UIColor.init(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)
        }
        
        window.rootViewController = navigation
        self.window = window
        window.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        reportBatteryLevel()
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        UIApplication.shared.delegate?.applicationDidEnterBackground?(.shared)
    }
    
    func reportBatteryLevel() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        //let battLevel:Int = UserDefaults.standard.integer(forKey: Constant.batteryKey)
        let battLevel = Int(UIDevice.current.batteryLevel * 100)
        var ref: DatabaseReference!
        ref = Database.database().reference()
        ref.child("Battery").child(dateFormatter.string(from: Date())).setValue(["batterylevel": battLevel])

    }


}

