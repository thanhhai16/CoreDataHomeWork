//
//  DataManager.swift
//  CoreDataHomeWork
//
//  Created by Hai on 10/27/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    static let share:DataManager = DataManager()
    
    // MARK: - Class Manager
    
    func creatNewClass(name: String)  {
        
        let context = self.persistentContainer.viewContext
        
        let classCourse = ClassEntity(context: context)
        
        classCourse.name = name
        classCourse.number = Int32((classCourse.student?.count)!)
        
        do {
            try self.saveContext()
        } catch  {
            print(error)
        }
        
    }
    
    func deleteClass(classCourse : ClassEntity) {
        let context = self.persistentContainer.viewContext
        
        context.delete(classCourse)
        
        do {
            try self.saveContext()
        } catch  {
            print(error)
        }
    }
    func listClassCourse() -> [ClassEntity]? {
        
        let context = self.persistentContainer.viewContext
        
        do {
            let fetchResult = try context.fetch(ClassEntity.fetchRequest())
            return fetchResult as! [ClassEntity]
        } catch  {
            print(error)
            return nil
        }
    }
    
    // MARK: - Student Manager
    
    func createStundent(name: String, address: String, date: NSDate, classCourse : ClassEntity, pictrure : NSData) {
        let context = self.persistentContainer.viewContext
        
        let student = StudentEntity(context: context)
        
        student.name = name
        student.address = address
        student.picture = pictrure
        student.date = date
        student.addToClassCourse(classCourse)
        classCourse.number += 1
        do {
            try self.saveContext()
        } catch  {
            print(error)
        }
    }
    func listStudent(classCourse : ClassEntity) -> [StudentEntity]? {
        
        let context = self.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "StudentEntity")
        fetchRequest.predicate = NSPredicate(format: "ANY classCourse.name = %@", classCourse.name!)
        
        do {
            let fetchResults = try context.fetch(fetchRequest)
            return fetchResults as! [StudentEntity]
        } catch  {
            print("erorr",error)
            return nil
        }
    }
    func deleteStudent(student : StudentEntity, classCourse: ClassEntity) {
        let context = self.persistentContainer.viewContext
        
        context.delete(student)
        classCourse.number += -1
        
        do {
            try self.saveContext()
        } catch  {
            print(error)
        }
    }
    
    var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "CoreDataHomeWork")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
}
}





