//
//  MainHomeView.swift
//  PlantHealth
//
//  Created by Mark Mintel on 5/3/24.
//

import Foundation
import SwiftUI

struct MainHomeView: View {
    @AppStorage("first_name") var first_name: String = (UserDefaults.standard.string(forKey: "first_name") ?? "User")
    @Environment(CoreViewModel.self) var user_plants: CoreViewModel
        
    var body: some View {
        
        
        NavigationView {
            if user_plants.plants.count == 0 {
                
                ZeroPlantView()
                
            } else if user_plants.plants.count == 1 {
                
                SinglePlantView(plant: user_plants.plants[0]).environment(user_plants)
                
            } else if user_plants.plants.count == 2 {
                
                TwoPlantView().environment(user_plants)
                
            } else if user_plants.plants.count == 3 {
                
                ThreePlantView().environment(user_plants)
                
            } else if user_plants.plants.count == 4 {
                
                FourPlantView().environment(user_plants)
                
            }
        }.tint(.white)
    }
}

struct MainHomeView_Previews: PreviewProvider {

    static var previews: some View {
        
        MainHomeView().environment(CoreViewModel())
    }
}
