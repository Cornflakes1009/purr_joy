//
//  TagCell.swift
//  purr_joy
//
//  Created by HaroldDavidson on 4/2/22.
//

import UIKit

class TagCell: UITableViewCell {
    var cellView = UIView()
    var tagLabel = UILabel()
    
    // MARK: - Initializing the Cell
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCellView()
        configureTagLabel()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Up Views
    fileprivate func configureCellView() {
        addSubview(cellView)
        cellView.layer.cornerRadius = 10
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.backgroundColor = .white
        
        cellView.layer.shadowColor = UIColor.black.cgColor
        cellView.layer.shadowRadius = 5.0
        cellView.layer.shadowOpacity = 2.0
        cellView.layer.shadowOffset = CGSize(width: 0, height: 6)
        cellView.layer.masksToBounds = false

        cellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        cellView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        cellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
    }
    
    fileprivate func configureTagLabel() {
        cellView.addSubview(tagLabel)
        tagLabel.lineBreakMode = .byWordWrapping
        tagLabel.numberOfLines = 0
        tagLabel.textAlignment = .left
        
//        tagLabel.layer.shadowRadius = 3.0
//        tagLabel.layer.shadowOpacity = 1.0
//        tagLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
//        tagLabel.layer.masksToBounds = false

        tagLabel.translatesAutoresizingMaskIntoConstraints = false
        tagLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor).isActive = true
        tagLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor).isActive = true
        tagLabel.leadingAnchor.constraint(equalTo: cellView.leadingAnchor, constant: 20).isActive = true
        tagLabel.trailingAnchor.constraint(equalTo: cellView.trailingAnchor, constant: -20).isActive = true
    }
}
