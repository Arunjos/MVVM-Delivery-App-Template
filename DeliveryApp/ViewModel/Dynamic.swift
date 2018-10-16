//
//  Dynamic.swift
//  DeliveryApp
//
//  Created by Arun Jose on 15/10/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import Foundation

class Dynamic<T>{
    typealias Listener = (T) -> ()
    
    var listeners:[Listener]?
    var value:T {
        didSet{
            listeners?.forEach{
                $0(value)
            }
        }
    }
    
    init(_ v:T) {
        value = v
    }
    func bind(_ listener: @escaping Listener){
        self.listeners?.append(listener)
    }
}
