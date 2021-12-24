//
//  LoginViewController.swift
//  SampleFirebaseApp
//
//  Created by matthew savidge on 12/21/21.
//

import UIKit
import FirebaseAuth
import SystemConfiguration

class LoginViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let e = error{
                    self?.displayError(with: e)
                }else{
                    // perform segue to chats
                    self?.performSegue(withIdentifier: "loginToChatHomeSegue", sender: self)
                }
            }
        }
    }
    
    func displayError(with error: Error){
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
