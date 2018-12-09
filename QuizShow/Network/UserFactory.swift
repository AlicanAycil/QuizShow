//
//  UserFactory.swift
//  QuizShow
//
//  Created by Alican Aycil on 9.12.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import AlamofireObjectMapper

class UserFactory {
    class func getUser() -> Promise<UserModel>  {
        return Promise { seal in
            Alamofire.request(CoreRouter.GetUser()).validate().responseObject { (response: DataResponse<UserModel>) in
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
