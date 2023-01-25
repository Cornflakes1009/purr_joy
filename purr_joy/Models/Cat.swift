//
//  Cat.swift
//  purr_joy
//
//  Created by HaroldDavidson on 3/30/22.
//

import UIKit

var cat = Cat(id: "", created_at: "", tags: [""], url: "")

struct Cat {
    var id: String
    var created_at: String
    var tags: [String]
    var url: String
}

func getCat(from url: String, with notification: String) {
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
        guard let data = data else { return }
        let jsonData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        let id = jsonData?["_id"] as? String ?? ""
        let created_at = jsonData?["created_at"] as? String ?? ""
        let tags = jsonData?["tags"] as? [String] ?? [""]
        let url = jsonData?["url"] as? String ?? ""
        DispatchQueue.main.async {
            cat = Cat(id: id, created_at: created_at, tags: tags, url: url)
            let name = Notification.Name(rawValue: notification)
            NotificationCenter.default.post(name: name, object: nil)
        }
    }
    task.resume()
}

func setImage(url: String, imageView: UIImageView) {
    let url: URL = URL(string: url)!
    let session = URLSession.shared
    let task = session.dataTask(with: url, completionHandler: {
        (data, response, error) in
        if data != nil {
            let image = UIImage(data: data!)
            if image != nil {
                DispatchQueue.main.async(execute: {
                    imageView.image = image
                })
            }
        }
    })
    task.resume()
}
