//
//  ArchiveCacheService.swift
//  DeliveryApp
//
//  Created by Arun Jose on 01/10/18.
//  Copyright © 2018 Arun Jose. All rights reserved.
//

import Foundation

public enum ArchiveError: String, Error{
    case archiveFailed = "Save Failed"
    case archiveFileIssue = "File Not Found"
    case archiveFileReadIssue = "File Read Failed"
}

protocol ArchiveCacheService {
    var fileName:String{get set}
    func save<OBJ:Codable>(object:OBJ) throws
    func retrive<OBJ:Codable>(objectType:OBJ.Type) throws -> (OBJ)
}
