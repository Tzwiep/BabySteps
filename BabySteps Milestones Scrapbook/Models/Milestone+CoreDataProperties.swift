//
//  Milestone+CoreDataProperties.swift
//  BabySteps Milestones Scrapbook
//
//  Created by Tyler Zwiep on 2021-07-21.
//
//

import Foundation
import CoreData


extension Milestone {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Milestone> {
        return NSFetchRequest<Milestone>(entityName: "Milestone")
    }

    @NSManaged public var imageName: String?
    @NSManaged public var title: String?
    @NSManaged public var date: String?
    @NSManaged public var lat: Double
    @NSManaged public var summary: String?
    @NSManaged public var long: Double

}

extension Milestone : Identifiable {

}
