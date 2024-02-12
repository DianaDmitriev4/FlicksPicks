//
//  MoviePersistent.swift
//  FlicksPicks
//
//  Created by User on 09.02.2024.
//

import CoreData
import Foundation

final class MoviePersistent {
    // MARK: - Properties
    private static let context = AppDelegate.persistentContainer.viewContext
    
    // MARK: - Methods
    static func save(_ movie: MovieResponseViewModel) {
        guard let description = NSEntityDescription.entity(forEntityName: "MovieEntity", in: context) else { return }
        let entity = MovieEntity(entity: description, insertInto: context)
        
        entity.filmsDescription = movie.description
        entity.name = movie.name
        entity.poster = movie.poster
        entity.rating = movie.rating
        entity.year = Int32(movie.year)
        entity.imageData = movie.imageData
        
        do {
            try context.save()
        } catch let error {
            debugPrint("Save movie error: \(error)")
        }
        saveContext()
    }
    
    static func deleteEntity() {
        
    }
    
    static func deleteAll() {
        let request = MovieEntity.fetchRequest()
        do {
            let objects = try context.fetch(request)
            for object in objects {
                context.delete(object)
            }
        } catch let error {
            debugPrint("Fetch notes error: \(error)")
        }
        saveContext()
    }
    
    static func fetchAll() -> [MovieResponseViewModel] {
        let request = MovieEntity.fetchRequest()
        do {
            let movies = try context.fetch(request)
            return convert(entities: movies)
        } catch let error {
            debugPrint("Fetch movies error: \(error)")
            return []
        }
    }
    
    // MARK: - Private methods
    //    private static func getEntity(for movie: ModelFromCoreData) -> MovieEntity? {
    //        let request = MovieEntity.fetchRequest()
    //
    //        do {
    //            let objects = try context.fetch(request)
    //            return objects.first
    //        } catch let error {
    //            debugPrint("Fetch notes error: \(error)")
    //            return nil
    //        }
    //    }
    private static func postNotification() {
        NotificationCenter.default.post(name: NSNotification.Name("Update"), object: nil)
    }
    
    private static func convert(entities: [MovieEntity]) -> [MovieResponseViewModel] {
        let movies = entities.map {
            MovieResponseViewModel(Doc(poster: Poster(url: $0.poster ?? ""),
                                       rating: Rating(kp: $0.rating),
                                       name: $0.name,
                                       description: $0.filmsDescription,
                                       year: Int($0.year)),
                                   imageData: $0.imageData)
        }
        return movies
    }
    
    private static func saveContext() {
        do {
            try context.save()
            postNotification()
        } catch let error {
            debugPrint("Save not error: \(error)")
        }
    }
}
