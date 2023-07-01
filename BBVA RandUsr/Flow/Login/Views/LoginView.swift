//
//  LoginView.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 28/06/23.
//

import UIKit
import Lottie

protocol LoginProtocol: AnyObject {
    func loginPressed(user: String, password: String)
}

class LoginView: UIView {
    
    var shouldSetupConstraints = true
    
    weak var loginProtocol: LoginProtocol?

    var backgroundImageView: UIImageView!
    var userNameTxt: UITextField!
    var passwordTxt: UITextField!
    var loginBtn: UIButton!
    
    var userAnimationView: LottieAnimationView?
    
    var widthConstraint: NSLayoutConstraint!
    var heightConstraint: NSLayoutConstraint!
        
    lazy var errorLbl: UILabel! = {
        let label = UILabel(styleType: .error)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
      
    override init(frame: CGRect) {
      super.init(frame: frame)
    
        userAnimationView = .init(name: "users")
        userAnimationView?.loopMode = .loop
        userAnimationView?.animationSpeed = 0.5
        userAnimationView?.alpha = 0.3
        self.addSubview(userAnimationView!)
        
        backgroundImageView = UIImageView(image: Image.login)
        backgroundImageView.contentMode = .scaleAspectFill
        self.addSubview(backgroundImageView)
        
        widthConstraint = NSLayoutConstraint(item: backgroundImageView!, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1.0, constant: 60)
        heightConstraint = NSLayoutConstraint(item: backgroundImageView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 60)
        
        userNameTxt = UITextField()
        userNameTxt.placeholder = NSLocalizedString(Text.username, comment:Text.localizable)
        userNameTxt.formatUI()
        self.addSubview(userNameTxt)

        passwordTxt = UITextField()
        passwordTxt.placeholder = NSLocalizedString(Text.password, comment:Text.localizable)
        passwordTxt.formatUI()
        passwordTxt.textContentType = .password
        passwordTxt.isSecureTextEntry = true
        self.addSubview(passwordTxt)
        
        loginBtn = UIButton(type: .system)
        loginBtn.isEnabled = false
        loginBtn.setTitle(NSLocalizedString(Text.login, comment:Text.localizable), for: .normal)
        loginBtn.formatUI()
        loginBtn.addTarget(self, action: #selector(loginBtnPressed(_ :)), for: .touchUpInside)
        self.addSubview(loginBtn)
        
    }

    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
    }
    
    @objc func loginBtnPressed(_ sender: UIButton) {

        if userNameTxt.text!.range(of: Constant.regExpUserPass, options: .regularExpression) == nil {
            setErrorLabel(error: NSLocalizedString(Text.errorEmptyUser, comment:Text.localizable))
            return
        }
        if passwordTxt.text!.range(of: Constant.regExpUserPass, options: .regularExpression) == nil {
            setErrorLabel(error: NSLocalizedString(Text.errorEmptyPassword, comment:Text.localizable))
            return
        }
        setErrorLabel(error: Constant.emptyString)
        loginProtocol?.loginPressed(user: userNameTxt.text!, password: passwordTxt.text!)
    }
    
    public func setErrorLabel(error: String) {
        errorLbl.text = error
        self.addSubview(errorLbl)
        let margins = self.layoutMarginsGuide
        NSLayoutConstraint.activate([
            errorLbl.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 16.0),
            errorLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            errorLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
    }
      
    override func updateConstraints() {
      if(shouldSetupConstraints) {

          userAnimationView?.translatesAutoresizingMaskIntoConstraints = false
          backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
          userNameTxt.translatesAutoresizingMaskIntoConstraints = false
          passwordTxt.translatesAutoresizingMaskIntoConstraints = false
          loginBtn.translatesAutoresizingMaskIntoConstraints = false
          let margins = self.layoutMarginsGuide
          
          NSLayoutConstraint.activate([

              backgroundImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
              backgroundImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
              
              userNameTxt.centerYAnchor.constraint(equalTo: self.centerYAnchor),
              userNameTxt.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 32.0),
              userNameTxt.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -32.0),
              userNameTxt.heightAnchor.constraint(equalToConstant: 48.0),
              
              userAnimationView!.leadingAnchor.constraint(equalTo: self.leadingAnchor),
              userAnimationView!.trailingAnchor.constraint(equalTo: self.trailingAnchor),
              userAnimationView!.topAnchor.constraint(equalTo: self.topAnchor),
              userAnimationView!.bottomAnchor.constraint(equalTo: userNameTxt.topAnchor),
              
              passwordTxt.topAnchor.constraint(equalTo: userNameTxt.bottomAnchor, constant: 16.0),
              passwordTxt.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 32.0),
              passwordTxt.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -32.0),
              passwordTxt.heightAnchor.constraint(equalToConstant: 48.0),

              loginBtn.topAnchor.constraint(equalTo: passwordTxt.bottomAnchor, constant: 16.0),
              loginBtn.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 32.0),
              loginBtn.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -32.0),
              loginBtn.heightAnchor.constraint(equalToConstant: 48.0)

          ])
    
          self.addConstraints([widthConstraint, heightConstraint])

          shouldSetupConstraints = false
      }
      super.updateConstraints()
    }

}
