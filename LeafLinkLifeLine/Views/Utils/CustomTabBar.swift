//
//  CustomTabBar.swift
//  PlantHealth
//
//  Created by Mark Mintel on 4/13/24.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var index: Int
    
    var body: some View {
        HStack(spacing: 40) {
            HStack {
                Image(systemName: "house.fill")
                    .resizable()
                    .frame(width: 35, height: 30)
                
                Text(self.index == 0 ? "Home" : "")
                    .fontWeight(.light)
                    .font(.system(size:14))
            }
            .padding(15)
            .background(self.index == 0 ? Color.green.opacity(0.5) : Color.clear)
            .clipShape(Capsule())
            .onTapGesture {
                self.index = 0
            }
            
            HStack {
                Image(systemName: "leaf.fill")
                    .resizable()
                    .frame(width: 35, height: 30)
                Text("+")
                    .font(.system(size: 24))
                
                Text(self.index == 1 ? "Plants" : "")
                    .fontWeight(.light)
                    .font(.system(size:14))
            }
            .padding(15)
            .background(self.index == 1 ? Color.green.opacity(0.5) : Color.clear)
            .clipShape(Capsule())
            .onTapGesture {
                self.index = 1
            }
            
            HStack {
                Image(systemName: "slider.horizontal.3")
                    .resizable()
                    .frame(width: 35, height: 30)
                
                Text(self.index == 2 ? "Settings" : "")
                    .fontWeight(.light)
                    .font(.system(size:14))
            }
            .padding(15)
            .background(self.index == 2 ? Color.green.opacity(0.5) : Color.clear)
            .clipShape(Capsule())
            .onTapGesture {
                self.index = 2
            }
        }
        .padding(.top, 8)
        .frame(width: UIScreen.main.bounds.width)
        .background(appColor.mainColor)
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    @State static var index = 0
    static var previews: some View {
        CustomTabBar(index: $index)
    }
}
