//
//  DiscounterApp.swift
//  Discounter
//
//  Created by Wissa Michael on 20.11.20.
//

import SwiftUI

@main
struct DiscounterApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(expenses: Expenses())
        }
    }
}
