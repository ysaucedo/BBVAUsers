//
//  User.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 29/06/23.
//

import Foundation

struct User: Codable {
    let name: Name
    let email: String
    let login: Login
}

