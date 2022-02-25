//
//  Constants.swift
//  ConsumerVPN
//
//  Created by Amir Nazari on 9/16/16.
//  Copyright © 2018 Stackpath. All rights reserved.
//

import Foundation

final class Theme {
    
    static let productName = "AlterVPN"
    static let brandName = "AlterVPN"

    static let forgotPasswordURL = "http://www.altervpn.net/"
    static let registerURL = "https://www.google.com/"
    static let contactSupportURL = "https://www.altervpn.net/"

    static let usernameSuffix = "Kuvik"
    static let apiKey = "6643dc70013f45b3fff79aa3bbb02273"
    
    // MARK: User Defaults Keys
    static let lastUpdateKey = "lastUpdateKey"
    static let isInitialLoad = "isInitialLoadDone"
    static let sortOptionKey = "sortOption"
    static let filterPingRangeKey = "filterPingRange"
    static let loginErrorKey = "loginError"
    
}

// MARK: - Target Specific Colors
extension UIColor {
    static var connectButton: UIColor {
       // return UIColor(hexColorString: "5FB006")
        return primaryBackground
    }
    static var disconnectButton: UIColor {
        return UIColor(hexColorString: "F54941")
    }
    static var pingFont: UIColor {
        return UIColor(hexColorString: "7ED321")
    }
    
    // Some Targets have a secondary accent color and others do not
    // Some Targets have a secondary background color and others do not
    
    // Azul Oscuro: 002439
    // Azul Turquesa: 55DCDE
    // Amarillo: CBDB2A

    static var primaryAccent: UIColor {
        return UIColor(hexColorString: "002439")
    }
    static var secondaryAccent: UIColor {
        return UIColor(hexColorString: "55DCDE")
    }
    static var primaryBackground: UIColor {
        return UIColor(hexColorString: "002439") //azul oscuro
    }
    static var selectedServer: UIColor {
        return UIColor(hexColorString: "002439")
    }
    
    // Buttons
    static var loginButtonBackground: UIColor {
        return UIColor(hexColorString: "CBDB2A")
    }
    static var signUpButtonBorder: UIColor {
        return primaryAccent
    }
    
    // Backgrounds
    static var loginBackground: UIColor {
        return .primaryBackground
    }
    static var serverListBackground: UIColor {
        return UIColor(hexColorString: "002439")
    }
    static var filterBackground: UIColor {
        return .serverListBackground
    }
    static var settingsBackground: UIColor {
        return .serverListBackground
    }
    
    // Cell colors
    static var settingsCell: UIColor {
        return .selectedServer
    }
    static var filterCell: UIColor {
        return .selectedServer
    }
    
    // Fonts
    static var primaryFont: UIColor {
        return .white
    }
    static var secondaryFont: UIColor {
        return .secondaryAccent
    }
    static var optionsFont: UIColor {
        return .primaryFont
    }
    static var loginFieldFont: UIColor {
        return .primaryFont
    }
    
    static var placeholderFont: UIColor {
         return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.2028039384)
     }
    
    // Navigation Bar
    static var navigationBar: UIColor {
        return .black
    }
    static var navigationItem: UIColor {
        return .white
    }
    
    // Controls
    static var checkmark: UIColor {
        return .primaryAccent
    }
    static var segmentedControl: UIColor {
        return UIColor(hexColorString: "CBDB2A")
    }
    static var cellSeparator: UIColor {
        return .white
    }
    static var cellAccessory: UIColor {
        return .white
    }
    
    // KVN Customization
    static var kvnBackgroundFill: UIColor {
        return UIColor(hexColorString: "1C1F22")
    }
    static var kvnCircleStrokeColor: UIColor {
        return .white
    }
    static var kvnErrorColor: UIColor {
        return UIColor(hexColorString: "F54941")
    }
    static var kvnSuccessColor: UIColor {
        return UIColor(hexColorString: "5FB006")
    }
    static var kvnStatusTextColor: UIColor {
        return .white
    }
}
