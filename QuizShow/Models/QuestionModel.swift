//
//  QuestionModel.swift
//  QuizShow
//
//  Created by Alican Aycil on 10.12.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation
import ObjectMapper

class QuestionModel : Mappable {
    
    var Question: String!
    var Answers = [AnswerModel]()
    
    init() {
    }
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        Question    <- map["question"]
        Answers     <- map["answers"]
        
        Question = Question ?? ""
    }
}
