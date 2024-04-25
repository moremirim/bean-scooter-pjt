//
//  AccountModel.swift
//  Bean-scooter-app
//
//  Created by Dongik Song on 4/24/24.
//

import Foundation

class AccountModel {
    
    static let accountModel = AccountModel()
    
    //유저디폴트 키 추가
    private let userDefaults = UserDefaults.standard
    private let userDefaultsKey = "accountInfoArr"
    
    var accountInfoArr: [AccountInfo] {
            get {
                guard let data = userDefaults.data(forKey: userDefaultsKey) else { return [] }
                if let decoded = try? JSONDecoder().decode([AccountInfo].self, from: data) {
                    return decoded
                }
                return []
            }
            set {
                if let encoded = try? JSONEncoder().encode(newValue) {
                    userDefaults.set(encoded, forKey: userDefaultsKey)
                }
            }
        }
        
        func addAccount(newAccount: AccountInfo) {
            var accounts = accountInfoArr
            accounts.append(newAccount)
            accountInfoArr = accounts
        }
    
    private init () {}
    
}
