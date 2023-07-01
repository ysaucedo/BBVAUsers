//
//  UILabel+.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 28/06/23.
//

import UIKit

public enum LabelStyle {
    case error
    case normal
    case description
    case title
    case subtitle
    case small
    case name
}

extension UILabel {
    
    convenience init(styleType: LabelStyle) {
        self.init()
        
        switch styleType {
        case .error:
            self.numberOfLines = 0
            self.textAlignment = .center
            self.textColor = UIColor(red: 225.0/255.0, green: 77.0/255.0, blue: 37.0/255.0, alpha: 1.0)
            self.font = self.font.withSize(Size.fontMedium)
        case .small:
            self.textColor = .systemGreen
            self.font = UIFont.boldSystemFont(ofSize: Size.fontExtraSmall)
        case .normal:
            self.textColor = .white
            self.font = UIFont.boldSystemFont(ofSize: Size.fontMedium)
        case .name:
            self.textColor = .lightGray
            self.font = UIFont.boldSystemFont(ofSize: Size.fontRegular)
            self.textAlignment = .center
        case .description:
            self.textColor = .white
            self.font = self.font.withSize(Size.fontSmall)
        case .title:
            self.textColor = .systemGreen
            self.font = UIFont.boldSystemFont(ofSize: Size.fontExtraLarge)
        case .subtitle:
            self.textColor = .systemGreen
            self.font = UIFont.boldSystemFont(ofSize: Size.fontLarge)
        }
        
    }
    
}
