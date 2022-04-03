//
//  CatTagViewController.swift
//  purr_joy
//
//  Created by HaroldDavidson on 4/2/22.
//
// VC showing the tag of the cat and an image using that tag

import UIKit

class CatTagViewController: UIViewController {

    var catTag = ""
    let receivedCatTag = Notification.Name(rawValue: receivedCatNotificationKey)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = titleLabelFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
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
        
        getData(from: "https://cataas.com/cat/\(catTag)?json=true")
    }
    
    // MARK: - Notification Center
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(CatTagViewController.updateCatImage(notification:)), name: receivedCatTag, object: nil)
    }
    
    @objc func updateCatImage(notification: NSNotification) {
        setImage(url: "https://cataas.com/cat?id=\(cat.id)", imageView: catImageView)
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
}
