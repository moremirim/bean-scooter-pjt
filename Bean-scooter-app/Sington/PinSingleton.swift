//
//  PinSingleton.swift
//  Bean-scooter-app
//
//  Created by Dongik Song on 4/27/24.
//

import Foundation

class PinSingleton {
    
    static let shared = PinSingleton()
    
    var array: [PinModel] = [PinModel]()
    
    private init () {}
    
}
