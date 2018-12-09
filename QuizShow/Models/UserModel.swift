//
//  UserModel.swift
//  QuizShow
//
//  Created by Alican Aycil on 9.12.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation
import ObjectMapper

class UserModel : Mappable {
    
    var Name: String!
    var Balance: Double!
    var Ranking: Int!
    var Joker: Int!
    
    init() {
    }
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        Name        <- map["name"]
        Balance     <- map["balance"]
        Ranking     <- map["ranking"]
        Joker      <- map["joker"]
        
        Name = Name ?? ""
        Balance = Balance ?? 0
        Ranking = Ranking ?? 0
        Joker = Joker ?? 0
    }
}
