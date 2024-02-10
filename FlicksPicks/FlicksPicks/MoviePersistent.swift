//
//  MoviePersistent.swift
//  FlicksPicks
//
//  Created by User on 09.02.2024.
//

import CoreData
import Foundation

final class MoviePersistent {
    private static let context = AppDelegate.persistentContainer.viewContext
    
    static func save(_ movie: Doc) {
        
    }
    
    static func delete(_ movie: Doc) {
        
    }
    
    static func fetchAll() -> [Doc] {
        return []
    }
}
