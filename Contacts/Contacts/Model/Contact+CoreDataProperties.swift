//
//  Contact+CoreDataProperties.swift
//  Contacts
//
//  Created by Mohamed Mostafa on 14/03/2023.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var fullName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var number: String?
    @NSManaged public var image: Data?

}

extension Contact : Identifiable {

}
