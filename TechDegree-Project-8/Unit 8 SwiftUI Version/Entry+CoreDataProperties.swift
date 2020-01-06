//
//  Entry+CoreDataProperties.swift
//  Unit 8 SwiftUI Version
//
//  Created by Joseph Heydorn on 1/3/20.
//  Copyright © 2020 Joseph Heydorn. All rights reserved.
//
//

import Foundation
import CoreData


extension Entry: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var diaryEntry: String
    @NSManaged public var mood: String
    @NSManaged public var date: String
    @NSManaged public var location: String

}
