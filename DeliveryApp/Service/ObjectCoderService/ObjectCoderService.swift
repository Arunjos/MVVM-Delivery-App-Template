//
//  ObjectCoderService.swift
//  DeliveryApp
//
//  Created by Arun Jose on 28/09/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import Foundation

protocol ObjectCoderService{
    func encode<OBJ:Codable>(object:OBJ) -> (Data?, Error?)
    func decode<OBJ:Codable>(objectType:OBJ.Type, data:Data) -> (OBJ?, Error?)
}
