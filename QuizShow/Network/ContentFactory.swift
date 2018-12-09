//
//  ContentFactory.swift
//  QuizShow
//
//  Created by Alican Aycil on 10.12.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import AlamofireObjectMapper

class ContentFactory {
    class func getQuestions() -> Promise<[QuestionModel]>  {
        return Promise { seal in
            Alamofire.request(CoreRouter.GetQuestions()).validate().responseArray { (response: DataResponse<[QuestionModel]>) in
                switch response.result {
                case .success(_):
                    let result = response.result.value
                    seal.fulfill(result!)
                case .failure(_):
                    seal.reject(ApiError.fail(response.response?.statusCode, description: BaseFactory.getErrorMessageAsString(data: response.data)))
                }
            }
        }
    }
}
