//
//  UserCollectionViewCell.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 30/06/23.
//

import UIKit
import Kingfisher

class UserCollectionViewCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var nameLbl: UILabel!
    var phoneLbl: UILabel!
    var ageLbl: UILabel!
    var ageValueLbl: UILabel!
    var phoneImageView: UIImageView!
    var mailLbl: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = Size.cornerRadiusPoster
        
        self.backgroundColor = Color.secondary100
        
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Size.cornerRadiusPoster
        imageView.contentMode = .scaleAspectFill
        imageView.image = Image.login
        self.addSubview(imageView)
        
        nameLbl = UILabel(styleType: .name)
        self.addSubview(nameLbl)

        phoneLbl = UILabel(styleType: .normal)
        self.addSubview(phoneLbl)
        
        ageLbl = UILabel(styleType: .normal)
        ageLbl.text =  NSLocalizedString(Text.age, comment:Text.localizable)
        ageLbl.textColor = .systemGreen
        self.addSubview(ageLbl)
        
        ageValueLbl = UILabel(styleType: .normal)
        self.addSubview(ageValueLbl)
        
        let configuration = UIImage.SymbolConfiguration(pointSize: Size.fontSmall)
        phoneImageView = UIImageView()
        phoneImageView.image = Image.phone?.withConfiguration(configuration).withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        self.addSubview(phoneImageView)
        
        mailLbl = UILabel(styleType: .description)
        mailLbl.numberOfLines = 0
        self.addSubview(mailLbl)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        phoneLbl.translatesAutoresizingMaskIntoConstraints = false
        ageLbl.translatesAutoresizingMaskIntoConstraints = false
        ageValueLbl.translatesAutoresizingMaskIntoConstraints = false
        phoneImageView.translatesAutoresizingMaskIntoConstraints = false
        mailLbl.translatesAutoresizingMaskIntoConstraints = false
        
        
        let margins = self.layoutMarginsGuide
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: Size.posterRelation),
            
            nameLbl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Size.spaceElement),
            nameLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            nameLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            phoneImageView.leadingAnchor.constraint(equalTo:  margins.leadingAnchor),
            phoneImageView.centerYAnchor.constraint(equalTo: phoneLbl.centerYAnchor),
            
            phoneLbl.topAnchor.constraint(equalTo: nameLbl.bottomAnchor, constant: Size.spaceElementMedium),
            phoneLbl.leadingAnchor.constraint(equalTo: phoneImageView.trailingAnchor, constant: Size.spaceElement),
            
            ageLbl.topAnchor.constraint(equalTo: phoneLbl.bottomAnchor, constant: Size.spaceElementMedium),
            ageLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor),

            ageValueLbl.topAnchor.constraint(equalTo: phoneLbl.bottomAnchor, constant: Size.spaceElementMedium),
            ageValueLbl.leadingAnchor.constraint(equalTo: ageLbl.trailingAnchor, constant: Size.spaceElement),
            
            mailLbl.topAnchor.constraint(equalTo: ageLbl.bottomAnchor, constant: Size.spaceElementMedium),
            mailLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            mailLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            mailLbl.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -Size.spaceElementSmall)
            
        ])

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupCell(user: UserDetail) {
        nameLbl.text = "\(user.name.title) \(user.name.last)"
        phoneLbl.text = user.phone
        ageValueLbl.text = String(user.age)
        mailLbl.text = user.email
        if let url = URL(string: user.picture.large)  {
            imageView.kf.setImage(with: url)
        } else { imageView.image = Image.userDefault?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal) }
    }
    
}
