//
//  UserDetailViewController.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 30/06/23.
//

import Foundation

import UIKit

class UserDetailViewController: UIViewController {
        
    var user: UserDetail!
    var backImageView: UIImageView!
    var imageView: UIImageView!
    var titleLbl: UILabel!
    var originalLanguageLbl: UILabel!
    var phoneLbl: UILabel!
    var ageLbl: UILabel!
    var phoneImageView: UIImageView!
    var mailLbl: UILabel!
    var addFavoriteBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupShow()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        backImageView.bottomCurveS()
    }
    
    func setupShow() {
        titleLbl.text = "\(user.name.title) \(user.name.first) \(user.name.last)"
        phoneLbl.text = user.phone
        originalLanguageLbl.text = user.nat
        ageLbl.text = "\(String(user.age)) \(NSLocalizedString(Text.years, comment:Text.localizable))"
        mailLbl.text = user.email
        if let url = URL(string: user.picture.large)  {
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = Image.userDefault?.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        }
        
    }
    
    private func setupUI() {
        view.backgroundColor = .blue
        
        backImageView = UIImageView()
        backImageView.alpha = 0.4
        backImageView.clipsToBounds = true
        backImageView.contentMode = .scaleAspectFill
        backImageView.image = Image.people
        view.addSubview(backImageView)
        
        imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Size.cornerRadiusPoster
        
        imageView.image = Image.login
        view.addSubview(imageView)
        
        titleLbl = UILabel(styleType: .subtitle)
        view.addSubview(titleLbl)
        
        phoneLbl = UILabel(styleType: .normal)
        view.addSubview(phoneLbl)
        
        originalLanguageLbl = UILabel(styleType: .normal)
        view.addSubview(originalLanguageLbl)
        
        ageLbl = UILabel(styleType: .normal)
        view.addSubview(ageLbl)
        
        let configuration = UIImage.SymbolConfiguration(pointSize: Size.fontSmall)
        phoneImageView = UIImageView()
        phoneImageView.image = Image.phone?.withConfiguration(configuration).withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        view.addSubview(phoneImageView)
        
        mailLbl = UILabel(styleType: .normal)
        mailLbl.numberOfLines = 0
        view.addSubview(mailLbl)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 12.0
        layout.itemSize = CGSize(width: 100.0, height: 120.0)
        layout.scrollDirection = .horizontal
        
        let videoLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        videoLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        videoLayout.minimumInteritemSpacing = 10.0
        videoLayout.minimumLineSpacing = 12.0
        videoLayout.itemSize = CGSize(width: 160.0, height: 120.0)
        videoLayout.scrollDirection = .horizontal

        backImageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        phoneLbl.translatesAutoresizingMaskIntoConstraints = false
        originalLanguageLbl.translatesAutoresizingMaskIntoConstraints = false
        ageLbl.translatesAutoresizingMaskIntoConstraints = false
        phoneImageView.translatesAutoresizingMaskIntoConstraints = false
        mailLbl.translatesAutoresizingMaskIntoConstraints = false
        
        let margins = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            
            backImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backImageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.75),
            
            imageView.bottomAnchor.constraint(equalTo: backImageView.bottomAnchor, constant: Size.spaceElementMedium),
            imageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: Size.spaceElementMedium),
            imageView.widthAnchor.constraint(equalTo: margins.widthAnchor, multiplier: 0.40),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.3),
            
            titleLbl.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Size.spaceElementLarge),
            titleLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: Size.spaceElementMedium),
            titleLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor),

            phoneImageView.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: Size.spaceElement),
            phoneImageView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: Size.spaceElementMedium),
            
            phoneLbl.leadingAnchor.constraint(equalTo: phoneImageView.trailingAnchor, constant: Size.spaceElement),
            phoneLbl.centerYAnchor.constraint(equalTo: phoneImageView.centerYAnchor),

            ageLbl.topAnchor.constraint(equalTo: titleLbl.topAnchor),
            ageLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            originalLanguageLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            originalLanguageLbl.centerYAnchor.constraint(equalTo:phoneImageView.centerYAnchor),
            
            mailLbl.topAnchor.constraint(equalTo: phoneLbl.bottomAnchor, constant: 12.0),
            mailLbl.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: Size.spaceElementMedium),
            mailLbl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
            
        ])
        
    }

}
