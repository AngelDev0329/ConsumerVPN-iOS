//
//  FilterViewControllerDelegate.swift
//  ConsumerVPN
//
//  Created by Joshua Shroyer on 9/22/16.
//  Copyright © 2018 Stackpath. All rights reserved.
//

import Foundation

protocol FilterViewControllerDelegate {
    func filterViewController(_ filterViewController: FilterViewController, selected sortOption: SortOption)
}
