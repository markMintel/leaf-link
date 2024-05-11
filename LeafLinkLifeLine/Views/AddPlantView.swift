//
//  AddPlantView.swift
//  PlantHealth
//
//  Created by Mark Mintel on 4/12/24.
//

import SwiftUI

struct AddPlantView: View {
    //@State var message = ""
    @State var addPlant = false
    @State var updateView = false
    
    @State var newPlantName = ""
    @State var newPlantLocation = ""
    @State var newPlantIcon = ""
    

    @Environment(CoreViewModel.self) var user_plants: CoreViewModel 
    @AppStorage("first_name") var first_name: String = (UserDefaults.standard.string(forKey: "first_name") ?? "User")
    
    
    var body: some View {
        @State var plant_names = user_plants.plant_names
        @State var up = user_plants.plants
        
        NavigationView {
            
            ZStack {
                appColor.mainColor.ignoresSafeArea()
                VStack {
                    if plant_names.contains("update") {
                        Text("An Error Occurred")
                    }
                    
                    if newPlantIcon == "" {
                        Image("monstera")
                            .resizable()
                            .frame(width: 300, height: 300)
                            .offset(x: CGFloat(Offset(icon_name: "monstera").offset))
                    } else {
                        Image(newPlantIcon)
                            .resizable()
                            .frame(width: 300, height: 300)
                            .offset(x: CGFloat(Offset(icon_name: newPlantIcon).offset))
                    }

                    
                    Button {
                        addPlant.toggle()
                    } label: {
                        if addPlant {
                            ButtonLabelView(text: "Cancel")
                                .frame(width:200)
                                .cornerRadius(60)
                        } else {
                            ButtonLabelView(text: "Add New Plant")
                                .frame(width:200)
                                .cornerRadius(60)
                        }
                        
                    }
                    
                    if addPlant {
                        
                        HStack {
                            if newPlantIcon == "" {
                                NavigationLink(destination: ImageChoiceView(imageChoice: $newPlantIcon).environment(user_plants), label: {Text("Choose Image")})
                                    .frame(width:200)
                                    .foregroundColor(.white)
                            } else {
                                NavigationLink(destination: ImageChoiceView(imageChoice: $newPlantIcon).environment(user_plants), label: {Text("Choose Image")})
                                    .frame(width:200)
                                    .foregroundColor(.white)
                                Image(systemName: "checkmark.circle.fill")
                            }
                        }
                        TextInputView("Plant Name", text: $newPlantName)
                            .frame(width: 200)
                        TextInputView("Location", text: $newPlantLocation)
                            .frame(width: 200)
                        
                        
                        if newPlantName != "" && newPlantLocation != "" {
                            Button {
                                if newPlantIcon == "" {
                                    newPlantIcon = "plant1"
                                }

                                user_plants.addPlant(name: newPlantName, location: newPlantLocation, icon: newPlantIcon)
                                
                                addPlant.toggle()
                                
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Create")
                                        .cornerRadius(60)
                                        .foregroundColor(.black)
                                        .padding(.vertical, 10)
                                        .font(.system(size: 18, weight: .semibold))
                                    Spacer()
                                }
                                .background(Color.yellow)
                                .frame(width:200)
                                .cornerRadius(60)
                                
                            }
                        }
                        
                    }
                    
                    if up.count != 0 {
//                        List(user_plants.plants, id:\.self) { plant in
//                            NavigationLink(destination: DetailPlantView(plant: plant).environment(user_plants), label: {
//                            Text(plant.name ?? "")
//                                
//                            })
//                        }
//                        .scrollContentBackground(.hidden)
//                        .background(appColor.mainColor)
//                        .navigationTitle("\(first_name)'s Plants")
                        List {
                            ForEach(user_plants.plants) { plant in
                                NavigationLink(destination: DetailPlantView(plant: plant).environment(user_plants), label: {
                                    Text(plant.name ?? "")
                                })
                            }
                            .onDelete(perform: user_plants.newDeletePlant)
                            
                        }
                        .scrollContentBackground(.hidden)
                        .background(appColor.mainColor)
                        .navigationTitle("\(first_name)'s Plants")
                        
                    }
                }// end VStack
                .onAppear {
                    user_plants.fetchPlantNames()
                    //temp_plants = user_plants.plants
                }
            }
        }.tint(.white)
            .navigationViewStyle(.stack)
    }

    
}

struct AddPlantView_Previews: PreviewProvider {
    
    static var previews: some View {
        AddPlantView().environment(CoreViewModel())
    }
}
