//
//  ViewController.swift
//  QuizShow
//
//  Created by Alican Aycil on 5.12.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import UIKit
import SnapKit

class QuestionsViewController: BaseViewController {
    
    var didSetupConstraints = false
    lazy var tableView = UITableView()
    lazy var navigationView = UIView()
    lazy var dissmissButton = UIButton()
    lazy var bgImageView = UIImageView()
    
    let dataSource = DynamicValue<[QuestionModel]>([QuestionModel]())
    
    lazy var viewModel : QuestionsViewModel = {
        let viewModel = QuestionsViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    lazy var questionIndex = 0
    var selectedAnswerIndex: Int?
    lazy var jokerNumber = 0
    lazy var isJokerUsed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = ""
        self.startLoader()
        
        bgImageView.image = #imageLiteral(resourceName: "blueImage.jpg").withRenderingMode(.alwaysOriginal)
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.clipsToBounds = true
        self.view.addSubview(bgImageView)
        
        navigationView.backgroundColor = UIColor.piBlue.withAlphaComponent(0.8)
        self.view.addSubview(navigationView)
        
        dissmissButton.setImage(#imageLiteral(resourceName: "close.png").withRenderingMode(.alwaysOriginal), for: .normal)
        dissmissButton.addTarget(for: .touchUpInside) { (button) in
            self.dismiss(animated: true, completion: nil)
        }
        self.navigationView.addSubview(dissmissButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(QuestionViewCell.classForCoder(), forCellReuseIdentifier: "QuestionViewCell")
        tableView.register(QuestionHeaderViewCell.classForCoder(), forCellReuseIdentifier: "QuestionHeaderViewCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.piBlue.withAlphaComponent(0.8)
        self.view.addSubview(tableView)
        
        self.dataSource.addAndNotify(observer: self) { [weak self] in
            if self!.dataSource.value.count > 0 {
                self!.tableView.reloadData()
            }
        }
        
        
        self.viewModel.getQuestions() { [weak self] in
            self?.stopLoader()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            
            navigationView.snp.makeConstraints { (make) in
                make.top.left.right.equalToSuperview()
                make.height.equalTo(60)
            }
            
            dissmissButton.snp.makeConstraints { (make) in
                make.top.equalTo(25)
                make.right.equalTo(-15)
                make.width.equalTo(35)
                make.height.equalTo(35)
            }
            
            bgImageView.snp.makeConstraints { (make) in
                make.top.bottom.left.right.equalToSuperview()
            }
            
            tableView.snp.makeConstraints { (make) in
                make.top.equalTo(navigationView.snp.bottom).offset(0)
                make.bottom.left.right.equalToSuperview()
            }
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    func answerQuestion() {
            for (index,item) in self.dataSource.value[questionIndex].Answers.enumerated() {
                if selectedAnswerIndex != nil && selectedAnswerIndex != 0 {
                    if item.IsTrue && selectedAnswerIndex == index+1 {
                        (self.tableView.visibleCells[selectedAnswerIndex!] as! QuestionViewCell).bgView.backgroundColor = .piGreen
                        self.continueCompetition(onlyWatch: false)
                    } else if item.IsTrue && selectedAnswerIndex != index+1 {
                        (self.tableView.visibleCells[selectedAnswerIndex!] as! QuestionViewCell).bgView.backgroundColor = .piStrongRed
                        (self.tableView.visibleCells[index+1] as! QuestionViewCell).bgView.backgroundColor = .piGreen
                        if self.jokerNumber > 0 && isJokerUsed  {
                            self.continueCompetition(onlyWatch: true)
                        } else {
                           self.openAlert()
                        }
                    }
                } else {
                    if item.IsTrue {
                        self.selectedAnswerIndex = 0
                        (self.tableView.visibleCells[index+1] as! QuestionViewCell).bgView.backgroundColor = .piStrongRed
                        if self.jokerNumber > 0 && isJokerUsed {
                            self.continueCompetition(onlyWatch: true)
                        } else {
                            self.openAlert()
                        }
                    }
                }
            }
    }
    
    func continueCompetition(onlyWatch: Bool!) {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            if !onlyWatch {
                self.selectedAnswerIndex = nil
            } else {
                self.selectedAnswerIndex = 0
            }
            self.questionIndex += 1
            if self.questionIndex == self.dataSource.value.count {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.tableView.reloadData()
            }
        }
    }
    
    func openAlert() {
        let alert = UIAlertController(title: "Uyarı", message: "Joker kullanarak yarışmaya devam etmek ister misiniz?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Devam Et", style: .default, handler: { a in
            self.jokerNumber -= 1
            self.isJokerUsed = true
            self.continueCompetition(onlyWatch: false)
        }))
        alert.addAction(UIAlertAction(title: "İptal", style: .default, handler: { a in
            self.isJokerUsed = true
            self.continueCompetition(onlyWatch: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension QuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.dataSource.value.count > 0 {
            return 4
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionHeaderViewCell", for: indexPath) as! QuestionHeaderViewCell
            let headermodel = QuestionHaderModel(question: self.dataSource.value[self.questionIndex].Question, questionNumber: self.dataSource.value.count, questionIndex: self.questionIndex+1, jokerNumber: self.jokerNumber)
            cell.set(headerModel: headermodel)
            cell.controller = self
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionViewCell", for: indexPath) as! QuestionViewCell
            cell.set(answerModel: self.dataSource.value[self.questionIndex].Answers[indexPath.row-1])
            cell.selectionStyle = .none
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard selectedAnswerIndex == nil else { return }
        if let selectedCell = tableView.visibleCells[indexPath.row] as? QuestionViewCell {
            selectedCell.bgView.backgroundColor = .lightGray
            self.selectedAnswerIndex = indexPath.row
        }
    }
    
}
