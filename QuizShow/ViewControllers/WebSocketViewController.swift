//
//  WebSocketViewController.swift
//  QuizShow
//
//  Created by Alican on 11.12.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation
import UIKit
import SwiftWebSocket

class WebSocketViewController: UIViewController {
    
    var didSetupConstraints = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = ""
        
        let ws = WebSocket("wss://echo.websocket.org")
        ws.delegate = self
        ws.open()
        
        ws.event.message = { message in
            if let text = message as? String {
                
            }
        }
        
        ws.send(text: "Test")
        
        self.view.setNeedsUpdateConstraints()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
}

extension WebSocketViewController: WebSocketDelegate {
    func webSocketOpen() {
        print("opened")
    }
    
    func webSocketClose(_ code: Int, reason: String, wasClean: Bool) {
        print("close")
    }
    
    func webSocketError(_ error: NSError) {
        print("error \(error)")
    }
}
