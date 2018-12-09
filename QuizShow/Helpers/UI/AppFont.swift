//
//  AppFont.swift
//  QuizShow
//
//  Created by Alican Aycil on 8.12.2018.
//  Copyright © 2018 Alican Aycil. All rights reserved.
//

import Foundation
import UIKit

enum AppFont: String {
    case light = "HelveticaNeue-Light"
    case ultraLight = "HelveticaNeue-UltraLight"
    case thin = "HelveticaNeue-Thin"
    case bold = "HelveticaNeue-Bold"
    case regular = "HelveticaNeue"
    case medium = "HelveticaNeue-Medium"
    case lightItalic = "HelveticaNeue-LightItalic"
    case regularItalic = "HelveticaNeue-Italic"
}

extension AppFont {
    
    var pt60: UIFont {
        return UIFont.init(name: self.rawValue, size: 60)!
    }
    
    var pt50: UIFont {
        return UIFont.init(name: self.rawValue, size: 50)!
    }
    
    var pt39: UIFont {
        return UIFont.init(name: self.rawValue, size: 30)!
    }
    
    var pt30: UIFont {
        return UIFont.init(name: self.rawValue, size: 30)!
    }
    
    var pt25: UIFont {
        return UIFont.init(name: self.rawValue, size: 25)!
    }
    
    var pt23: UIFont {
        return UIFont.init(name: self.rawValue, size: 23)!
    }
    
    var pt20: UIFont {
        return UIFont.init(name: self.rawValue, size: 20)!
    }
    
    var pt19: UIFont {
        return UIFont.init(name: self.rawValue, size: 19)!
    }
    
    var pt18: UIFont {
        return UIFont.init(name: self.rawValue, size: 18)!
    }
    
    var pt17: UIFont {
        return UIFont.init(name: self.rawValue, size: 17)!
    }
    
    var pt16: UIFont {
        return UIFont.init(name: self.rawValue, size: 16)!
    }
    
    var pt15: UIFont {
        return UIFont.init(name: self.rawValue, size: 15)!
    }
    
    var pt14: UIFont {
        return UIFont.init(name: self.rawValue, size: 14)!
    }
    
    var pt13: UIFont {
        return UIFont.init(name: self.rawValue, size: 13)!
    }
    
    var pt12: UIFont {
        return UIFont.init(name: self.rawValue, size: 12)!
    }
    
    var pt11: UIFont {
        return UIFont.init(name: self.rawValue, size: 11)!
    }
    
    var pt10: UIFont {
        return UIFont.init(name: self.rawValue, size: 10)!
    }
    
    var pt9: UIFont {
        return UIFont.init(name: self.rawValue, size: 9)!
    }
    
    var pt8: UIFont {
        return UIFont.init(name: self.rawValue, size: 8)!
    }
    
    var pt7: UIFont {
        return UIFont.init(name: self.rawValue, size: 7)!
    }
    
    
}
