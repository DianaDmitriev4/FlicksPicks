//
//  MovieEntity+CoreDataProperties.swift
//  FlicksPicks
//
//  Created by User on 09.02.2024.
//
//

import Foundation
import CoreData


extension MovieEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }
    
    @NSManaged public var poster: String?
    @NSManaged public var rating: Double
    @NSManaged public var name: String?
    @NSManaged public var filmsDescription: String?
    @NSManaged public var year: Int32
    @NSManaged public var imageData: Data?
    @NSManaged public var genres: String?
    @NSManaged public var countries: String?
}

extension MovieEntity : Identifiable {
    
}
