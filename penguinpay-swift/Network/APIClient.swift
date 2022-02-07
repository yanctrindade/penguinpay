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
    private let baseURL = URL(string: "https://openexchangerates.org/api/latest.json")!
    private let session: URLSession
    
    // MARK: - Life Cycle
    init(session: URLSession = URLSession(configuration: .default)){
        self.session = session
    }
    
    // MARK: - Methods
    func getRates(completion: @escaping ( (Result<Rates>) -> Void) ){
        
        let queryString = "?app_id=\(Constants.API_KEY)"
        
        guard let requestURL = URL(string: queryString, relativeTo: baseURL) else {
            return
        }
        
        let request = URLRequest(url: requestURL)
        
        session.dataTask(with: request) { data, response, error in
            let decoder = JSONDecoder()
            if let data = data {
                
                do{
                    let rates = try decoder.decode(Rates.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(rates))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
                
            }else if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
}
