//
//  GetStartedViewController.swift
//  LogIn
//
//  Created by 黃昌齊 on 2021/6/28.
//

import UIKit
import FacebookLogin

class GetStartedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let accessToken = AccessToken.current {
            print("\(accessToken.userID) login")
        } else {
            print("not login")
        }
    }
    
    @IBAction func logInFb(_ sender: Any) {
        let manager = LoginManager()
        manager.logIn(permissions: [.email], viewController: nil) { (result) in
            if case LoginResult.success(granted: _, declined: _, token: _) = result {
                print("login success")
                self.performSegue(withIdentifier: "ToNextPage", sender: sender)
            } else {
                print("login fail")
            }
        }
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ProfileTableViewController {
            controller.source = true
        }
    }

}
