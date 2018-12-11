//
//  QuestionHeaderViewCell.swift
//  QuizShow
//
//  Created by Alican Aycil on 10.12.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import UICircularProgressRing

class QuestionHeaderViewCell: UITableViewCell {
    
    var didSetupConstraints = false
    let screenSize = UIScreen.main.bounds
    
    lazy var secondView = UICircularProgressRing()
    lazy var questionNumberTitleLabel = UILabel()
    lazy var questionNumberLabel = UILabel()
    lazy var jokerTitleLabel = UILabel()
    lazy var jokerLabel = UILabel()
    lazy var questionLabel = UILabel()
    var controller: QuestionsViewController!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        
        questionNumberTitleLabel.text = "Soru"
        questionNumberTitleLabel.textColor = .white
        questionNumberTitleLabel.font = AppFont.bold.pt17
        questionNumberTitleLabel.sizeToFit()
        questionNumberTitleLabel.numberOfLines = 1
        self.contentView.addSubview(questionNumberTitleLabel)
        
        
        questionNumberLabel.textColor = .piYellow
        questionNumberLabel.font = AppFont.bold.pt17
        questionNumberLabel.sizeToFit()
        questionNumberLabel.numberOfLines = 1
        self.contentView.addSubview(questionNumberLabel)
        
        jokerTitleLabel.text = "JOKER"
        jokerTitleLabel.textColor = .white
        jokerTitleLabel.font = AppFont.bold.pt17
        jokerTitleLabel.sizeToFit()
        jokerTitleLabel.numberOfLines = 1
        self.contentView.addSubview(jokerTitleLabel)
        
        
        jokerLabel.textColor = .piYellow
        jokerLabel.font = AppFont.bold.pt17
        jokerLabel.sizeToFit()
        jokerLabel.numberOfLines = 1
        self.contentView.addSubview(jokerLabel)
        
        secondView.startAngle = -90
        secondView.maxValue = 11
        secondView.ringStyle = .ontop
        secondView.outerRingColor = .clear
        secondView.innerRingColor = UIColor.piRed.withAlphaComponent(0.9)
        secondView.innerRingWidth = 6
        secondView.outerRingWidth = 6
        secondView.valueIndicator = ""
        secondView.font = AppFont.regular.pt25
        secondView.fontColor = .white
        self.contentView.addSubview(secondView)
        
        questionLabel.textColor = .white
        questionLabel.textAlignment = .center
        questionLabel.font = AppFont.bold.pt25
        questionLabel.sizeToFit()
        questionLabel.numberOfLines = 0
        self.contentView.addSubview(questionLabel)
        
        self.contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if(!didSetupConstraints){
            
            questionNumberTitleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(10)
                make.left.equalTo(15)
            }
            
            questionNumberLabel.snp.makeConstraints { (make) in
                make.top.equalTo(32)
                make.left.equalTo(15)
            }
            
            jokerTitleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(10)
                make.right.equalTo(-15)
            }
            
            jokerLabel.snp.makeConstraints { (make) in
                make.top.equalTo(32)
                make.right.equalTo(-15)
            }
            
            secondView.snp.makeConstraints { (make) in
                make.top.equalTo(10)
                make.centerX.equalTo(self.contentView)
                make.width.equalTo(70)
                make.height.equalTo(70)
            }
            
            questionLabel.snp.makeConstraints { (make) in
                make.top.equalTo(secondView.snp.bottom).offset(20)
                make.left.equalTo(15)
                make.right.equalTo(-15)
                make.bottom.equalTo(0)
            }
            
            didSetupConstraints = true
        }
        
        super.updateConstraints()
    }
    
    func set(headerModel: QuestionHaderModel!) {
        questionLabel.text = headerModel.Question!
        questionNumberLabel.text = "\(headerModel.QuestionIndex!)/\(headerModel.QuestionNumber!)"
        jokerLabel.text = "\(headerModel.JokerNumber!)"
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5, execute: {
            self.secondView.animationTimingFunction = CAMediaTimingFunctionName.linear
            self.secondView.startProgress(to: 11, duration: 0) { [unowned self] in
                // Increase it more, and customize some properties
                self.secondView.startProgress(to: 0, duration: 11) {
                    self.controller.answerQuestion()
                }
            }
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
