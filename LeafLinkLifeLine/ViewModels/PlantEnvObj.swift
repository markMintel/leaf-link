////
////  PlantEnvObj.swift
////  LeafLinkLifeLine
////
////  Created by Mark Mintel on 5/31/24.
////
//
//import Foundation
//
//class PlantEnvObj: ObservableObject {
//
//@Published var plant_names = [String]()
//@Published var plants: [Plant]
//
//
//init() {
//    let plants = CoreDataManager.shared.fetchPlants() ?? nil
//    var plant_names = [String]()
//    
//    if let temp_plants = plants {
//        for plant in temp_plants {
//            plant_names.append(plant.name!)
//        }
//        self.plants = temp_plants
//        self.plant_names = plant_names
//    } else {
//        self.plants = []
//        self.plant_names = []
//    }
//    
//}
//
//func fetchPlantNames() {
//    plant_names.removeAll()
//    
//    let plants = CoreDataManager.shared.fetchPlants() ?? nil
//    
//    
//    if let temp_plants = plants {
//        for plant in temp_plants {
//            plant_names.append(plant.name!)
//        }
//    } else {
//        self.plants = []
//        self.plant_names = []
//    }
//}
//
//func addPlant(name: String, location: String, icon: String) {
//    if plants.count == 0 {
//        let pid = "0"
//        
//        guard CoreDataManager.shared.createPlant(id: UUID(), name: name, location: location, moisture: "???", pipe_id: pid, icon: icon) != nil else {return}
//        
//        fetchPlantNames()
//    } else {
//        let num_plants = self.plant_names.count + 1
//        
//        if num_plants <= 4 {
//            let plants = self.plants
//            var valid: Set = ["0", "1", "2", "3"]
//            
//            for plant in plants {
//                valid.remove(plant.pipe_id ?? "")
//            }
//            
//            let pid = valid.first ?? ""
//            
//            guard CoreDataManager.shared.createPlant(id: UUID(), name: name, location: location, moisture: "???", pipe_id: pid, icon: icon) != nil else {return}
//            
//            fetchPlantNames()
//
//        } else {
//            print("Sorry! Only 4 plants can be added :(")
//        }
//    }
//}
//
//func deletePlant(plant: Plant) {
//    CoreDataManager.shared.deletePlant(plant: plant)
//    
//    fetchPlantNames()
//}
//
//func updatePlant(plant: Plant) {
//    CoreDataManager.shared.updatePlant(plant: plant)
//    fetchPlantNames()
//}
//
//
//}
