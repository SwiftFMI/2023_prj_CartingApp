//
//  Lap.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 21.02.24.
//

import Foundation

struct Lap: Identifiable, Codable, Hashable{
    let id: String
    let userId: String
    let lapTime: Double
}
