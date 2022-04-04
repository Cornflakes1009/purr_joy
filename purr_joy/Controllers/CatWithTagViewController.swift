//
//  CatWithTagViewController.swift
//  purr_joy
//
//  Created by HaroldDavidson on 4/2/22.
//
// VC showing the tag of the cat and an image using that tag
//
// The blank, #Christmascat, and 3 tags don't always show cats. When this happens, I check the URL of the call and I get a 404 on Cataas as well. This doesn't always happen though?

import UIKit

class CatWithTagViewController: UIViewController {

    var catTag = ""
    let receivedCatTag = Notification.Name(rawValue: receivedCatWithTagNotificationKey)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = titleLabelFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let catImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        return image
    }()
    
    // MARK: - Lifecycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObservers()
        setupViews()
        
        catTag = verifyTag(tag: catTag)
        
        getCat(from: "https://cataas.com/cat/\(catTag)?json=true", with: receivedCatWithTagNotificationKey)
    }
    
    // MARK: - Notification Center
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(CatWithTagViewController.updateCatImage(notification:)), name: receivedCatTag, object: nil)
    }
    
    @objc func updateCatImage(notification: NSNotification) {
        if cat.id != "" {
            setImage(url: "https://cataas.com/cat?id=\(cat.id)", imageView: catImageView)
        } else {
            catImageView.image = UIImage(named: "cat_not_found")
        }
    }
    
    // MARK: - Setting Up Views
    private func setupViews() {
        view.backgroundColor = .systemPink
        
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
        
        titleLabel.text = "{\(catTag)}"
        
        view.addSubview(catImageView)
        NSLayoutConstraint.activate([
            catImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            catImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            catImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            catImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    // handling tags with spaces
    private func verifyTag(tag: String) -> String {
        var newTag = ""
        for char in tag {
            if char == " " {
                newTag += "%20"
            } else {
                newTag += String(char)
            }
        }
        return newTag
    }
}
