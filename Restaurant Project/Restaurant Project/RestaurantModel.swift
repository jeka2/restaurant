//
//  RestaurantModel.swift
//  Restaurant Project
//
//  Created by Yevgeniy Ivanov on 11/2/21.
//

import Foundation

struct RestaurantResponse : Decodable {
    let restaurants : [Restaurant]
}

struct Restaurant : Decodable {
    let name : String
    let backgroundImageURL : String
    let category : String
    
    let contact : ContactInfo?
    let location : LocationInfo?
}

struct ContactInfo : Decodable {
    let formattedPhone : String?
    let twitter : String?
}

struct LocationInfo : Decodable {
    let lat : Double?
    let lng : Double?
    let address : String?
    let city : String?
    let state : String?
    let postalCode : String?
}
