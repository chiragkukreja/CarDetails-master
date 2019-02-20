//
//  Router.swift
//  MyTaxi
//
//  Created by Chirag Kukreja on 09/02/19.
//  Copyright © 2019 Chirag Kukreja. All rights reserved.
//

import Foundation

 enum ServiceError: Swift.Error {
    case invalidURL
    case noData
}
public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: class {
    associatedtype EndPoint: EndPointType
    func request<T: Codable>(_ route: EndPoint,  mapToModel: T.Type, onSuccess: @escaping (T) -> Void,
                             onError: @escaping (Error) -> Void)
    func cancel()
}

class Router<EndPoint: EndPointType>: NetworkRouter {
    private var task: URLSessionTask?
    
    func request<T: Codable>(_ route: EndPoint,  mapToModel: T.Type, onSuccess: @escaping (T) -> Void,
                             onError: @escaping (Error) -> Void) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
           NetworkLogger.log(request: request)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                
                if let error = error {
                    DispatchQueue.main.async {
                        onError(error)
                    }
                    return
                }
                
                guard let responseData = data else {
                    DispatchQueue.main.async {
                        onError(ServiceError.noData)
                    }
                    return
                }
                
                do {
                    let jsonDecoder = JSONDecoder()
                    let result = try jsonDecoder.decode(T.self, from: responseData)
                    DispatchQueue.main.async {
                        onSuccess(result)
                    }
                } catch let error {
                    DispatchQueue.main.async {
                        onError(error)
                    }
                }

            })
        }catch {
           onError(ServiceError.invalidURL)
        }
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    func buildRequest(from route: EndPoint) throws -> URLRequest {
        
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        
        request.httpMethod = route.httpMethod.rawValue
        do {
            switch route.task {
            case .request:
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            case .requestParameters(let bodyParameters,
                                    let bodyEncoding,
                                    let urlParameters):
                
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
                
            case .requestParametersAndHeaders(let bodyParameters,
                                              let bodyEncoding,
                                              let urlParameters,
                                              let additionalHeaders):
                
                self.addAdditionalHeaders(additionalHeaders, request: &request)
                try self.configureParameters(bodyParameters: bodyParameters,
                                             bodyEncoding: bodyEncoding,
                                             urlParameters: urlParameters,
                                             request: &request)
            }
            return request
        } catch {
            throw error
        }
    }
    
    func configureParameters(bodyParameters: Parameters?,
                                         bodyEncoding: ParameterEncoding,
                                         urlParameters: Parameters?,
                                         request: inout URLRequest) throws {
        do {
            try bodyEncoding.encode(urlRequest: &request,
                                    bodyParameters: bodyParameters, urlParameters: urlParameters)
        } catch {
            throw error
        }
    }
    
     func addAdditionalHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }
}
