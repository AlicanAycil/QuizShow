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
    
    let dataSource = DynamicValue<[QuestionModel]>([QuestionModel]())
    
    lazy var viewModel : QuestionsViewModel = {
        let viewModel = QuestionsViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.piBlue
        self.navigationItem.title = ""
        self.startLoader()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(QuestionViewCell.classForCoder(), forCellReuseIdentifier: "QuestionViewCell")
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor.piBlue
        self.view.addSubview(tableView)
        
        self.dataSource.addAndNotify(observer: self) { [weak self] in
            
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
            tableView.snp.makeConstraints { (make) in
                make.top.bottom.left.right.equalToSuperview()
            }
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
}

extension QuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionViewCell", for: indexPath) as! QuestionViewCell
        cell.set()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
