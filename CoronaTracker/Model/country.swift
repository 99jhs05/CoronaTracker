//
//  country.swift
//  CoronaTracker
//
//  Created by Jae Ho Shin on 2020-03-23.
//  Copyright © 2020 Jae Ho Shin. All rights reserved.
//
import SwiftUI

struct country: Identifiable{
    let id = UUID()
    var name: String
    var confirmed: Int
    var deaths: Int
    var recovered: Int
    var active: Int
    var subRegions: [region]
}
