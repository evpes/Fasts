//
//  SignUp.swift
//  Fasts
//
//  Created by evpes on 04.01.2022.
//

import UIKit

class SignUpView: UIView {

    var logo: UIImageView!
    var title: UILabel!
    var subtittle: UILabel!
    
    var emailLabel: UILabel!
    var emailTextField: UITextField!
    
    var passLabel: UILabel!
    var passwordTextField: UITextField!
    
    var forgotPasswordButton: UIButton!
    var signUpButton: UIButton!
        
    var backToLogIn: UIButton!
    
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

        
        backToLogIn = UIButton()
        self.addSubview(backToLogIn)
        let backToLogInButtonStr = NSMutableAttributedString(string: "Back to log in",
                                                     attributes: underlineAttribites)
        backToLogIn.setAttributedTitle(backToLogInButtonStr, for: .normal)
        backToLogIn.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).offset(-32)
        }
                
        
        signUpButton = UIButton()
        signUpButton.setTitle("Sign up", for: .normal)
        signUpButton.backgroundColor = K.colors.orangeColor
        signUpButton.titleLabel?.textColor = .white
        signUpButton.layer.cornerRadius = 8
        self.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.width.equalTo(screenWidth - 64)
            make.height.equalTo(48)
            make.bottom.equalTo(backToLogIn.snp.top).offset(-40)
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
            make.bottom.equalTo(signUpButton.snp.top).offset(-24)
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
        
        passLabel = UILabel()
        self.addSubview(passLabel)
        passLabel.text = "Password"
        passLabel.textColor = .gray
        passLabel.font = UIFont.systemFont(ofSize: 16)
        passLabel.snp.makeConstraints { make in
            make.left.equalTo(self.snp.left).offset(48)
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
            make.bottom.equalTo(passLabel.snp.top).offset(-16)
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
