//
//  APIClient.swift
//  Weathy
//
//  Created by Семен Семенов on 22.10.2020.
//

import Foundation

class APIClient {
    
    enum Result<String> {
        case success
        case failure(String)
    }
    
    private var defaultTask: URLSessionDataTask?
    
    private var defaultSession: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func start<T: Decodable>(url: String, responseModel: T.Type, completion: @escaping (RequestResult<T>) -> Void) {
        guard let request = getURLRequest(url: url) else { return }
        
        defaultTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) in
            var completionResult: RequestResult<T> = .failure(R.string.localizable.commonError())
            defer {
                DispatchQueue.main.async {
                    completion(completionResult)
                }
            }
            
            if let error = error {
                completionResult = .failure(error.localizedDescription)
            }
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completionResult = .failure(R.string.localizable.commonNetworkingNoData())
                        return
                    }
                    guard let apiResponse = self.decodeJSON(responseModel.self, data: responseData) else {
                        completionResult = .failure(R.string.localizable.commonNetworkingUnableToDecode())
                        return
                    }
                    completionResult = .success(apiResponse)
                case .failure(let error):
                    completionResult = .failure(error)
                }
            }
        })
        defaultTask?.resume()
    }
    
    func stop() {
        defaultTask?.cancel()
    }
}

extension APIClient {
    private func getURLRequest(url: String) -> URLRequest? {
        
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 45.0)
        request.httpMethod = "GET"
        
        return request
    }
    
    private func decodeJSON<T: Decodable>(_ type: T.Type, data: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            _ = try decoder.decode(type.self, from: data)
        } catch {
            print(error)
        }
        guard let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
        switch response.statusCode {
        case 200...299:
            return .success
        case 401...500:
            return .failure(R.string.localizable.commonNetworkingAuthenticationError())
        case 501...599:
            return .failure(R.string.localizable.commonNetworkingBadRequest())
        case 600:
            return .failure(R.string.localizable.commonNetworkingOutdated())
        default:
            return .failure(R.string.localizable.commonNetworkingFailed())
        }
    }
}
