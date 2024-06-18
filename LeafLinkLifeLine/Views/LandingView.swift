//
//  HomeView.swift
//  LeafLinkLifeLine
//
//  Created by Mark Mintel on 6/4/24.
//

import SwiftUI

struct LandingView: View {
    @State var index = 0

    @State private var vm = CoreViewModel()
    
    var body: some View {
        
        VStack(spacing: 0) {
            ZStack {
                if self.index == 0 {
                    MainHomeView().environment(vm)
                } else if self.index == 1 {
                    appColor.mainColor.ignoresSafeArea()
                    AddPlantView().environment(vm)
                } else if self.index == 2 {
                    appColor.mainColor.ignoresSafeArea()
                    Settings().environment(vm)
                    
                }
            }
            CustomTabBar(index: $index)
        }
        .navigationBarHidden(true)
    }
}

#Preview {
    LandingView()
}
