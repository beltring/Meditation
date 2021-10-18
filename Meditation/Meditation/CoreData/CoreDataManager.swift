//
//  CoreDataManager.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 18.10.21.
//

import CoreData
import UIKit

class CoreDataManager {
    static let shared = CoreDataManager()
    let context: NSManagedObjectContext = ((UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext)!
    
    private init() {}
    
    func getSong(url: URL) -> Song {
        var song = Song()
        let fetchRequest = Song.fetchRequest()
        let predicate = NSPredicate(format: "url = %@", url.absoluteString)
        fetchRequest.predicate = predicate
        do {
            let data = try context.fetch(fetchRequest)
            song = data[0]
        } catch {
            print("getSong: error in get song")
        }
        
        return song
    }
    
    func addSong(title: String, url: String, data: Data?) {
        let song = Song(context: context)
        song.title = title
        song.url = url
        song.data = data
        saveContext()
    }
    
    func checkSong(url: String) -> Bool {
        let request = Song.fetchRequest()
        request.predicate = NSPredicate(format: "url = %@", url)
        do {
            let song = try context.fetch(request)
            if song.isEmpty {
                return false
            }
        } catch { print("checkSong: error in check song") }
        return true
    }
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                context.rollback()
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
