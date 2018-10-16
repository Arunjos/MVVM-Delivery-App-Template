//
//  DeliveryListViewModel.swift
//  DeliveryApp
//
//  Created by Arun Jose on 09/10/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import Foundation

func apiController() {
    
    URLSessionAPIService().dispatch(apiRequest: DeliveryRequestsEndPoint.deliveryList(offset: 1, limit: 10)) { (data, response, error) in
    if let data = data{
    do{
    let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    print(json)
    }catch{
    print(error)
    }
    }
    if let response = response{
    print(response)
    }
    if let error = error{
    print(error)
    }
    }
}
