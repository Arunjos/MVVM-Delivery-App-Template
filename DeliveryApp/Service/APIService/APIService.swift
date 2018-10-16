//
//  APIService.swift
//  DeliveryApp
//
//  Created by Arun Jose on 21/09/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import Foundation

public typealias APIServiceCompletion = (_ data:Data?, _ reponse:URLResponse?, _ error:Error?) -> ()

protocol APIService{
    func dispatch(apiRequest:RequestEndPoint, completion: @escaping APIServiceCompletion)
}

