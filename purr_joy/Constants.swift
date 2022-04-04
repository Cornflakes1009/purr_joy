//
//  Constants.swift
//  purr_joy
//
//  Created by HaroldDavidson on 4/2/22.
//

import UIKit
import AVFoundation

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

// MARK: - Audio
let meowSound             =   URL(fileURLWithPath: Bundle.main.path(forResource: "Cat-meow-mp3", ofType: "mp3")!)
var buttonAudio             =   AVAudioPlayer()

func playMeow() {
    do {
        buttonAudio = try AVAudioPlayer(contentsOf: meowSound)
        buttonAudio.play()
    } catch {
        // couldn't load file :(
    }
}
