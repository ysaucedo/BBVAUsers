//
//  LoginViewModel.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 28/06/23.
//

import UIKit

final class LoginViewModel {
    
    var user: Observable<User> = Observable(nil)
    var error: Observable<String> = Observable(nil)
    
    let service = RandomUsersService()
    weak var loaderProtocol: LoaderProtocol?
    
    func fetchUser() {
        loaderProtocol?.startLoading()
        service.getRandomUsers(results: Constant.oneElement) { [weak self] result in
            guard let self = self else { return }
            defer { self.loaderProtocol?.finishLoading() }
            switch result {
            case .success(response: let result):
                self.user.value = result.results.first.map {
                    User(name: $0.name,  email: $0.email, login: $0.login)
                }
                print("username: \(self.user.value?.login.username ?? "") password: \(self.user.value?.login.password ?? "")")
            case .failure(error: let error):
                self.user.value = nil
                self.error.value = error.localizedDescription
            }
        }
    }
    
    func login(user: String , password: String, completion: @escaping RequestCompletion<LoginResponse>) {
        
        Timer.scheduledTimer(withTimeInterval: 0.75, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            if self.validateUser(user: user, password: password) {
                
                let defaults = UserDefaults.standard
                defaults.set(user, forKey: Constant.userNameKey)
                
                let data = """
                {
                    "success": true
                }
                """.data(using: .utf8)!
                if let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                    completion(.success(response: loginResponse))
                }
            } else {
                completion(.failure(error: NSError(domain: NSLocalizedString(Text.messageLoginError, comment:Text.localizable), code: 404)))
            }
        }

    }
    
    private func validateUser(user: String, password: String) -> Bool {
        if let usr = self.user.value  {
            return (usr.login.username == user && usr.login.password == password) ? true : false
        }
        return false
    }
    
    func instanciateLoader() -> UIViewController {
        let vc = LoaderViewController()
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
    
    func instanciateUsers() -> UIViewController {
        //let vc = MoviesViewController()
        let vc = UsersViewController()
        vc.modalPresentationStyle = .automatic
        return vc
    }
    
}
