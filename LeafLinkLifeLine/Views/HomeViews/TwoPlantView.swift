//
//  HorizontalPlantStackView.swift
//  PlantHealth
//
//  Created by Mark Mintel on 5/3/24.
//

import SwiftUI

struct TwoPlantView: View {
    @State var name = UserDefaults.standard.string(forKey:"first_name") ?? "User"
    @Environment(CoreViewModel.self) var user_plants: CoreViewModel
    
    @State var status = false
    @State var message = ""
    @State var moisture_0 = ""
    @State var moisture_1 = ""
    @State var moisture_2 = ""
    @State var moisture_3 = ""
    
    var body: some View {
        
        
        ZStack {
            appColor.mainColor.ignoresSafeArea()
            VStack {
                Text("Welcome \(name)")
                    .font(.system(size: 25))
                    .offset(y: 5)
                HStack {
                    ForEach(user_plants.plants, id: \.self) { plant in
                        
                        VStack {
                            NavigationLink(destination: SinglePlantView(plant: plant).environment(user_plants)) {
                                Image(plant.icon!)
                                    .resizable()
                                    .frame(height: 150)
                                    .offset(x: CGFloat(Offset(icon_name: plant.icon!).offset))
                            }
                            
                            Text(plant.name!)
                            Text(plant.moisture!)

                        }
                    }
                    Spacer()
                }
                Button(action: {
                    Task {
                        for plant in user_plants.plants {
                            var command = plant.pipe_id!
                            command = "read" + command
                            await sendCommand(command)
                            
                            if command.contains("0") {
                                plant.moisture = moisture_0
                            } else if command.contains("1") {
                                plant.moisture = moisture_0
                            } else if command.contains("2") {
                                plant.moisture = moisture_0
                            } else if command.contains("3") {
                                plant.moisture = moisture_0
                            } else {
                                self.message = "Something went wrong"
                            }
                            user_plants.updatePlant(plant: plant)
                        }
                        
                    }
                }) {
                    Image(systemName: "wifi.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.orange)
                }
                Text("Refresh Readings")
                    .foregroundColor(.white)
            }
        }
        
    }
    func sendCommand(_ command: String) async {
            let urlString = "http://raspberrypi.local:5000/\(command)"
            guard let url = URL(string: urlString) else {
                self.message = "Invalid URL"
                return
            }
            
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    print("Network or server error")
                    return
                }

                if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let status = json["status"] as? String,
                   let moisture = json["moisture"] as? String {
                    DispatchQueue.main.async {
                        if status == "success" {
                            self.status = true
                            
                            if command.contains("0") {
                                self.moisture_0 = moisture
                            } else if command.contains("1") {
                                self.moisture_1 = moisture
                            } else if command.contains("2") {
                                self.moisture_2 = moisture
                            } else if command.contains("3") {
                                self.moisture_3 = moisture
                            } else {
                                self.message = moisture
                            }
                            
                        } else {
                            self.status = false
                            self.message = "Failed to update"
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.message = "Error parsing response"
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    print("Error: \(error)")
                    self.message = "Communication error"
                }
            }
        }
}

//#Preview {
//    @State var name = "User"
//    TwoPlantView(name: name)
//}
struct TwoPlantiew_Previews: PreviewProvider {
    
    static var previews: some View {
        
        TwoPlantView().environment(PlantViewModel())
    }
}