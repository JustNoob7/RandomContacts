//
//  NetworkManager.swift
//  RandomContacts
//
//  Created by Ярослав Бойко on 21.10.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private let urlParams = ["results": "\(15)"]
    
    private init() {}
    
    func fetchContacts(url: String, with completion: @escaping ([Contact]) -> Void) {
        AF.request(url, parameters: urlParams)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let contacts = Contact.getContacts(value: value) else { return }
                    completion(contacts)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func fetchData(from url: String, completion: @escaping (Data) -> Void) {
        AF.request(url)
            .validate()
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(data)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
