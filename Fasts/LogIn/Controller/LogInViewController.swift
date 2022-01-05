//
//  LogInViewController.swift
//  Fasts
//
//  Created by evpes on 04.01.2022.
//

import UIKit
import Firebase

class LogInViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    var logInView = LogInView()
    
    override func loadView() {
        view = logInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInView.passwordTextField.delegate = self
        logInView.emailTextField.delegate = self
        
        logInView.createAccountButton.addTarget(self, action: #selector(goToSignUp), for: .touchUpInside)
        logInView.logInButton.addTarget(self, action: #selector(logInButtonPressed), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    @objc func goToSignUp() {
        let signUpVC = SignUpViewController()
        self.navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func logInButtonPressed() {
        if let email = logInView.emailTextField.text, let password = logInView.passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                guard self != nil else { return }
                if let error = error {
                    let ac = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(ac, animated: true, completion: nil)
                } else {
                    let mainVC = TabBar()
                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainVC, animated: true)

                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    
}
