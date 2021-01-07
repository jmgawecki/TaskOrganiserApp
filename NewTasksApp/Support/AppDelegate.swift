//
//  AppDelegate.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /// That whole configuration will launch only at the first-time set up of the app.
        /// A note is going to be placed for each Priorities and Secondaries as a welcome Note.
        /// Function will never run again unless app will be reinstalled
        var hasAlreadyLaunched :Bool!
        hasAlreadyLaunched = UserDefaults.standard.bool(forKey: "hasAlreadyLaunched")
        if hasAlreadyLaunched {
        } else {
            UserDefaults.standard.set(true, forKey: "hasAlreadyLaunched")
            let note: Note = Note(title: WelcomeMessages.PrioritiesTitle, note: WelcomeMessages.PrioritiesBody, noteId: UUID().uuidString)
            let note2: Note = Note(title: WelcomeMessages.SecondariesTitle, note: WelcomeMessages.SecondariesBody, noteId: UUID().uuidString)
            PersistenceManager.updateWith(note: note, actionType: .add, keyObject: .priorities) { (error) in }
            PersistenceManager.updateWith(note: note2, actionType: .add, keyObject: .secondaries) { (error) in }
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


}

