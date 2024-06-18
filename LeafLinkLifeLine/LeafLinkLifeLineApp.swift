//
//  LeafLinkLifeLineApp.swift
//  LeafLinkLifeLine
//
//  Created by Mark Mintel on 5/11/24.


import SwiftUI

@main
struct LeafLinkLifeLineApp: App {
    
    @State var isLaunching = true
    
    var body: some Scene {
        WindowGroup {
            if !isLaunching {
                WelcomeView()
            } else {
                LaunchView(isPresented: $isLaunching)
            }
        }
    }
}
