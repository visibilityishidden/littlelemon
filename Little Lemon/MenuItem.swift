//
//  MenuItem.swift
//  Little Lemon
//
//  Created by Yaroslav Liashevych on 23.09.2023.
//

import Foundation

struct MenuItem: Decodable, Identifiable {
    var id: Int
    let title: String
    let image: String
    let price: String
    let description: String
}
