//
//  LogInView.swift
//  Fasts
//
//  Created by evpes on 04.01.2022.
//

import UIKit

class LogInView: UIView {

    var logo: UIImageView!
    var subtittle: UILabel!
    
    var emailLabel: UILabel!
    var emailTextField: UITextField!
    
    var passwordLabel: UILabel!
    var passwordTextField: UITextField!
    
    var forgotPasswordButton: UIButton!
    var logInButton: UIButton!
    
    var continueLabel: UILabel!
    
    var googleButton: UIButton!
    var appleButton: UIButton!
    var facebookButton: UIButton!
    
    var createAccountButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createSubviews()
    }
    
    let screenWidth = UIScreen.main.bounds.width
    
    func createSubviews() {
        
        self.backgroundColor = .white
        
        let underlineAttribites: [NSAttributedString.Key : Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.lightGray,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        createAccountButton = UIButton()
        self.addSubview(createAccountButton)
        let createAccountButtonStr = NSMutableAttributedString(string: "Create account with e-mail",
                                                     attributes: underlineAttribites)
        createAccountButton.setAttributedTitle(createAccountButtonStr, for: .normal)
        createAccountButton.snp.makeConstraints { make in
            make.width.equalTo(screenWidth - 64)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-32)
            make.height.equalTo(16)
        }
        
        //auth buttons
        
        let authButtonsWidth = (screenWidth - 128) / 3
        
        googleButton = UIButton()
        googleButton.layer.cornerRadius = 8
        googleButton.layer.borderWidth = 2
        googleButton.layer.borderColor = K.colors.orangeColor.cgColor
        googleButton.setImage(UIImage(named: "googleIcon"), for: .normal)
        self.addSubview(googleButton)
        googleButton.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(32)
            make.bottom.equalTo(createAccountButton.snp.top).offset(-24)
            make.width.equalTo(authButtonsWidth)
            make.height.equalTo(48)
        }
        
        appleButton = UIButton()
        appleButton.layer.cornerRadius = 8
        appleButton.layer.borderWidth = 2
        appleButton.layer.borderColor = K.colors.orangeColor.cgColor
        appleButton.setImage(UIImage(named: "appleIcon"), for: .normal)
        self.addSubview(appleButton)
        appleButton.snp.makeConstraints { make in
            make.left.equalTo(googleButton.snp.right).offset(32)
            make.bottom.equalTo(createAccountButton.snp.top).offset(-24)
            make.width.equalTo(authButtonsWidth)
            make.height.equalTo(48)
        }
        
        facebookButton = UIButton()
        facebookButton.layer.cornerRadius = 8
        facebookButton.layer.borderWidth = 2
        facebookButton.layer.borderColor = K.colors.orangeColor.cgColor
        facebookButton.setImage(UIImage(named: "facebookIcon"), for: .normal)
        self.addSubview(facebookButton)
        facebookButton.snp.makeConstraints { make in
            make.left.equalTo(appleButton.snp.right).offset(32)
            make.bottom.equalTo(createAccountButton.snp.top).offset(-24)
            make.width.equalTo(authButtonsWidth)
            make.height.equalTo(48)
        }
        
        continueLabel = UILabel()
        continueLabel.text = "Or continue with"
        continueLabel.font = UIFont.systemFont(ofSize: 14)
        continueLabel.textColor = .lightGray
        self.addSubview(continueLabel)
        continueLabel.snp.makeConstraints { make in
            make.bottom.equalTo(googleButton.snp.top).offset(-24)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        logInButton = UIButton()
        logInButton.setTitle("Log in", for: .normal)
        logInButton.backgroundColor = K.colors.orangeColor
        logInButton.titleLabel?.textColor = .white
        logInButton.layer.cornerRadius = 8
        self.addSubview(logInButton)
        logInButton.snp.makeConstraints { make in
            make.width.equalTo(screenWidth - 64)
            make.height.equalTo(48)
            make.bottom.equalTo(continueLabel.snp.top).offset(-40)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        forgotPasswordButton = UIButton()
        let forgotPasswordButtonStr = NSMutableAttributedString(string: "Forgot password?",
                                                     attributes: underlineAttribites)
        forgotPasswordButton.setAttributedTitle(forgotPasswordButtonStr, for: .normal)
        self.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { make in
            make.width.equalTo(screenWidth - 64)
            make.height.equalTo(16)
            make.bottom.equalTo(logInButton.snp.top).offset(-24)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        passwordTextField = UITextField()
        passwordTextField.placeholder = "Enter your password"
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        self.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.width.equalTo(screenWidth - 64)
            make.height.equalTo(48)
            make.bottom.equalTo(forgotPasswordButton.snp.top).offset(-24)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        passwordLabel = UILabel()
        passwordLabel.text = "Password"
        passwordLabel.textColor = .gray
        passwordLabel.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { make in
            
            make.left.equalTo(self).offset(48)
            make.bottom.equalTo(passwordTextField.snp.top).offset(-8)
        }
        
        emailTextField = UITextField()
        emailTextField.placeholder = "Enter your e-mail"
        emailTextField.borderStyle = .roundedRect
        emailTextField.layer.borderWidth = 2
        emailTextField.layer.cornerRadius = 8
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.autocapitalizationType = .none
        self.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.width.equalTo(screenWidth - 64)
            make.height.equalTo(48)
            make.bottom.equalTo(passwordLabel.snp.top).offset(-16)
            make.centerX.equalTo(self.snp.centerX)
        }
        
        emailLabel = UILabel()
        emailLabel.text = "E-mail"
        emailLabel.textColor = .gray
        emailLabel.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.left.equalTo(self.snp.left).offset(48)
            make.bottom.equalTo(emailTextField.snp.top).offset(-8)
        }
        
        subtittle = UILabel()
        subtittle.text = "Log into your account or register"
        subtittle.textColor = K.colors.lightOrangeColor
        self.addSubview(subtittle)
        subtittle.snp.makeConstraints { make in
            make.bottom.equalTo(emailLabel.snp.top).offset(-48)
            make.left.equalTo(self.snp.left).offset(33)
        }
        
        logo = UIImageView()
        logo.image = UIImage(named: "logo")
        self.addSubview(logo)
        logo.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(32)
            make.bottom.equalTo(subtittle.snp.top).offset(-20)
            make.width.equalTo(164)
            make.height.equalTo(52)
        }
        

        
    }
}
