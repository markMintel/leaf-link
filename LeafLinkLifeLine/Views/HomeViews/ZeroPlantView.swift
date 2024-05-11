//
//  ZeroPlantView.swift
//  PlantHealth
//
//  Created by Mark Mintel on 5/1/24.
//

import SwiftUI

struct ZeroPlantView: View {
    var body: some View {
        
        ZStack {
            appColor.mainColor.ignoresSafeArea()
            VStack {
                Image(systemName: "questionmark.circle.fill")
                    .resizable()
                    .frame(width: 250, height:250)
                    .foregroundColor(.green)
                Text("Oops...It looks like you don't have any plants yet ...")
                    .font(.title)
                    .multilineTextAlignment(.center)
            }
        }
    }
}

struct ZeroPlantView_Previews: PreviewProvider {
    static var previews: some View {
        ZeroPlantView()
    }
}
