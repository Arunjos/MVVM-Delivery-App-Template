//
//  JSONCoderService.swift
//  DeliveryApp
//
//  Created by Arun Jose on 01/10/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import Foundation

struct JSONCoderService:ObjectCoderService {
    func encode<OBJ:Codable>(object: OBJ) -> (Data?, Error?) {
        do{
            let jsonData = try JSONEncoder().encode(object)
            return(jsonData, nil)
        }catch{
            return(nil, error)
        }
    }
    
    func decode<OBJ:Codable>(objectType: OBJ.Type, data: Data) -> (OBJ?, Error?) {
        do{
           let decodeObj = try JSONDecoder().decode(objectType, from: data)
            return(decodeObj,nil)
        }catch{
            return(nil, error)
        }
    }
    
}
