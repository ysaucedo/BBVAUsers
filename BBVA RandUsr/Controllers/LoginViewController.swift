//
//  LoginViewController.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 28/06/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    var login: LoginView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        viewModel.fetchUser()
        hideKeyboardWhenTappedAround()
        login.loginProtocol = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.75, delay: 0.0) {
            self.login.widthConstraint.constant = self.login.frame.width
            self.login.heightConstraint.constant = self.login.frame.height
            self.view.layoutIfNeeded()
        } completion: { _ in
            UIView.animate(withDuration: 1.75, delay: 0.0) {
                self.login.backgroundImageView.alpha = 0.0
            }  completion: { _ in
                self.login.userAnimationView?.play()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        login.userNameTxt.text = Constant.emptyString
        login.passwordTxt.text = Constant.emptyString
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupBinding() {
        viewModel.user.bindTo { [weak self] _ in
            if self?.viewModel.user.value != nil {
                DispatchQueue.main.async {
                    self?.login.loginBtn.isEnabled = true
                }
            }
        }
        viewModel.error.bindTo { [weak self] _ in
            if self?.viewModel.error.value != nil {
                DispatchQueue.main.async {
                    if let msgError = self?.viewModel.error.value {
                        let alert = UIAlertController(title: "Error", message: msgError, preferredStyle: .alert)
                        self?.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    private func setupUI() {
                
        login = LoginView()
        login.backgroundColor = .blue
        self.view.addSubview(login)
        login.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            login.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            login.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            login.topAnchor.constraint(equalTo: view.topAnchor),
            login.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }

}

extension LoginViewController: LoginProtocol {
    func loginPressed(user: String, password: String) {
        let vc = viewModel.instanciateLoader()
        present(vc, animated: false, completion: nil)
        viewModel.login(user: user, password: password, completion: { [weak self] result in
            guard let self = self else { return }
            defer { vc.dismiss(animated: false) }
            switch result {
            case .success(response: _):
                self.login.setErrorLabel(error: Constant.emptyString)
                let vc = self.viewModel.instanciateUsers()
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(error: let error):
                vc.dismiss(animated: false)
                let alert = UIAlertController(title: NSLocalizedString(Text.error, comment: Text.localizable), message: NSLocalizedString(error.domain, comment:Text.localizable), preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString(Text.acept, comment:Text.localizable), style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
}

extension LoginViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:    #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
