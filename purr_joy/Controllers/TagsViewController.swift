//
//  TagsViewController.swift
//  purr_joy
//
//  Created by HaroldDavidson on 4/2/22.
//
// table view of all available tags

import UIKit

class TagsViewController: UIViewController {
    
    let receivedTags = Notification.Name(rawValue: receivedTagsNotificationKey)

    private let backgroundView: UIImageView = {
        let image = UIImageView()
        image.image = backgroundImage
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let tagsTable = UITableView()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        addObservers()
        getTags(from: "https://cataas.com/api/tags")
    }
    
    // MARK: - Setting Up Views
    private func setupViews() {
        view.addSubview(backgroundView)
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        configureTableView()
    }
    
    private func configureTableView() {
        tagsTable.delegate = self
        tagsTable.dataSource = self
        tagsTable.translatesAutoresizingMaskIntoConstraints = false
        tagsTable.register(TagCell.self, forCellReuseIdentifier: "TagCell")
        tagsTable.rowHeight = 50
        tagsTable.backgroundColor = .none
        
        view.addSubview(tagsTable)
        NSLayoutConstraint.activate([
            tagsTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            tagsTable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            tagsTable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            tagsTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    // MARK: - Notification Center
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(TagsViewController.updateTags(notification:)), name: receivedTags, object: nil)
    }
    
    @objc func updateTags(notification: NSNotification) {
        print(tags)
        tagsTable.reloadData()
    }
}

extension TagsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell") as! TagCell
        cell.tagLabel.text = tags[indexPath.row]
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CatTagViewController()
        vc.catTag = tags[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
