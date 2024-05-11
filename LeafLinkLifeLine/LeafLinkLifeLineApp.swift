//
//  LeafLinkLifeLineApp.swift
//  LeafLinkLifeLine
//
//  Created by Mark Mintel on 5/11/24.
// TODO: Create a multi-plant view which is a scroll view

import SwiftUI

@main
struct LeafLinkLifeLineApp: App {
    //@StateObject private var dataController = DataController()
    @State var isLaunching = true
    
    var body: some Scene {
        WindowGroup {
            //WelcomeView()
            if !isLaunching {
                WelcomeView()
            } else {
                LaunchView(isPresented: $isLaunching)
            }
        }
    }
}
