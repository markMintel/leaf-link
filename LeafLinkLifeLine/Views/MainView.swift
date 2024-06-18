////
////  Home.swift
////  PlantHealth
////
////  Created by Mark Mintel on 4/13/24.
////
//
//import SwiftUI
//
//struct MainView: View {
//    // TODO:
//    
//    @State var index = 0
//
//    @State private var pvm = CoreViewModel()
//    
//    var body: some View {
//        
//        VStack(spacing: 0) {
//            ZStack {
//                if self.index == 0 {
//                    VStack(spacing: 0) {
//                        MainHomeView().environment(pvm)
//                    }
//                } else if self.index == 1 {
//                    appColor.mainColor.ignoresSafeArea()
//                    AddPlantView().environment(pvm)
//                } else if self.index == 2 {
//                    appColor.mainColor.ignoresSafeArea()
//                    Settings().environment(pvm)
//                    
//                }
//            }
//            CustomTabBar(index: $index)
//        }
//        .navigationBarHidden(true)        
//    }
//    
//}
//
//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
