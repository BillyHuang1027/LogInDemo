//
//  HomePageViewController.swift
//  LogIn
//
//  Created by 黃昌齊 on 2021/6/25.
//

import UIKit

class HomePageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getStartedButton(_ sender: Any) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "GetStartedViewController") else { return }
        if let sheet = controller.presentationController as? UISheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func unwindToHomePageViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
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
