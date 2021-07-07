//
//  ResponseModels.swift
//  LogIn
//
//  Created by 黃昌齊 on 2021/7/2.
//

import Foundation

struct CreateAndUpdateResponse: Codable {
    let profile: Profile
}

struct LoginResponse: Codable {
    let status: String
    let sessionToken: String
    let _embedded: Embedded
    
    struct Embedded: Codable {
        let user: User
        
        struct User: Codable {
            let id: String
            let profile: Profile
            
            struct Profile: Codable {
                let login: String
                let firstName: String
                let lastName: String
            }
        }
    }
}
