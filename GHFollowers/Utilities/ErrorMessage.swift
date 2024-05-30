//
//  ErrorMessage.swift
//  GHFollowers
//
//  Created by apple on 2024/5/28.
//

import Foundation

enum GFError:String,Error {
    case invalidUserName   = "invalid url,pls try again"
    case unableToComplete = "unable to complete"
    case invalidResponse = "invalid response"
    case invalidData = "invalid data"
    case unableToFavourite = "unable to retrieve data"
    case alreadyInFavourites = "already in favourites"

}
