//
//  Namespace+Constant.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 28/06/23.
//

import Foundation

typealias Constant = Namespace.Constant

extension Namespace.Constant {
    
    static let apiURL = "https://randomuser.me/api"
    
    static let language = "en-US"
    
    static let seed = "smartstc"
    
    static let emptyString = ""
    
    static let regExpUserPass = #"(?=.{1,})"#
    
    static let userNameKey = "userNameKey"

    static let usercell = "usercell"
        
    static let oneElement = 1
    
    static let elementsPerPage = 10
    
    static let userAnimation = "users"
    
    static let battBackgroundProcessId = "com.ysh.BBVA-RandUsr.battmonitoring"

    static let batteryKey = "battmonitoring"

}
