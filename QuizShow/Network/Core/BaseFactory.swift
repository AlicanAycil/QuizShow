//
//  BaseFactory.swift
//  QuizShow
//
//  Created by Alican Aycil on 9.12.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation
import SwiftyJSON

class BaseFactory {
    
    public class func getResultAsBoolean(data: Data) -> Bool {
        
        let response = String(data: data, encoding: String.Encoding.utf8)
        if let responseAsBool = Bool(response!) {
            return responseAsBool
        }
        return false
    }
    
    public class func getErrorMessageAsString(data: Data?) -> String {
        if let result = data {
            do {
                let responseJson = try JSON(data: result)
                if responseJson != JSON.null && responseJson["Message"].exists() {
                    return responseJson["Message"].stringValue
                }
            } catch {
                let responseString = String(data: result, encoding: .utf8)
                if responseString != nil && responseString != "" {
                    return responseString!
                }
                return "General Error 1001"
            }
        }
        return "General Error 1002"
    }
}
