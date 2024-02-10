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

    @NSManaged public var poster: URL?
    @NSManaged public var rating: Double
    @NSManaged public var name: String?
    @NSManaged public var filmsDescription: String?
    @NSManaged public var year: Int32

}

extension MovieEntity : Identifiable {

}
