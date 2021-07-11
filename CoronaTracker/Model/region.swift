//
//  region.swift
//  CoronaTracker
//
//  Created by Jae Ho Shin on 2021-07-10.
//  Copyright © 2021 Jae Ho Shin. All rights reserved.
//

import Foundation

struct region: Identifiable{
    let id = UUID()
    var name: String
    var confirmed: Int
    var deaths: Int
    var recovered: Int
    var active: Int
}
