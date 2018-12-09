//
//  HomeViewModel.swift
//  QuizShow
//
//  Created by Alican Aycil on 9.12.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation

struct HomeViewModel {
    
    weak var dataSource: DynamicValue<UserModel>?
    
    init(dataSource : DynamicValue<UserModel>?) {
        self.dataSource = dataSource
    }
    
    func getUser(completion: @escaping ()-> Void = {}) {
        UserFactory.getUser()
            .done { user -> Void in
                self.dataSource?.value = user
            }.catch { (error) in
                let error = error as! ApiError
                print(error.handle.description)
            }.finally {
                completion()
            }
    }
}
