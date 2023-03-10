//
//  Contact+CoreDataProperties.swift
//  Contacts
//
//  Created by Mohamed Mostafa on 28/02/2023.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var number: String?

}

extension Contact : Identifiable {

}
