//
//  UIViewController.swift
//  QuizShow
//
//  Created by Alican Aycil on 8.12.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    var screenSize: CGRect {
        get {
            return UIScreen.main.bounds
        }
    }
    
    func showAlert(title: String?, message: String?, buttonName: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonName, style: .default, handler: nil))
        if self.tabBarController != nil {
            self.tabBarController?.present(alert, animated: true, completion: nil)
        } else {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
