//
//  SaveInCoreData.swift
//  Cricketers
//
//  Created by Adaikalraj on 12/03/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit
import CoreData

class SaveInCoreData: NSObject {
    
    override init() {
        
    }

    // MARK:- Saving data from API in coreData.
    
    public func saveData(item: CricketersModel){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cricketers")
        fetchRequest.predicate = NSPredicate(format: "id = %d", item.id)
        fetchRequest.returnsObjectsAsFaults = false
        
        var results: [NSManagedObject] = []
        
        do {
            results = try managedContext.fetch(fetchRequest)
            if results == []{
                let entity = NSEntityDescription.entity(forEntityName: "Cricketers",in: managedContext)!
                let cricket = NSManagedObject(entity: entity,insertInto: managedContext)
                cricket.setValue(item.id, forKeyPath: "id")
                cricket.setValue(item.name, forKeyPath: "name")
                cricket.setValue(item.description, forKeyPath: "detail")
                cricket.setValue(item.image, forKeyPath: "image")
                do {
                    try managedContext.save()
                }
                catch {
                    print("Error in storing data: \(error)")
                }
            }
        }
        catch {
            print("error executing fetch request: \(error)")
        }
    }
    
}
