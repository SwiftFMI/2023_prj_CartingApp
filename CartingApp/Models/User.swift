//
//  User.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 15.02.24.
//

import Foundation

struct User: Identifiable, Codable, Hashable{
    let id: String
    let fullname: String
    let email: String
    let nickname: String
    let bestTime: Double?
    var profileImageUrl: String?
}
