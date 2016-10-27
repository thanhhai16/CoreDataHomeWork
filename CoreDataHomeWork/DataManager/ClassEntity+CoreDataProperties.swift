//
//  ClassEntity+CoreDataProperties.swift
//  CoreDataHomeWork
//
//  Created by Hai on 10/27/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import Foundation
import CoreData
 

extension ClassEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ClassEntity> {
        return NSFetchRequest<ClassEntity>(entityName: "ClassEntity");
    }

    @NSManaged public var name: String?
    @NSManaged public var number: Int32
    @NSManaged public var student: NSSet?

}

// MARK: Generated accessors for student
extension ClassEntity {

    @objc(addStudentObject:)
    @NSManaged public func addToStudent(_ value: StudentEntity)

    @objc(removeStudentObject:)
    @NSManaged public func removeFromStudent(_ value: StudentEntity)

    @objc(addStudent:)
    @NSManaged public func addToStudent(_ values: NSSet)

    @objc(removeStudent:)
    @NSManaged public func removeFromStudent(_ values: NSSet)

}
