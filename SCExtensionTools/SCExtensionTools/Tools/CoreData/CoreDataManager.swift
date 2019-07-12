//
//  CoreDataManager.swift
//  CoreDataLearning
//
//  Created by Stephen Cao on 12/7/19.
//  Copyright © 2019 Stephencao Cao. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    static let shared = CoreDataManager()
    
    lazy var context: NSManagedObjectContext = {
        let context = ((UIApplication.shared.delegate) as! AppDelegate).context
        return context
    }()
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func savePersonWith(name: String, age: Int16) {
        let person = NSEntityDescription.insertNewObject(forEntityName: "Person", into: context) as! Person
        person.name = name
        person.age = age
        saveContext()
    }
    
    func getAllPerson() -> [Person] {
        let fetchRequest: NSFetchRequest = Person.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            fatalError();
        }
    }
    
    func getPersonWith(name: String) -> [Person] {
        let fetchRequest: NSFetchRequest = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let result: [Person] = try context.fetch(fetchRequest)
            return result
        } catch {
            fatalError();
        }
    }
    
    func changePersonWith(name: String, newName: String, newAge: Int16) {
        let fetchRequest: NSFetchRequest = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let result = try context.fetch(fetchRequest)
            for person in result {
                person.name = newName
                person.age = newAge
            }
        } catch {
            fatalError();
        }
        saveContext()
    }
    
    func deleteWith(name: String) {
        let fetchRequest: NSFetchRequest = Person.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        do {
            let result = try context.fetch(fetchRequest)
            for person in result {
                context.delete(person)
            }
        } catch {
            fatalError();
        }
        saveContext()
    }
    
    func deleteAllPerson() {
        let result = getAllPerson()
        for person in result {
            context.delete(person)
        }
        saveContext()
    }
}
