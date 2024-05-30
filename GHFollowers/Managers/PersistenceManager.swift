//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by apple on 2024/5/30.
//

import Foundation

enum PersistenceActionType {
    case add,remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys{
        static let favourites = "favourites"
    }
    
    static func updateWith(favourite:Follower,actiontype:PersistenceActionType,completed:@escaping (GFError?)->Void){
        retrieveFavorites { result in
            switch result {
                case .success(let favourites):
                    var retrivedFavourites = favourites
                    switch actiontype {
                         case .add:
                             guard !retrivedFavourites.contains(favourite) else {
                                 completed(.alreadyInFavourites)
                                 return
                             }
                             retrivedFavourites.append(favourite)
                   
                         case .remove:
                             retrivedFavourites.removeAll{$0.login == favourite.login}
                    }
                   
                    completed(save(favourite: retrivedFavourites))
                
                case .failure(let error):
                    completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed:@escaping (Result<[Follower],GFError>)->Void){
        
        guard let favouritesData = defaults.object(forKey: Keys.favourites) as? Data else{
            completed(.success([]))
            return
        }
        
        do{
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let favourites = try decoder.decode([Follower].self, from: favouritesData)
            completed(.success(favourites))
        }catch{
            completed(.failure(.unableToFavourite))
        }
        
    }
    
    static func save(favourite:[Follower])->GFError? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavourites = try encoder.encode(favourite)
            defaults.set(encodedFavourites, forKey: Keys.favourites)
            
        }catch{
            return .unableToFavourite
        }
        
        return nil
    }
}


