//
//  Session.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 21.02.24.
//

import Foundation

struct Session: Identifiable, Codable, Hashable{
    let id: String
    let participants: [String]
    let startTime: Date
    let endTime: Date
}

struct SessionElement: Identifiable, Codable, Hashable{
    let startTime: Date
    let id: String
    let username: String
    let lapTime: Double
}
