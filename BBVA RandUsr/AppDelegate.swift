//
//  AppDelegate.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 28/06/23.
//

import UIKit
import IQKeyboardManagerSwift
import Kingfisher
import BackgroundTasks
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        ImageCache.default.memoryStorage.config.totalCostLimit = 1024*10
        UIDevice.current.isBatteryMonitoringEnabled = true
        BGTaskScheduler.shared.register(forTaskWithIdentifier: Constant.battBackgroundProcessId, using: nil) { task in
            self.handleBattRefresh(task: task as! BGProcessingTask)
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        scheduleAppRefresh()
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String) async {

    }
    
    func scheduleAppRefresh() {
        let request = BGProcessingTaskRequest(identifier: Constant.battBackgroundProcessId)
        request.earliestBeginDate = Date(timeIntervalSinceNow: 1*60)
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Could not schedule app refresh: \(error)")
        }
    }
    
    func handleBattRefresh(task: BGProcessingTask) {
        scheduleAppRefresh()
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1

        let context = BlockOperation {
            UserDefaults.standard.set(Int(UIDevice.current.batteryLevel * 100), forKey: Constant.batteryKey)
        }
        queue.addOperation(context)
    }
    
}

