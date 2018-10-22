//
//  DeliveryDetailViewModel.swift
//  DeliveryApp
//
//  Created by Arun Jose on 22/10/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import Foundation
import CoreLocation

protocol DeliveryDetailViewModel {
    var imageUrl:String { get }
    var deliverDescription:String { get }
    var address:String { get }
    var coordinate:CLLocationCoordinate2D { get }
}
