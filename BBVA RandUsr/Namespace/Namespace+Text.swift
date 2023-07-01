//
//  Namespace+Text.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 28/06/23.
//

typealias Text = Namespace.Text

extension Namespace {
    
    enum Text {
        
        static let messageLoginError = "Invalid username and/or password: You did not provide a valid login."
        
        static let username = "Username"
        
        static let password = "Password"
        
        static let login = "Login"
        
        static let logout = "Logout"
        
        static let error = "Error"
        
        static let errorEmptyUser = "User can not empty"
        
        static let errorEmptyPassword = "Password can not empty"
        
        static let wait = "Loading, please wait"
        
        static let localizable = "Localizable"
        
        static let listUsers = "List users"
        
        static let age = "Age"
        
        static let years = "Years"
        
        static let whatDo =  "What do you want to do?"
        
        static let cancel = "Cancel"
        
        static let acept = "Acept"

        static let actions = "Actions"
        
        static let details = "Details"
        
    }
    
}
