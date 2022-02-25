//
//  SortOption.swift
//  ConsumerVPN
//
//  Created by Joshua Shroyer on 9/20/16.
//  Copyright © 2018 Stackpath. All rights reserved.
//

import Foundation

enum SortOption: Int {
    case city, country, serverCount
}

// MARK: - CustomStringConvertible
extension SortOption: CustomStringConvertible {
    var description: String {
        switch self {
        case .city:
            return LocalizedString.citySelection
        case .country:
            return LocalizedString.countrySelection
        case .serverCount:
            return LocalizedString.serverCountSelection
        }
    }
}
