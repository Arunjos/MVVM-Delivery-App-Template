//
//  DeliveryDetailViewModelFromDeliverDetail.swift
//  DeliveryApp
//
//  Created by Arun Jose on 22/10/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import Foundation
import CoreLocation

class DeliveryDetailViewModelFromDeliverDetail:NSObject, DeliveryDetailViewModel{
    var imageUrl: String
    var coordinate: CLLocationCoordinate2D
    var deliverDescription: String
    var address: String
    
    init(deliverDetail:DeliveryDetail) {
        self.imageUrl = deliverDetail.imageURL ?? ""
        self.deliverDescription = deliverDetail.deliveryDesc ?? ""
        self.coordinate = CLLocationCoordinate2D(latitude: deliverDetail.location?.lat ?? 0.00, longitude: deliverDetail.location?.lng ?? 0.00)
        self.address = deliverDetail.location?.address ?? ""
        super.init()
    }
}
