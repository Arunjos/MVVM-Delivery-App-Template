//
//  ParameterEncoding.swift
//  DeliveryApp
//
//  Created by Arun Jose on 23/09/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import Foundation

public typealias Parameters = [String:Any]

public protocol ParameterEncoder {
    func encode(urlRequest: inout URLRequest, parameters:Parameters) throws
}


public enum ParameterEncoding{
    case none
    case body(parameter : Parameters?)
    case url(parameter : Parameters?)
    
    func encode(urlReqeuest: inout URLRequest) throws {
        do{
            switch self {
            case .none:
                return
            case .url(let parameter):
                guard let parameter = parameter else{ return}
                try URLParameterEncoding().encode(urlRequest: &urlReqeuest, parameters: parameter)
            case .body(_):
                return
            }
        }catch{
            throw error
        }
    }
}

public enum NetworkErrors: String, Error{
    case parametersNil = "Parameters were nil"
    case encodingFailed = "Parameter Encoding Failed"
    case missingURL = "URL is nil"
}
