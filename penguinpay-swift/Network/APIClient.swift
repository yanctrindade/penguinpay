//
//  APIClient.swift
//  penguinpay-swift
//
//  Created by Yan Correa Trindade on 07/02/22.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

class APIClient {
    
    // MARK: - Properties
    private let baseURL = URL(string: "base_url")!
    private let session: URLSession
    
    // MARK: - Life Cycle
    init(session: URLSession = URLSession(configuration: .default)){
        self.session = session
    }
    
    // MARK: - Methods
}
