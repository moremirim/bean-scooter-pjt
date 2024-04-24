//
//  MapManager.swift
//  Bean-scooter-app
//
//  Created by Dongik Song on 4/24/24.
//

import Foundation
import Alamofire

class MapManager {
    func fetchRequest(textString: String, completion: @escaping (Result<MapModel, Error>) -> Void) {
        let url = "https://dapi.kakao.com/v2/local/search/address.json"
        let header: HTTPHeaders = ["Authorization" : "KakaoAK API_Key"]
        let parameter = ["query" : textString]
        
        AF.request(url, method: .get, parameters: parameter, headers: header).responseDecodable(of: MapModel.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
}
