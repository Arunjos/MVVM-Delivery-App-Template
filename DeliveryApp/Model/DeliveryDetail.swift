//
//  DeliveryDetail.swift
//  DeliveryApp
//
//  Created by Arun Jose on 26/09/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import Foundation

public struct DeliveryDetail:Codable, Equatable {
    
    var id: Int?
    var deliveryDesc: String?
    var imageURL: String?
    var location: Location?
    
    enum CodingKeys: String, CodingKey{
        case deliveryDesc = "description"
        case imageURL = "imageUrl"
    }
    
    public static func == (lhs: DeliveryDetail, rhs: DeliveryDetail) -> Bool {
        if lhs.deliveryDesc == rhs.deliveryDesc && lhs.id == rhs.id && lhs.imageURL == rhs.imageURL && lhs.location == rhs.location{
            return true
        }
        return false
    }
}
