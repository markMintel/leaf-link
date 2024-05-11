//
//  DetailPlantView.swift
//  PlantHealth
//
//  Created by Mark Mintel on 4/28/24.
//

import SwiftUI

struct DetailPlantView: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(CoreViewModel.self) var user_plants: CoreViewModel
    
    @State var plant: Plant
    @State var inputName = false
    @State var inputLocation = false
    @State var newName = ""
    @State var newLocation = ""
    @State private var deleteConfirmation = false
    @State var changeIcon = false
    @State var newIcon = ""
    @State var deleteConfirmed = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                appColor.mainColor.ignoresSafeArea()
                ScrollView {
                    if self.changeIcon == false {
                        Image(plant.icon ?? "plant1")
                            .resizable()
                            .frame(width: 200, height:200)
                            .offset(x: CGFloat(Offset(icon_name: plant.icon ?? "plant1").offset))
                    } else {
                        ImageChoiceView(imageChoice: $newIcon).environment(user_plants)
                            //.frame(width:150, height: 150)
                    }
                    Text(plant.name ?? "")
                        .font(.title)
                    Text(plant.location ?? "")
                    
                    Button {
                        inputName.toggle()
                    } label: {
                        ButtonLabelView(text: "Change Name")
                            .frame(width: 200)
                            .cornerRadius(20)
                    }
                    
                    if self.inputName {
                        TextInputView("Name", text: $newName)
                            .frame(width: 200)
                    }
                    
                    Button {
                        inputLocation.toggle()
                    } label: {
                        ButtonLabelView(text: "Change Location")
                            .frame(width: 200)
                            .cornerRadius(20)
                    }
                    
                    if self.inputLocation {
                        TextInputView("Location", text: $newLocation)
                            .frame(width: 200)
                    }
                    
                    Button {
                        changeIcon.toggle()
                    } label: {
                        ButtonLabelView(text: "Change Picture")
                            .frame(width: 200)
                            .cornerRadius(20)
                    }
//                    NavigationLink(destination: ImageChoiceView(imageChoice: $newIcon).environment(user_plants),
//                                   label: {
//                                        ButtonLabelView(text: "Change Picture")
//                                            .frame(width: 200)
//                                            .cornerRadius(20)
//                    })
                    
                    Button {
                        deleteConfirmation.toggle()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Delete Plant")
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .font(.system(size: 18, weight: .semibold))
                            Spacer()
                        }.background(Color.red)
                            .frame(width: 200)
                            .cornerRadius(20)
                    }
                }
                Spacer()
                VStack {
                    Spacer()
                    Button {
                        if newName != "" {
                            plant.name = newName
                        }
                        
                        if newLocation != "" {
                            plant.location = newLocation
                        }
                        
                        if newIcon != "" {
                            plant.icon = newIcon
                        }
                        
                        user_plants.updatePlant(plant: plant)
                        
                        self.inputLocation = false
                        self.inputName = false
                        self.changeIcon = false
                        print("Updated Plant")
                    } label: {
                        if self.inputLocation || self.inputName || self.changeIcon {
                            HStack {
                                Spacer()
                                Text("Save Changes")
                                    .frame(width: 300)
                                    .cornerRadius(60)
                                    .foregroundColor(.white)
                                    .padding(.vertical, 10)
                                    .font(.system(size: 18, weight: .semibold))
                                Spacer()
                            }.background(Color.orange)
                        }
                    }
                }
            }//end Zstack
            .confirmationDialog("Delete Plant?", isPresented: $deleteConfirmation) {
                Button {
                    //user_plants.deletePlant(plant: plant)
                    deleteConfirmed = true
                    dismiss()
                } label: {Text("Confirm")}
            }
        }.onDisappear {
            if deleteConfirmed {
                user_plants.deletePlant(plant: plant)
            }
        }
    }
}

struct DetailPlantView_Previews: PreviewProvider {
    
    static var previews: some View {
        DetailPlantView(plant: CoreViewModel().plants[0]).environment(CoreViewModel())
    }
}
