//
//  Tags.swift
//  purr_joy
//
//  Created by HaroldDavidson on 4/2/22.
//

import Foundation

var tags = [String]()

func getTags(from url: String) {
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
        guard let data = data else { return }

        DispatchQueue.main.async {
            let data = Data(data)
            do {
                tags = try JSONSerialization.jsonObject(with: data) as! [String]
                // capitalizing the tags to help with both sorting and to save from doing it on each cell.
                tags = tags.map { $0.capitalized }
                tags = tags.sorted()
            } catch {
                print(error)
            }
            
            let name = Notification.Name(rawValue: receivedTagsNotificationKey)
            NotificationCenter.default.post(name: name, object: nil)
        }
    }
    task.resume()
}
