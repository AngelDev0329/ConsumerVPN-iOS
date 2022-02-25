//
//  AccessibilityLabel.swift
//  ConsumerVPN
//
//  Created by Joshua Shroyer on 10/18/16.
//  Copyright © 2018 Stackpath. All rights reserved.
//

import Foundation

// Avoid using words that describe the UI element like `Button` or `Label` and ideally should be
// a single word to describe action to users as in `Play`, `Settings`, or `Delete`

// Labels are great for non-textual pieces of UI or UI that should have more context. For instance,
// assume our app is a competitive app of some kind where we can see history of game sessions. For normal users,
// they might see `W` or `L` and associate that with `Win` or `Loss`, but a blind person may not get that same context.

/// A centralized place to store strings for accessibility identifiers so it can be used in both the application and tests.
/// These strings will be heard by visually impaired users and therefore needs to be localized.
enum AccessibilityLabel {
    
    // MARK: Buttons
    static let settingsButton = NSLocalizedString("Configuración",
                                                  comment: "Accessibility for settings button")
    
    static let filterButton = NSLocalizedString("Filtros",
                                                comment: "Accessibility for filter button")
    
    static let searchButton = NSLocalizedString("Busqueda",
                                                comment: "Accessibility for search button")
    
    // MARK: Ping Range
    static let lessThanFifty = NSLocalizedString("Menos de 50",
                                                 comment: "Accessibility for less than 50 filter option")
    
    static let betweenFiftyAndOneHundred = NSLocalizedString("Entre 50 y 100",
                                                             comment: "Accessibility for between 50 and 100 filter option")
    
    static let betweenOneHundredAndTwoHundred = NSLocalizedString("Entre 100 y 200",
                                                                  comment: "Accessibility for between 100 and 200 filter option")
    
    static let greaterThanTwoHundred = NSLocalizedString("Más de 200",
                                                         comment: "Accessibility for greater than 200 filter option")
}
