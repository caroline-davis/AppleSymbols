//
//  ViewModel.swift
//  Apple-Symbols
//
//  Created by Caroline Davis on 9/1/2023.
//

import Foundation
import UIKit

class ViewModel {

    var icons: [String]
    var chosenIcon: String

    init() {
        self.icons = iconsList
        self.chosenIcon = icons.randomElement() ?? heart
    }

    let reuseIdentifier = "cell"
    let alarm = "alarm.waves.left.and.right"
    let heart = "suit.heart.fill"
    let iconsList = ["suit.heart.fill", "house.fill", "sun.max.fill", "leaf.circle", "timer", "fork.knife.circle.fill", "ladybug.fill", "wand.and.rays", "target", "chart.dots.scatter", "timelapse", "phone.and.waveform", "shower.fill", "wifi.circle", "suitcase.rolling", "signpost.right.and.left.fill", "fish.circle.fill", "mic.and.signal.meter.fill", "mountain.2", "mug", "key.horizontal", "brain.head.profile", "calendar.badge.plus", "homekit", "minus.plus.batteryblock.exclamationmark", "handbag.fill"]

    var gameTimeLeft = 7
    var scoreCount = 0

    var timer = Timer()

}
