//
//  Request.swift
//  DeliveryApp
//
//  Created by Arun Jose on 22/09/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import Foundation

protocol RequestEndPoint {
    var baseUrl:URL { get }
    var path:String { get }
    var httpMethod: HTTPMethod { get }
    var httpHeaders: HTTPHeaders { get }
    var parameters:ParameterEncoding { get }
}

public typealias HTTPHeaders = [String:String]

public enum HTTPMethod:String{
    case post = "POST"
    case get = "GET"
}


