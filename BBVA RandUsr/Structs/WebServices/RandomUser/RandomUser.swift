//
//  RandomUser.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 29/06/23.
//

import Foundation

struct RandomUser: Codable {
    let gender: String
    let name: Name
    let email: String
    let login: Login
    let phone: String
    let cell: String
    let picture: Picture
    let nat: String
    let dob: Dob
}
