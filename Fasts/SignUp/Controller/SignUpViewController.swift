//
//  SignUpViewController.swift
//  Fasts
//
//  Created by evpes on 05.01.2022.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    let signUpView = SignUpView()
    
    override func loadView() {
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        signUpView.passwordTextField.delegate = self
        signUpView.emailTextField.delegate = self
        
        
        signUpView.backToLogIn.addTarget(self, action: #selector(goToLogIn), for: .touchUpInside)
        signUpView.signUpButton.addTarget(self, action: #selector(signUpButoonPressed), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func goToLogIn() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func signUpButoonPressed() {
        if let email = signUpView.emailTextField.text, let password = signUpView.passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
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
