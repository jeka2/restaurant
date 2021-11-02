//
//  RestaurantModel.swift
//  Restaurant Project
//
//  Created by Yevgeniy Ivanov on 11/2/21.
//

import Foundation

//{
//    "restaurants" : [
//    {
//        "name": "Hopdoddy Burger Bar",
//        "backgroundImageURL": "http://sandbox.bottlerocketapps.com/BR_iOS_CodingExam_2015_Server/Images/hopdoddy.png",
//        "category" : "Burgers",
//        "contact": {
//                "phone": "9723872337",
//                "formattedPhone": "(972) 387-2337",
//                "twitter": "hopdoddy"
//            },
//            "location": {
//                "address": "5100 Belt Line Road, STE 502",
//                "crossStreet": "Dallas North Tollway",
//                "lat": 32.950787,
//                "lng": -96.821118,
//                "postalCode": "75254",
//                "cc": "US",
//                "city": "Addison",
//                "state": "TX",
//                "country": "United States",
//                "formattedAddress": [
//                    "5100 Belt Line Road, STE 502 (Dallas North Tollway)",
//                    "Addison, TX 75254",
//                    "United States"
//                ]
//            }
//    },

// location
// formateedphone
// twitter

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
    let address : String?
    let city : String?
    let state : String?
    let postalCode : String?
}
