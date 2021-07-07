//
//  AccountController.swift
//  LogIn
//
//  Created by 黃昌齊 on 2021/6/30.
//

import Foundation
import UIKit

public let apikey = "00LS6R1D__CaUiR5LX873-kqQ2HuqOoN4QlDNeby61"
class AccountController {
    static let shared = AccountController()
    
    func createAccount(urlStr: String, data: Account, completion: @escaping (Result<Profile, Error>) -> Void) {
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("SSWS \(apikey)", forHTTPHeaderField: "Authorization")
        let encoder = JSONEncoder()
        request.httpBody = try? encoder.encode(data)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let content = String(data: data, encoding: .utf8)
                    print(content)
                    if let response = response as? HTTPURLResponse {
                        if response.statusCode == 200 {
                            let successResponse = try JSONDecoder().decode(CreateAndUpdateResponse.self, from: data)
                            DispatchQueue.main.async {
                                completion(.success(successResponse.profile))
                            }
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        } .resume()
    }
    
    func logIn(username: String, password: String, completion: @escaping (Result<LoginResponse,Error>) -> Void) {
        let urlStr = "https://dev-39609430.okta.com/api/v1/authn"
        let url = URL(string: urlStr)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("SSWS \(apikey)", forHTTPHeaderField: "Authorization")
        
        let loginAccount = LoginAccount(username: username, password: password)
        let data = try? JSONEncoder().encode(loginAccount)
        request.httpBody = data
        print(String(data: data!, encoding: .utf8))
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let loginResponse = try decoder.decode(LoginResponse.self, from: data)
                    completion(.success(loginResponse))
                } catch {
                    completion(.failure(error))
                }
            } else {
                print(error)
            }
        } .resume()
    }
}
