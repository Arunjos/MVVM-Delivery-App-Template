//
//  Location.swift
//  DeliveryApp
//
//  Created by Arun Jose on 26/09/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import Foundation

struct Location:Codable, Equatable{
    var lat: Double?
    var lng: Double?
    var address: String?
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        if lhs.address == rhs.address && lhs.lat == rhs.lat && lhs.lng == rhs.lng {
            return true
        }
        return false
    }
}
