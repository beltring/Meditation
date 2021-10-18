//
//  Song+CoreDataProperties.swift
//  
//
//  Created by Pavel Boltromyuk on 18.10.21.
//
//

import Foundation
import CoreData

@objc(Song)
public class Song: NSManagedObject {

}

extension Song {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Song> {
        return NSFetchRequest<Song>(entityName: "Song")
    }

    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var data: Data?

}
