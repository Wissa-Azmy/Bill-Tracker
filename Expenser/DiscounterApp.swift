//
//  DiscounterApp.swift
//  Discounter
//
//  Created by Wissa Michael on 20.11.20.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
	func application(
		_ application: UIApplication,
		didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
	) -> Bool {
		FirebaseApp.configure()
		return true
	}
}

@main
struct DiscounterApp: App {
	@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
	
    var body: some Scene {
		WindowGroup<HomeView> {
            HomeView(expenses: Expenses.shared)
        }
    }
}
