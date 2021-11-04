//
//  RestaurantModel.swift
//  Restaurant Project
//
//  Created by Yevgeniy Ivanov on 11/2/21.
//

import Foundation

struct RestaurantResponse : Codable {
    var restaurants : [Restaurant]
}

struct Restaurant : Codable {
    let name : String
    let backgroundImageURL : String
    let category : String
    
    let contact : ContactInfo?
    let location : LocationInfo?
}

struct ContactInfo : Codable {
    let formattedPhone : String?
    let twitter : String?
}

struct LocationInfo : Codable {
    let lat : Double?
    let lng : Double?
    let address : String?
    let city : String?
    let state : String?
    let postalCode : String?
}
