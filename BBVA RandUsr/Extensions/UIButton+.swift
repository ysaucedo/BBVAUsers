//
//  UIButton+.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 28/06/23.
//

import UIKit

extension UIButton {
    
    func formatUI() {
        self.backgroundColor = .systemGray4
        self.layer.cornerRadius = Size.cornerRadiusText
        self.tintColor = .white
    }
    
}
