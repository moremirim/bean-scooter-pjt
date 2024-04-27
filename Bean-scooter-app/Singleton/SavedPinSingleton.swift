//
//  PinSingleton.swift
//  Bean-scooter-app
//
//  Created by Dongik Song on 4/27/24.
//

import Foundation

class SavedPinSingleton {
    
    static let shared = SavedPinSingleton()
    
    var array: [PinData] = [PinData]()

    private init () {}
    
}
