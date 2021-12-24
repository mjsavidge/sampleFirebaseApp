//
//  SignUpViewController.swift
//  SampleFirebaseApp
//
//  Created by matthew savidge on 12/22/21.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func signUpPressed(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error{
                    self.displayError(with: e)
                }else{
                    self.performSegue(withIdentifier: "signupToChatHomeSegue", sender: self)
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
