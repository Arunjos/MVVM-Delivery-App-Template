//
//  DeliveryDetail.swift
//  DeliveryApp
//
//  Created by Arun Jose on 26/09/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import Foundation

struct DelveryDetail:Codable, Equatable {
    
    var id: Int?
    var deliveryDesc: String?
    var imageURL: String?
    var location: Location?
    
    static func == (lhs: DelveryDetail, rhs: DelveryDetail) -> Bool {
        if lhs.deliveryDesc == rhs.deliveryDesc && lhs.id == rhs.id && lhs.imageURL == rhs.imageURL && lhs.location == rhs.location{
            return true
        }
        return false
    }
}
