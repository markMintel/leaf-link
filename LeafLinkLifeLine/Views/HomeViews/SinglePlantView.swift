//
//  SinglePlantView.swift
//  PlantHealth
//
//  Created by Mark Mintel on 4/29/24.
//

import SwiftUI

struct SinglePlantView: View {
    @State private var moisture = ""
    @State private var status = false
    @State var plant: Plant
    @Environment(CoreViewModel.self) var user_plants: CoreViewModel
    
    
    
    var body: some View {
        @State var name = UserDefaults.standard.string(forKey: "first_name")
        
        
        ZStack {
            appColor.mainColor.ignoresSafeArea()
            VStack {
                Text(plant.name!)
                    .font(.system(size: 25))
                    .offset(y: -50)
                Image(plant.icon!)
                    .resizable()
                    .frame(width: 300, height: 300)
                    .foregroundColor(.cyan)
                    .offset(x: CGFloat(Offset(icon_name: plant.icon!).offset))
                Text("Today's plant reading:")
                    .foregroundColor(.white)
                    .font(.title)
                    .padding()
                Text(plant.moisture!)
                    .foregroundColor(.white)
                    .font(.title)
                HStack(spacing: 80) {
                    VStack {
                        Button(action: {
                            Task {
                                var command = plant.pipe_id!
                                command = "water" + command
                                await sendCommand(command)
                                
                                if moisture != "invalid" {
                                    plant.moisture = moisture
                                    user_plants.updatePlant(plant: plant)
                                }
                                
                            }
                        }) {
                            Image(systemName: "drop.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.green)
                        }
                        Text("Water Plant")
                            .foregroundColor(.white)
                    }
                    
                    VStack {
                        Button(action: {
                            Task {
                                var command = plant.pipe_id!
                                command = "read" + command
                                await sendCommand(command)
                                
                                if moisture != "invalid" {
                                    plant.moisture = moisture
                                    user_plants.updatePlant(plant: plant)
                                }
                            }
                        }) {
                            Image(systemName: "wifi.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.orange)
                        }
                        Text("Refresh Reading")
                            .foregroundColor(.white)
                    }
                }
                
            }//End VStack
        }//End ZStack
    }
    
    func sendCommand(_ command: String) async {
            let urlString = "http://raspberrypi.local:5000/\(command)"
            guard let url = URL(string: urlString) else {
                //self.moisture = "Invalid URL"
                self.moisture = "invalid"
                return
            }
            
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    print("Network or server error")
                    self.moisture = "invalid"
                    return
                }

                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let status = json["status"] as? String,
                   let moisture = json["moisture"] as? String {
                    DispatchQueue.main.async {
                        if status == "success" {
                            self.status = true
                            self.moisture = moisture
                        } else {
                            self.status = false
                            //self.moisture = "Failed to update"
                            self.moisture = "invalid"
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        //self.moisture = "Error parsing response"
                        self.moisture = "invalid"
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error: \(error)")
                    //self.moisture = "Communication error"
                    self.moisture = "invalid"
                }
            }
        }
}

//struct SinglePlantView_Previews: PreviewProvider {
//    @State var plants = PlantViewModel()
//    static var previews: some View {
//        
//
//        SinglePlantView(plant: plants.plants[0]).environment(PlantViewModel())
//    }
//}
