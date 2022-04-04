//
//  FavoritesViewController.swift
//  purr_joy
//
//  Created by HaroldDavidson on 4/3/22.
//
//
// Showing all the favorite cats. This view has some serious performance issues. Not sure if due to slow API or something with my code. I would be very happy if the code reviewer wanted to provide feedback.

import UIKit

class FavoritesViewController: UIViewController {

    private let backgroundView: UIImageView = {
        let image = UIImageView()
        image.image = backgroundImage
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let favoritesTable = UITableView()
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        getTags(from: "https://cataas.com/api/tags")
    }
    
    // MARK: - Setting Up Views
    private func setupViews() {
        self.navigationController?.navigationBar.tintColor = .black
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
        favoritesTable.delegate = self
        favoritesTable.dataSource = self
        favoritesTable.translatesAutoresizingMaskIntoConstraints = false
        favoritesTable.register(FavoriteCell.self, forCellReuseIdentifier: "FavoriteCell")
        favoritesTable.backgroundColor = .clear
        favoritesTable.rowHeight = UITableView.automaticDimension
        favoritesTable.estimatedRowHeight = 600
        
        view.addSubview(favoritesTable)
        NSLayoutConstraint.activate([
            favoritesTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            favoritesTable.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            favoritesTable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            favoritesTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteCats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as! FavoriteCell
        setImage(url: "https://cataas.com/cat?id=\(favoriteCats[indexPath.row])", imageView: cell.favoriteImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CatWithTagViewController()
        vc.catTag = tags[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
