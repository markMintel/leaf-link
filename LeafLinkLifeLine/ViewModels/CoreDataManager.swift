//
//  CoreDataManager.swift
//  LeafLinkLifeLine
//
//  Created by Mark Mintel on 5/27/24.
//

import Foundation
import CoreData

@Observable
class CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "userDM")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Loading the store failed: \(error.localizedDescription)")
            }
        }
        
        return container
    }()
    
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
            let plants = try context.fetch(fetchRequest)
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
    
    func updatePlant(plant: Plant) {
        let context = persistentContainer.viewContext
        
        do {
            try context.save()
        } catch let updateError {
            print("Failed to update: \(updateError)")
        }
    }
    
    func deletePlant(plant: Plant) {
        let context = persistentContainer.viewContext
        context.delete(plant)
        
        do {
            try context.save()
        } catch let deleteError {
            print("Failed to delete: \(deleteError)")
        }
    }
}
