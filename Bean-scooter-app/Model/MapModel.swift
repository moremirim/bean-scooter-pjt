//
//  MapModel.swift
//  Bean-scooter-app
//
//  Created by Dongik Song on 4/24/24.
//

import Foundation

struct MapModel: Decodable {
    
    let documents: [Document]
 
}

struct Document: Decodable {
    
    let addressName: String
    let x: String
    let y: String
    
    enum CodingKeys: String, CodingKey {
        
        case addressName = "address_name"
        case x
        case y
        
    }
    
}
