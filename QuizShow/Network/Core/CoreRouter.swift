//
//  CoreRouter.swift
//  QuizShow
//
//  Created by Alican Aycil on 9.12.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation
import Alamofire

public enum CoreRouter : URLRequestConvertible {
    
    static let baseUrl = "https://demo9240527.mockable.io"
    
    case GetUser()
    case GetQuestions()
    case GetWinners()
    
    var method: Alamofire.HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .GetUser():
            return "/user"
        case .GetQuestions():
            return "/questions"
        case .GetWinners():
            return "/questions"
        }
    }
    
    public func asURLRequest() throws -> URLRequest {
        let url = URL(string: CoreRouter.baseUrl)!
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self {
        case .GetUser(),
             .GetQuestions(),
             .GetWinners():
            //            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            return try Alamofire.JSONEncoding.default.encode(urlRequest)
        }
    }
}
