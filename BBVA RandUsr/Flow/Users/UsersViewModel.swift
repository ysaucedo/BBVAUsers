//
//  UsersViewModel.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 30/06/23.
//

import Foundation

import UIKit

final class UsersViewModel {
    
    var arrUsers: Observable<[UserDetail]> = Observable([])
    var error: Observable<String> = Observable(nil)
    var scrollActivate:Bool = false
    let service = RandomUsersService()
    weak var loaderProtocol: LoaderProtocol?
    
    func fetchUsers() {
        
        loaderProtocol?.startLoading()
        service.getRandomUsers(results: Constant.elementsPerPage) { [weak self] result in
            guard let self = self else { return }
            defer { self.loaderProtocol?.finishLoading() }
            switch result {
            case .success(response: let result):
                self.scrollActivate = false
                let users = result.results.map {
                    UserDetail(gender: $0.gender, name: $0.name, email: $0.email, phone: $0.phone, cell: $0.cell, picture: $0.picture, nat: $0.nat, age: $0.dob.age)
                }
                self.arrUsers.value?.append(contentsOf: users)
            case .failure(error: let error):
                self.error.value = error.localizedDescription
            }
        }
        
    }
    
    func getUser(at index: Int) -> UserDetail? {
        arrUsers.value?[index]
    }
    
    func instanciateDetail() -> UIViewController {
        let vc = UserDetailViewController()
        vc.modalPresentationStyle = .pageSheet
        return vc
    }

    func instanciateLoader() -> UIViewController {
        let vc = LoaderViewController()
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }
    
}
