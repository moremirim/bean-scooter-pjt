//
//  PinSingleton.swift
//  Bean-scooter-app
//
//  Created by Dongik Song on 4/27/24.
//

import Foundation

class savedPinSington {
    
    static let shared = savedPinSington()
    
    var array: [PinData] = [PinData]()

    private init () {}
    
}
