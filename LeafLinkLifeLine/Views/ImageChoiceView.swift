//
//  ImageChoiceView.swift
//  PlantHealth
//
//  Created by Mark Mintel on 4/29/24.
//
// TODO: make changes to imageChoice

import SwiftUI

struct ImageChoiceView: View {
    @Environment(CoreViewModel.self) var user_plants
    //@EnvironmentObject var user_plants: PlantEnvObj
    
    @State var plant1 = false
    @State var plant2 = false
    @State var monstera = false
    @State var plant3 = false
    //@State var name: String
    @Binding var imageChoice: String
    
    
    var body: some View {
        ZStack {
            appColor.mainColor.ignoresSafeArea()
            VStack {
                HStack {
                    Button {
                        //user_plants.placeholder = "plant1"
                        imageChoice = "plant1"
                        plant1 = true
                        plant2 = false
                        monstera = false
                        plant3 = false
                    } label: {
                        if plant1{
                            Image("plant1")
                                .resizable()
                                .frame(width: 200, height: 200)
                                .background(Color.gray)
                                .cornerRadius(50)
                        } else {
                            Image("plant1")
                                .resizable()
                                .frame(width: 200, height: 200)
                                
                        }
                    }
    
                    Button {
                        //user_plants.placeholder = "plant2"
                        imageChoice = "plant2"
                        plant1 = false
                        plant2 = true
                        monstera = false
                        plant3 = false
                    } label: {
                        if plant2{
                            Image("plant2")
                                .resizable()
                                .frame(width: 200, height: 200)
                                .background(Color.gray)
                                .cornerRadius(50)
                        } else {
                            Image("plant2")
                                .resizable()
                                .frame(width: 200, height: 200)
                                
                        }
                    }
                }
                HStack {
                    Button {
                        //user_plants.placeholder = "monstera"
                        imageChoice = "monstera"
                        print("monstera")
                        plant1 = false
                        plant2 = false
                        monstera = true
                        plant3 = false
                    } label: {
                        if monstera{
                            Image("monstera")
                                .resizable()
                                .frame(width: 200, height: 200)
                                .background(Color.gray)
                                .cornerRadius(50)
                        } else {
                            Image("monstera")
                                .resizable()
                                .frame(width: 200, height: 200)
                                
                        }
                    }
                    Spacer()
                    Button {
                        //user_plants.placeholder = "plant3"
                        imageChoice = "plant3"
                        plant1 = false
                        plant2 = false
                        monstera = false
                        plant3 = true
                    } label: {
                        if plant3 {
                            Image("plant3")
                                .resizable()
                                .frame(width: 200, height: 200)
                                .foregroundColor(.green)
                                .background(Color.gray)
                                .cornerRadius(50)
                        } else {
                            Image("plant3")
                                .resizable()
                                .frame(width: 200, height: 200)
                                .foregroundColor(.green)
                                
                        }
                    }
                    Spacer()
                }
//                if name != "defaultAdmin" && (plant1 || plant2 || monstera || plant3) {
//                    Button {
//                        //self.user.editPlant(name: name, newName: "", newLocation: "", newIcon: user.placeholderValue)
//                    } label: {
//                        ButtonLabelView(text: "Save Changes")
//                            .frame(width: 200)
//                            .cornerRadius(50)
//                    }
//                }
            }
        }
    }
}

struct ImageChoiceView_Previews: PreviewProvider {
    static var previews: some View {
        
        @State var name = "plant1"
        ImageChoiceView(imageChoice: $name).environment(CoreViewModel())
    }
}
