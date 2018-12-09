//
//  AnswerModel.swift
//  QuizShow
//
//  Created by Alican Aycil on 10.12.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation
import ObjectMapper

class AnswerModel : Mappable {
    
    var Title: String!
    var IsTrue: Bool!
    var IsSelected = false
    
    init() {
    }
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        Title    <- map["title"]
        IsTrue  <- map["isTrue"]
        
        Title = Title ?? ""
        IsTrue = IsTrue ?? false
    }
}
