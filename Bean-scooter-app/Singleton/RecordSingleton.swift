//
//  RecordSingleton.swift
//  Bean-scooter-app
//
//  Created by Dongik Song on 4/26/24.
//

import Foundation

class RecordSingleton {
    
    static let shared = RecordSingleton()
    
    var array: [RecordModel] = [RecordModel]()
    
    private init () {}
    
}
