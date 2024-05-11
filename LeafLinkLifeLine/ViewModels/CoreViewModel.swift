//
//  CoreViewModel.swift
//  LeafLinkLifeLine
//
//  Created by Mark Mintel on 6/2/24.
//

import Foundation
import CoreData

@Observable
class CoreViewModel {

    let persistentContainer: NSPersistentContainer
    var plant_names = [String]()
    var plants: [Plant]
    
    init() {
        let container = NSPersistentContainer(name: "userDM")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Loading the store failed: \(error.localizedDescription)")
            }
        }
        self.persistentContainer = container
        self.plants = []
        self.plant_names = []
        
        let plants = fetchPlants() ?? nil
        var plant_names = [String]()
        
        if let temp_plants = plants {
            for plant in temp_plants {
                plant_names.append(plant.name!)
            }
            self.plants = temp_plants
            self.plant_names = plant_names
        } else {
            self.plants = []
            self.plant_names = []
        }
    }
    
    
    func save_data() {
        let context = persistentContainer.viewContext
        do {
            try context.save()
        } catch let deleteError {
            print("Failed to delete: \(deleteError)")
        }
    }
    
    func fetchPlantNames() {
        plant_names.removeAll()
        
        let plants = fetchPlants() ?? nil
        
        
        if let temp_plants = plants {
            for plant in temp_plants {
                plant_names.append(plant.name!)
            }
        } else {
            self.plants = []
            self.plant_names = []
        }
        
        save_data()
    }
    
    func addPlant(name: String, location: String, icon: String) {
        if plants.count == 0 {
            let pid = "0"
            
            guard createPlant(id: UUID(), name: name, location: location, moisture: "???", pipe_id: pid, icon: icon) != nil else {return}
            
            //fetchPlantNames()
        } else {
            let num_plants = self.plant_names.count + 1
            
            if num_plants <= 4 {
                let plants = self.plants
                var valid: Set = ["0", "1", "2", "3"]
                
                for plant in plants {
                    valid.remove(plant.pipe_id ?? "")
                }
                
                let pid = valid.first ?? ""
                
                guard createPlant(id: UUID(), name: name, location: location, moisture: "???", pipe_id: pid, icon: icon) != nil else {return}
                
                //fetchPlantNames()

            } else {
                print("Sorry! Only 4 plants can be added :(")
            }
        }
        let context = persistentContainer.viewContext
        do {
            try context.save()
            fetchPlantNames()
        } catch let deleteError {
            print("Failed to delete: \(deleteError)")
        }
    }
    
    func deletePlant(plant: Plant) {
        let context = persistentContainer.viewContext
        context.delete(plant)
        
        do {
            try context.save()
            fetchPlantNames()
        } catch let deleteError {
            print("Failed to delete: \(deleteError)")
        }
        
    }
    
    func newDeletePlant(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = plants[index]
        persistentContainer.viewContext.delete(entity)
        
        do {
            try persistentContainer.viewContext.save()
            fetchPlantNames()
        } catch let deleteError {
            print("Failed to delete: \(deleteError)")
        }
        
    }
    
    func updatePlant(plant: Plant) {
        let context = persistentContainer.viewContext
        
        do {
            try context.save()
            fetchPlantNames()
        } catch let updateError {
            print("Failed to update: \(updateError)")
        }
        
        
    }
    //@discardableResult
    func createPlant(id: UUID, name: String, location: String, moisture: String, pipe_id: String, icon: String) -> Plant? {
        
        let context = persistentContainer.viewContext
        
        let plant = NSEntityDescription.insertNewObject(forEntityName: "Plant", into: context) as! Plant
        
        plant.id = UUID()
        plant.name = name
        plant.location = location
        plant.moisture = moisture
        plant.pipe_id = pipe_id
        plant.icon = icon
        
        do {
            try context.save()
            fetchPlantNames()
            return plant
            
        } catch let createError {
            print("Failed to create: \(createError)")
        }
        
        return nil
    }
    
    func fetchPlants() -> [Plant]? {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Plant>(entityName: "Plant")
        
        do {
            plants = try context.fetch(fetchRequest)
            return plants
        } catch let fetchError {
            print("Failed to fetch plants: \(fetchError)")
        }
        
        return nil
    }
    
    func fetchPlant(withName name: String) -> Plant? {
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Plant>(entityName: "Plant")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        do {
            let plants = try context.fetch(fetchRequest)
            return plants.first
        } catch let fetchError {
            print("Failed to fetch plants: \(fetchError)")
        }
        
        return nil
    }
}
