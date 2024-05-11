//
//  LaunchView.swift
//  LeafLinkLifeLine
//
//  Created by Mark Mintel on 6/10/24.
//

import SwiftUI

struct LaunchView: View {
    @Binding var isPresented: Bool
    @State var rotateLogo = false
    @State var scale = CGSize(width: 0.8, height: 0.8)
    
    var body: some View {
        ZStack {
            appColor.mainColor.ignoresSafeArea()
            ZStack {
                VStack {
                    Image("launchImage")
                        .resizable()
                        .frame(width: 400, height: 375)
                        .offset(x:10)
                        .clipShape(Circle())
                        .overlay {
                            Circle().stroke(.white, lineWidth: 4)
                        }
                        .shadow(radius: 7)
                    Text("Leaf Link")
                        .font(Font.custom("Baskerville-Bold", size: 30))
                        .foregroundColor(.white)
                }
            }
            .scaleEffect(scale)
            
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5)) {
                scale = CGSize(width: 1.0, height: 1.0)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5, execute: {
                withAnimation(.easeIn(duration: 0.5)) {
                    scale = CGSize(width: 50, height: 50)
                }
            })
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.9, execute: {
                withAnimation(.easeIn(duration: 0.2)) {
                    isPresented.toggle()
                }
            })
        }
        
    }
}

#Preview {
    LaunchView(isPresented: .constant(true))
}
