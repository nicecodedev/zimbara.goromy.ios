//
//  WebApi.swift
//  zimbara goromi
//
//  Created by Artem Eremeev on 19.04.2018.
//  Copyright © 2018 Artem Eremeev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol WebApiCoding {
    init()
    init?(_ json: JSON?)
}

enum WebApiResponse {
    case successed(json: JSON?)
    case failed(code: Int)
    
    var success: Bool {
        if case .successed = self {
            return true
        }
        return false
    }
    
    var errorCode: Int? {
        if case let .failed(code) = self {
            return code
        }
        return nil
    }
    
    func single<T: WebApiCoding>() -> T? {
        if case let .successed(json) = self {
            return T(json)
        }
        return nil
    }
    func collection<T: WebApiCoding>() -> [T]? {
        if case let .successed(json) = self {
            return json?.arrayValue.map { json in return T(json) ?? T() }
        }
        return nil
    }
}

enum WebApiRouter: URLRequestConvertible {
    
    private static let base = "https://zimbaragoromi.leotrado.com/api/v1"
    private static let domain = "https://zimbaragoromi.leotrado.com"
    
    case booksLanguages(authorization: String?)
    case booksFor(languageCode: String, authorization: String?)
    case bookFor(bookId: Int, languageCode: String, authorization: String?)
    case bookContentFor(bookId: Int, languageCode: Int, authorization: String?)
    
    var path: String {
        switch self {
            
        case .booksLanguages:
            return "books/lang/"
            
        case let .booksFor(languageCode, _):
            return "books/\(languageCode)/"
            
        case let .bookFor(bookId, languageCode, _):
            return "books/\(languageCode)/\(bookId)/"
            
        case let .bookContentFor(bookId, languageCode, _):
            return "books/\(languageCode)/\(bookId)/content/"
        }
        
    }
    
    var method: HTTPMethod {
        switch self {
            
        case .booksLanguages, .booksFor, .bookFor, .bookContentFor:
            return .get
            
        }
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        var url = URL(string: WebApiRouter.base)!
        url.appendPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return try encoding.encode(request, with: nil)
    }
    
    static func url(forPreviewPath previewPath: String) -> URL? {
        var url = try? WebApiRouter.domain.asURL()
        url?.appendPathComponent(previewPath)
        return url
    }
}

class WebApiManager {
    
    private static let sessionManager = Alamofire.SessionManager.default
    
    static func use(router: WebApiRouter, response: @escaping (WebApiResponse) -> Void) {
        sessionManager.request(router).responseJSON { dataResponse in
            let code = dataResponse.response?.statusCode ?? 0
            let result = dataResponse.result.value as Any
            let json = JSON(result)
            
            print("response: \(router)\ncode: \(code)")
            print("json: \(json)")
            
            guard dataResponse.result.isSuccess else {
                let apiResponse = WebApiResponse.failed(code: code)
                response(apiResponse)
                return
            }
            
            let apiResponse = WebApiResponse.successed(json: json)
            response(apiResponse)
        }
    }
    
}
