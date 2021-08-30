//
//  Milestone+CoreDataProperties.swift
//  BabySteps
//
//  Created by Tyler Zwiep on 2021-07-26.
//
//

import Foundation
import CoreData


extension Milestone {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Milestone> {
        return NSFetchRequest<Milestone>(entityName: "Milestone")
    }

    @NSManaged public var date: String?
    @NSManaged public var lat: Double
    @NSManaged public var long: Double
    @NSManaged public var summary: String?
    @NSManaged public var title: String?
    @NSManaged public var image: Data?

}

extension Milestone : Identifiable {

}
