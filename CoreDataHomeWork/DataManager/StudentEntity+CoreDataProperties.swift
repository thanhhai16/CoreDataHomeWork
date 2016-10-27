//
//  StudentEntity+CoreDataProperties.swift
//  CoreDataHomeWork
//
//  Created by Hai on 10/27/16.
//  Copyright © 2016 Hai. All rights reserved.
//

import Foundation
import CoreData
 

extension StudentEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StudentEntity> {
        return NSFetchRequest<StudentEntity>(entityName: "StudentEntity");
    }

    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var picture: NSData?
    @NSManaged public var date: NSDate?
    @NSManaged public var classCourse: NSSet?

}

// MARK: Generated accessors for classCourse
extension StudentEntity {

    @objc(addClassCourseObject:)
    @NSManaged public func addToClassCourse(_ value: ClassEntity)

    @objc(removeClassCourseObject:)
    @NSManaged public func removeFromClassCourse(_ value: ClassEntity)

    @objc(addClassCourse:)
    @NSManaged public func addToClassCourse(_ values: NSSet)

    @objc(removeClassCourse:)
    @NSManaged public func removeFromClassCourse(_ values: NSSet)

}
