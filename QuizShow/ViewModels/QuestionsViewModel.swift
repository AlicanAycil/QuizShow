//
//  QuestionsViewModel.swift
//  QuizShow
//
//  Created by Alican Aycil on 10.12.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation

struct QuestionsViewModel {
    
    weak var dataSource: DynamicValue<[QuestionModel]>?
    
    init(dataSource : DynamicValue<[QuestionModel]>?) {
        self.dataSource = dataSource
    }
    
    func getQuestions(completion: @escaping ()-> Void = {}) {
        ContentFactory.getQuestions()
            .done { questions -> Void in
                self.dataSource?.value = questions
            }.catch { (error) in
                let error = error as! ApiError
                print(error.handle.description)
            }.finally {
                completion()
            }
    }
}
