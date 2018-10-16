//
//  DeliveryRequestEndPoint.swift
//  DeliveryApp
//
//  Created by Arun Jose on 23/09/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import Foundation

public enum DeliveryRequestsEndPoint:RequestEndPoint{
    
    case  deliveryList(offset:Int, limit:Int)
    
    var baseUrl: URL{
        switch self {
        case .deliveryList(_,_):
            guard let url = URL(string: "https://mock-api-mobile.dev.lalamove.com/")else{
                fatalError("Base Url could not be configured")
            }
            return url
        }
    }
    
    var path: String{
        switch self {
        case .deliveryList(_,_):
            return("deliveries")
        }
    }
    
    var httpMethod: HTTPMethod{
        switch self {
        case .deliveryList(_, _):
            return HTTPMethod.get
        }
    }
    
    var httpHeaders: HTTPHeaders{
        switch self {
        case .deliveryList(_,_):
            return ["Content-Type":"application/json"]
        }
    }
    
    var parameters: ParameterEncoding{
        switch self {
        case .deliveryList(let offset, let limit):
            return ParameterEncoding.url(parameter: ["offset":offset, "limit":limit])
        }
    }
}
