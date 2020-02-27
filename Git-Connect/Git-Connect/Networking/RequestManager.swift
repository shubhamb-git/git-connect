//
//  RequestManager.swift
//  Git-Connect
//
//  Created by Shubham Bairagi on 27/02/20.
//  Copyright © 2020 sb. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkProtocol {
     func dataRequest<T: Codable>(with inputRequest: RouterProtocol, completionHandler: @escaping (ServiceResponse<T>) -> Void)
    func cancelAllRequests()
}

final class RequestManager {
    private init() {}
    
    static var shared = RequestManager()
    
    static let boundaryConstant = "aRandomBoundary1837440"

//    fileprivate var dataRequestArray: [DataRequest] = []

    fileprivate let manager: SessionManager = { () -> SessionManager in
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let sessionManager = SessionManager(configuration: configuration)
        return sessionManager
    }()
}

extension RequestManager: NetworkProtocol {
 
    func dataRequest<T: Codable>(with inputRequest: RouterProtocol, completionHandler: @escaping (ServiceResponse<T>) -> Void) {
        
        print("ROUTER BASE", GCConstants.baseUrl)
        print("ROUTER PARAMETERS", inputRequest.parameters ?? [:])
        print("ROUTER PATH", inputRequest.path)
        print("ROUTER PATH", inputRequest.headers ?? "")
        print("ROUTER VERB", inputRequest.method)
        
        do {
            _ = try inputRequest.asURLRequest()
        } catch let requestError {
            completionHandler(.failure(error: NetworkError.connection(requestError)))
            return
        }

        /*let dataRequest = */
        request(inputRequest).responseData { (response) in
            print("+++++++++++++++++++++")
            print(response)
            print("+++++++++++++++++++++")
            self.serializeResponse(response: response, completion: completionHandler)
        }
        //TODO:- Need to handle multiple dataRequests in an array in order to implement cancellation
//        dataRequestArray.append(dataRequest)
    }
    
    private func serializeResponse<T>(response: Alamofire.DataResponse<Data>,  completion: @escaping (ServiceResponse<T>) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            
            switch response.result {
            case .success(let value):
                let json = try? JSONSerialization.jsonObject(with: value, options: .mutableContainers)
                print(json ?? "")
                
                guard let object = WSResponse<T>(jsonData: value) else {
                    completion(.failure(error: NetworkError.corruptedData))
                    return
                }
                switch object.responseContent {
                case .successResult(let sResult):
                    // returns expected model
                    completion(.success(response: sResult))
                case .failureResult(let fResult):
                    // returns error webservice failure model
                    completion(.failure(error: NetworkError.webserviceFailure(failureModel: fResult)))
                }
            case .failure(let error):
                if let error = error as NSError?, error.code == NSURLErrorNotConnectedToInternet {
                    completion(.notConnectedToInternet)
                } else {
                    completion(.failure(error: NetworkError.connection(error)))
                }
            }
        }
    }
    
    func cancelAllRequests() {
//        for dataRequest in self.dataRequestArray {
//            dataRequest.cancel()
//        }
//        self.dataRequestArray.removeAll()
    }
}


