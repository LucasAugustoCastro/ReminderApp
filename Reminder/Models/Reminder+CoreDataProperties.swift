//
//  Reminder+CoreDataProperties.swift
//  Reminder
//
//  Created by Lucas Castro on 31/10/24.
//
//

import Foundation
import CoreData


extension Reminder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reminder> {
        return NSFetchRequest<Reminder>(entityName: "Reminder")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var date: Date?
    @NSManaged public var isCompleted: Bool

}

extension Reminder : Identifiable {

}
