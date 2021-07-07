//
//  RegisterViewController.swift
//  LogIn
//
//  Created by 黃昌齊 on 2021/7/1.
//

import UIKit

class RegisterViewController: UIViewController {
    
    let urlStr = "https://dev-39609430.okta.com/api/v1/users?activate=true"
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var mobilePhoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func dismissButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func register(_ sender: Any) {
        let profile = Profile(firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", email: emailTextField.text ?? "", login: emailTextField.text ?? "", mobilePhone: mobilePhoneTextField.text ?? "")
        let password = Credentials.Password(value: passwordTextField.text ?? "")
        let credentials = Credentials(password: password)
        let account = Account(profile: profile, credentials: credentials)
        AccountController.shared.createAccount(urlStr: urlStr, data: account) { (result) in
            switch result {
            case .success(let userProfile):
                print("Creat account successfully")
                print(userProfile)
                self.showMessage { (_) in

                    self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                }
                
            case .failure(let error):
                print("Fail to create account")
                print(error)
                self.showError(message: "Error: \(error)")
            }
        }
    }
    
    func showMessage(action: @escaping (UIAlertAction) -> Void) {
        let controller = UIAlertController(title: "Create account seccessfully!", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: action)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
    func showError(message: String) {
        let controller = UIAlertController(title: "Fail to create account.", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        controller.addAction(okAction)
        present(controller, animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension RegisterViewController: UITextFieldDelegate {
    //按Done收鍵盤
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    //點空白處收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
