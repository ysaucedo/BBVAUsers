//
//  UITextField+.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 28/06/23.
//

import UIKit

extension UITextField {
    
    func formatUI() {
        self.autocapitalizationType = .none
        self.backgroundColor = .white
        self.textColor = .black
        self.layer.cornerRadius = Size.cornerRadiusText
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: Size.marginsTextField, height: self.frame.size.height))
        self.leftViewMode = .always
        self.rightView = UIView(frame: CGRect(x: 0, y: 0, width: Size.marginsTextField, height: self.frame.size.height))
        self.rightViewMode = .always
    }
    
}
