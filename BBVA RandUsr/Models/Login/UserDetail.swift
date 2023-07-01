//
//  UserDetail.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 30/06/23.
//

import Foundation

struct UserDetail: Codable {
    let gender: String
    let name: Name
    let email: String
    let phone: String
    let cell: String
    let picture: Picture
    let nat: String
    let age: Int
}
