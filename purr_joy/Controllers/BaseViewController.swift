//
//  BaseViewController.swift
//  purr_joy
//
//  Created by HaroldDavidson on 3/30/22.
//
// first VC showing an image from /cats. Can get another cat or go to a table showing all available tags

import UIKit

class BaseViewController: UIViewController {

    let url = "https://cataas.com/cat?json=true"
    let receivedCat = Notification.Name(rawValue: receivedCatNotificationKey)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "{purr joy}"
        label.font = titleLabelFont
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private let bottomLeftButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Here Kitty Kitty", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(UIColor.systemPink, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.addTarget(nil, action: #selector(hereKittyKittyTapped), for: .touchUpInside)
        return button
    }()
    
    private let bottomRightButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See All Tags", for: .normal)
        button.backgroundColor = .black
        button.setTitleColor(UIColor.systemPink, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.addTarget(nil, action: #selector(seeAllTagsTapped), for: .touchUpInside)
        return button
    }()
    
    private let catImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        // set to scaleAspectFill because I felt that the app looked better. I know this doesn't account for text on the images and can cut off important things
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        return image
    }()
    
    // MARK: - Lifecycle Method
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        addObservers()
        getData(from: url)
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
        
        view.addSubview(bottomLeftButton)
        NSLayoutConstraint.activate([
            bottomLeftButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            bottomLeftButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        view.addSubview(bottomRightButton)
        NSLayoutConstraint.activate([
            bottomRightButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            bottomRightButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            bottomRightButton.leftAnchor.constraint(equalTo: bottomLeftButton.rightAnchor, constant: 10),
            bottomRightButton.widthAnchor.constraint(equalTo: bottomLeftButton.widthAnchor, multiplier: 1.0)
        ])
        
        view.addSubview(catImageView)
        NSLayoutConstraint.activate([
            catImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            catImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            catImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            catImageView.bottomAnchor.constraint(equalTo: bottomLeftButton.topAnchor, constant: -20)
        ])
    }
    
    // MARK: - Notification Center
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(BaseViewController.updateCatImage(notification:)), name: receivedCat, object: nil)
    }
    
    @objc func updateCatImage(notification: NSNotification) {
        print(cat)
        setImage(url: "https://cataas.com/cat?id=\(cat.id)", imageView: catImageView)
    }
    
    // MARK: - Button Actions
    @objc func hereKittyKittyTapped() {
        getData(from: url)
    }
    
    @objc func seeAllTagsTapped() {
        let vc = TagsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
