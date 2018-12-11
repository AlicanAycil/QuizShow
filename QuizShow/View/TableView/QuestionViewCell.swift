//
//  QuestionViewCell.swift
//  QuizShow
//
//  Created by Alican Aycil on 10.12.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class QuestionViewCell: UITableViewCell {
    
    var didSetupConstraints = false
    let screenSize = UIScreen.main.bounds
    
    lazy var bgView = UIView()
    lazy var answerLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
        bgView.layer.borderWidth = 2
        bgView.layer.borderColor = UIColor.white.cgColor
        bgView.layer.cornerRadius = 25
        self.contentView.addSubview(bgView)
        
        answerLabel.textColor = .white
        answerLabel.textAlignment = .left
        answerLabel.font = AppFont.bold.pt20
        answerLabel.sizeToFit()
        answerLabel.numberOfLines = 0
        self.bgView.addSubview(answerLabel)
        
        self.bgView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if(!didSetupConstraints){
            
            bgView.snp.makeConstraints { (make) in
                make.top.equalTo(20)
                make.height.equalTo(50)
                make.bottom.equalTo(0)
                make.left.equalTo(20)
                make.right.equalTo(-20)
            }
            
            answerLabel.snp.makeConstraints { (make) in
                make.centerY.equalTo(self.bgView)
                make.left.equalTo(25)
                make.right.equalTo(-25)
            }
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func set(answerModel: AnswerModel) {
        answerLabel.text = answerModel.Title
        bgView.backgroundColor = UIColor.piSoftBlue.withAlphaComponent(0.5)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
