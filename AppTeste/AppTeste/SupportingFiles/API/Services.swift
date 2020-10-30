//
//  Services.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import Foundation
import Alamofire

protocol ServiceRequests {
    func loadMovies(completion: @escaping (String?, [Movie]?) -> Void)
    func loadMovieDetail(movieId: String, completion: @escaping (String?, Movie?) -> Void)
    func book(parameters: [String: Any], completion: @escaping (String?, BookResponse?) -> Void)
}

class ServiceManager {
    
    // MARK: - Config
    static let BASE_URL = "http://demo2654434.mockable.io/api/"
    static let HEADER : HTTPHeaders = [
                        "Content-Type": "application/x-www-form-urlencoded",
                        "Accept": "application/json, text/plain, */*"]
    var alamoFireManager : Alamofire.Session?
    
    // MARK: - Endpoints
    static let ENDPOINT_MOVIES = "movies"
    static let ENDPOINT_MOVIE_DETAIL = "movies/"
    static let ENDPOINT_BOOK = "book"
    
    
    func request<T:Decodable>(method: HTTPMethod, parameters: [String: Any]?, endpoint: String, completion: @escaping (String?, T?) -> Void){

        let urlString = ServiceManager.BASE_URL + endpoint

        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        alamoFireManager = Alamofire.Session(configuration: configuration)
        
        _ = alamoFireManager?.request(urlString, method: method, parameters: parameters).responseData { response in
            //Need to retain session
            _ = self

            if let error = response.error {
                
                if let errorMessage = error.errorDescription?.split(separator: ":").last {
                    completion("\(errorMessage)", nil)
                    return
                }
                completion(nil, nil)
                return
            }
            
            
            switch response.result {
            case .success:
                
                guard let jsonData = response.data,
                      let response = try? JSONDecoder().decode(T.self, from: jsonData) else {
                    completion(nil, nil)
                    return
                }
                completion(nil, response)
                
            case .failure:
                completion(nil, nil)
            }
        }
        
    }
    

}

extension ServiceManager: ServiceRequests {
    
    func loadMovies(completion: @escaping (String?, [Movie]?) -> Void){
        
        request(method: .get, parameters: nil, endpoint:ServiceManager.ENDPOINT_MOVIES, completion: completion)
    }
    
    func loadMovieDetail(movieId: String, completion: @escaping (String?, Movie?) -> Void){

        request(method: .get, parameters: nil, endpoint:ServiceManager.ENDPOINT_MOVIE_DETAIL + movieId, completion: completion)
    }
    
    func book(parameters: [String: Any], completion: @escaping (String?, BookResponse?) -> Void){
        
        request(method: .post, parameters: parameters, endpoint:ServiceManager.ENDPOINT_BOOK) { (errorMessage, bookResponse:BookResponse?) in
            completion(errorMessage, bookResponse)
        }
    }
}

struct BookResponse: Decodable {
    var code : String?
}
