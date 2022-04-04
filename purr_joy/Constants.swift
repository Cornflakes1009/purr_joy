//
//  Constants.swift
//  purr_joy
//
//  Created by HaroldDavidson on 4/2/22.
//

import UIKit

// MARK: - Images
let backgroundImage = UIImage(named: "hello_kitty_background")

// MARK: - Fonts
let titleLabelFont = UIFont(name: "CITCAT", size: 30)

// MARK: - Notifications
let receivedCatNotificationKey          = "co.harolddavidson.receivedCat"
let receivedTagsNotificationKey         = "co.harolddavidson.receivedTags"
let receivedCatWithTagNotificationKey   = "co.harolddavidson.receivedCatWithTag"

// MARK: - Storage
let defaults   =   UserDefaults.standard
var favorites = defaults.stringArray(forKey: "favorites") ?? [String]()
var favoriteCats = favorites
