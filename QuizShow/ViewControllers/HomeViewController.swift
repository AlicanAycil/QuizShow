//
//  HomeViewController.swift
//  QuizShow
//
//  Created by Alican Aycil on 9.12.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: BaseViewController {
    
    var didSetupConstraints = false
    lazy var bgImageView = UIImageView()
    lazy var titleLabel = UILabel()
    lazy var descriptionLabel = UILabel()
    lazy var profilImageView = UIImageView()
    lazy var bgView = UIView()
    lazy var nameLabel = UILabel()
    lazy var straightView = UIView()
    lazy var balanceTitleLabel = UILabel()
    lazy var balanceLabel = UILabel()
    lazy var rankingTitleLabel = UILabel()
    lazy var rankingLabel = UILabel()
    lazy var heartImageView = UIImageView()
    lazy var jokerTitleLabel = UILabel()
    lazy var jokerLabel = UILabel()
    lazy var startButtonBgView = UIView()
    lazy var startButton = UIButton()
    
    let dataSource = DynamicValue<UserModel>(UserModel())
    
    lazy var viewModel : HomeViewModel = {
        let viewModel = HomeViewModel(dataSource: dataSource)
        return viewModel
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = ""
        
        bgImageView.image = #imageLiteral(resourceName: "blueImage.jpg").withRenderingMode(.alwaysOriginal)
        bgImageView.contentMode = .scaleAspectFill
        bgImageView.clipsToBounds = true
        self.view.addSubview(bgImageView)
        
        titleLabel.text = "QuizShow"
        titleLabel.textColor = .white
        titleLabel.font = AppFont.bold.pt50
        titleLabel.sizeToFit()
        titleLabel.numberOfLines = 1
        self.view.addSubview(titleLabel)
        
        descriptionLabel.text = "Bilgi yarışması ile bilginizi sınayın. Bilginizi yarıştırın, seviyenizi görün. Ödüllü bilgi yarışması ile hem eğlen hem kazan."
        descriptionLabel.textColor = .white
        descriptionLabel.font = AppFont.bold.pt20
        descriptionLabel.textAlignment = .center
        descriptionLabel.sizeToFit()
        descriptionLabel.numberOfLines = 0
        self.view.addSubview(descriptionLabel)
        
        bgView.backgroundColor = UIColor.piBlue.withAlphaComponent(0.9)
        bgView.layer.cornerRadius = 10
        bgView.layer.borderWidth = 1
        bgView.layer.borderColor = UIColor.piLightBlue.cgColor
        self.view.addSubview(bgView)
        
        profilImageView.image = #imageLiteral(resourceName: "user.png").withRenderingMode(.alwaysOriginal)
        profilImageView.contentMode = .scaleAspectFit
        profilImageView.backgroundColor = UIColor.piBlue
        profilImageView.layer.cornerRadius = 40
        profilImageView.layer.borderWidth = 1
        profilImageView.layer.borderColor = UIColor.piLightBlue.cgColor
        self.view.addSubview(profilImageView)
        
        nameLabel.text = "alicanaycil"
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        nameLabel.font = AppFont.bold.pt20
        nameLabel.sizeToFit()
        nameLabel.numberOfLines = 1
        self.bgView.addSubview(nameLabel)
        
        straightView.backgroundColor = .white
        self.bgView.addSubview(straightView)
        
        balanceTitleLabel.text = "BAKİYE"
        balanceTitleLabel.textColor = .white
        balanceTitleLabel.textAlignment = .center
        balanceTitleLabel.font = AppFont.bold.pt12
        balanceTitleLabel.sizeToFit()
        balanceTitleLabel.numberOfLines = 1
        self.bgView.addSubview(balanceTitleLabel)
        
        rankingTitleLabel.text = "SIRALAMA"
        rankingTitleLabel.textColor = .white
        rankingTitleLabel.textAlignment = .center
        rankingTitleLabel.font = AppFont.bold.pt12
        rankingTitleLabel.sizeToFit()
        rankingTitleLabel.numberOfLines = 1
        self.bgView.addSubview(rankingTitleLabel)
        
        
        balanceLabel.textColor = .piYellow
        balanceLabel.textAlignment = .center
        balanceLabel.font = AppFont.bold.pt25
        balanceLabel.sizeToFit()
        balanceLabel.numberOfLines = 1
        self.bgView.addSubview(balanceLabel)
        
        
        rankingLabel.textColor = .piYellow
        rankingLabel.textAlignment = .center
        rankingLabel.font = AppFont.bold.pt25
        rankingLabel.sizeToFit()
        rankingLabel.numberOfLines = 1
        self.bgView.addSubview(rankingLabel)
        
        heartImageView.image = #imageLiteral(resourceName: "heart.png").withRenderingMode(.alwaysOriginal)
        heartImageView.contentMode = .scaleAspectFit
        self.bgView.addSubview(heartImageView)
        
        jokerTitleLabel.text = "JOKER"
        jokerTitleLabel.textColor = .white
        jokerTitleLabel.textAlignment = .center
        jokerTitleLabel.font = AppFont.bold.pt15
        jokerTitleLabel.sizeToFit()
        jokerTitleLabel.numberOfLines = 1
        self.bgView.addSubview(jokerTitleLabel)
        
        
        jokerLabel.textColor = .white
        jokerLabel.textAlignment = .center
        jokerLabel.font = AppFont.bold.pt17
        jokerLabel.sizeToFit()
        jokerLabel.numberOfLines = 1
        self.bgView.addSubview(jokerLabel)
        
        self.bgView.addSubview(startButtonBgView)
        
        startButton.setTitle("BAŞLA!", for: .normal)
        startButton.titleLabel?.font = AppFont.bold.pt15
        startButton.setTitleColor(.white, for: .normal)
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor.white.cgColor
        startButton.layer.cornerRadius = 10
        startButton.sizeToFit()
        startButton.addTarget(for: .touchUpInside) { (button) in
            let controller = AppStoryboard.Home.view(controllerClass: QuestionsViewController.self)
            controller.jokerNumber = self.dataSource.value.Joker
            let rootController = UINavigationController(rootViewController: controller)
            rootController.modalPresentationStyle = .overFullScreen
            self.present(rootController, animated: true, completion: nil)
        }
        self.startButtonBgView.addSubview(startButton)
        
        self.dataSource.addAndNotify(observer: self) { [weak self] in
            guard let name = self!.dataSource.value.Name, let joker = self!.dataSource.value.Joker, let ranking = self!.dataSource.value.Ranking, let balance = self!.dataSource.value.Balance else { return }
            self!.nameLabel.text = name
            self!.jokerLabel.text = "\(joker)"
            self!.rankingLabel.text = (ranking == 0) ? "-" : "\(ranking)"
            self!.balanceLabel.text = (balance == 0.0) ? "0 ₺" : "\(balance) ₺"
        }
        
        self.view.setNeedsUpdateConstraints()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.startLoader()
        self.viewModel.getUser { [weak self] in
            self?.stopLoader()
        }
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            
            bgImageView.snp.makeConstraints { (make) in
                make.top.bottom.left.right.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(40)
                make.centerX.equalTo(self.view)
            }
            
            descriptionLabel.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(20)
                make.left.equalTo(20)
                make.right.equalTo(-20)
            }
            
            profilImageView.snp.makeConstraints { (make) in
                make.top.equalTo(descriptionLabel.snp.bottom).offset(20)
                make.centerX.equalTo(self.view)
                make.width.equalTo(80)
                make.height.equalTo(80)
            }
            
            bgView.snp.makeConstraints { (make) in
                make.top.equalTo(profilImageView.snp.bottom).offset(-40)
                make.left.equalTo(30)
                make.right.equalTo(-30)
                make.height.equalTo(240)
            }
            
            nameLabel.snp.makeConstraints { (make) in
                make.top.equalTo(50)
                make.left.equalTo(20)
                make.right.equalTo(-20)
            }
            
            straightView.snp.makeConstraints { (make) in
                make.top.equalTo(85)
                make.centerX.equalTo(self.bgView)
                make.width.equalTo(2)
                make.height.equalTo(100)
            }
            
            balanceTitleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(105)
                make.left.equalTo(10)
                make.right.equalTo(straightView.snp.left).offset(-10)
            }
            
            rankingTitleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(105)
                make.right.equalTo(-10)
                make.left.equalTo(straightView.snp.right).offset(10)
            }
            
            balanceLabel.snp.makeConstraints { (make) in
                make.top.equalTo(135)
                make.left.equalTo(10)
                make.right.equalTo(straightView.snp.left).offset(-10)
            }
            
            rankingLabel.snp.makeConstraints { (make) in
                make.top.equalTo(135)
                make.right.equalTo(-10)
                make.left.equalTo(straightView.snp.right).offset(10)
            }
            
            heartImageView.snp.makeConstraints { (make) in
                make.top.equalTo(straightView.snp.bottom).offset(-10)
                make.centerX.equalTo(self.bgView)
                make.width.equalTo(50)
                make.height.equalTo(50)
            }
            
            jokerTitleLabel.snp.makeConstraints { (make) in
                make.top.equalTo(straightView.snp.bottom).offset(3)
                make.left.equalTo(10)
                make.right.equalTo(heartImageView.snp.left).offset(-10)
            }
            
            jokerLabel.snp.makeConstraints { (make) in
                make.top.equalTo(straightView.snp.bottom).offset(3)
                make.centerX.equalTo(self.bgView)
            }
            
            startButtonBgView.snp.makeConstraints { (make) in
                make.top.equalTo(straightView.snp.bottom).offset(-3)
                make.right.equalTo(0)
                make.left.equalTo(heartImageView.snp.right).offset(0)
            }
            
            startButton.snp.makeConstraints { (make) in
                make.top.equalTo(0)
                make.width.equalTo(80)
                make.bottom.equalTo(0)
                make.centerX.equalTo(startButtonBgView)
            }
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
}

