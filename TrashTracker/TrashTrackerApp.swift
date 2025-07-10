//
//  TrashTrackerApp.swift
//  TrashTracker
//
//  Created by SathyaNarayanan Ellampriam on 7/10/25.
//

import SwiftUI
import SwiftData
@main
struct TrashTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [TrashReport.self, CommunityEvent.self])
    }
}
