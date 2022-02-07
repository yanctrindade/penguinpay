//
//  Rates.swift
//  penguinpay-swift
//
//  Created by Yan Correa Trindade on 07/02/22.
//

import UIKit

struct Rates: Decodable {
    var base: String
    var timestamp: Int
    var rates: [String:Float]
}
