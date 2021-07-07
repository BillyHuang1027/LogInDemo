//
//  Account.swift
//  LogIn
//
//  Created by 黃昌齊 on 2021/6/30.
//

import Foundation

struct Account: Codable {
    let profile: Profile
    let credentials: Credentials
}

struct Profile: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let login: String
    let mobilePhone: String
}

struct Credentials: Codable {
    let password: Password
    
    struct Password: Codable {
        let value: String
    }
}

struct LoginAccount: Codable {
    let username: String
    let password: String
}
