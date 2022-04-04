//
//  FavoriteCell.swift
//  purr_joy
//
//  Created by HaroldDavidson on 4/3/22.
//

import UIKit

class FavoriteCell: UITableViewCell {

    var favoriteImage = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(favoriteImage)
        configureFavoriteImage()
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureFavoriteImage() {
        favoriteImage.backgroundColor                                                             =   .clear
        favoriteImage.contentMode                                                                 =   .scaleAspectFill
        favoriteImage.translatesAutoresizingMaskIntoConstraints                                   =   false
        favoriteImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive           =   true
        favoriteImage.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive             =   true
        favoriteImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive      =   true
        favoriteImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive        =   true
    }
}
