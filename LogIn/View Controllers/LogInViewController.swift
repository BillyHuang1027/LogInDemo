//
//  LogInViewController.swift
//  LogIn
//
//  Created by 黃昌齊 on 2021/6/30.
//

import UIKit

class LogInViewController: UIViewController {
    
    var firstName: String?
    var lastName: String?
    var username: String?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageLabel.text = ""
    }
    
    @IBAction func singIn(_ sender: Any) {
        if let username = emailTextField.text, let password = passwordTextField.text {
            
            AccountController.shared.logIn(username: username, password: password) { (result) in
                switch result {
                case .success(let userInfo):
                    print("Login success")
                    print(userInfo)
                    self.firstName = userInfo._embedded.user.profile.firstName
                    self.lastName = userInfo._embedded.user.profile.lastName
                    self.username = userInfo._embedded.user.profile.login
                    DispatchQueue.main.async {
                        self.messageLabel.text = ""
                        self.performSegue(withIdentifier: "ToProfilePage", sender: sender)
                    }
                    
                case .failure(let error):
                    print("Login fail")
                    print(error)
                    DispatchQueue.main.async {
                        self.messageLabel.text = "Sign in fail"
                    }
                }
            }
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let controller = segue.destination as! ProfileTableViewController
        controller.source = false
        controller.firstName = firstName
        controller.lastName = lastName
        controller.userName = username
    }
    

}
