//
//  ViewController.swift
//  Apple-Symbols
//
//  Created by Caroline Davis on 9/1/2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var instructionsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var symbolImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!

    let vm = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        runTimer()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vm.icons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: vm.reuseIdentifier, for: indexPath as IndexPath) as? IconCollectionViewCell
        cell?.setIcon(iconIndex: self.vm.icons[indexPath.row], variableValue: 0.5)
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if vm.gameTimeLeft != 0 && vm.icons[Int(indexPath.row)] == vm.chosenIcon {
            vm.scoreCount += 1
            vm.gameTimeLeft = 7
            vm.timer.invalidate()
            runTimer()
        }
    }

    func runTimer() {
        setIcon()
        vm.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }

    func setSymbol(value: Double, symbol: String, imageView: UIImageView) {
        let config = UIImage.SymbolConfiguration.preferringMulticolor()
        if #available(iOS 16.0, *) {
            imageView.image = UIImage(systemName: symbol, variableValue: value, configuration: config)
        } else {
            // Fallback on earlier versions
            imageView.image = UIImage(systemName: symbol)
        }
    }

    func setIcon() {
        vm.chosenIcon = vm.icons.randomElement() ?? vm.heart
        setSymbol(value: 0.5, symbol: vm.chosenIcon, imageView: iconImageView)
    }

    @objc func updateTimer() {
        vm.gameTimeLeft -= 1

        // Changes the alarms look when the time changes
        vm.gameTimeLeft > 5 ? setSymbol(value: 1.0, symbol: vm.alarm, imageView: symbolImageView) :
        vm.gameTimeLeft <= 5 && vm.gameTimeLeft > 2 ? setSymbol(value: 0.5, symbol: vm.alarm, imageView: symbolImageView) : setSymbol(value: 0.0, symbol: vm.alarm, imageView: symbolImageView)

        if vm.gameTimeLeft > 0 {
            subtitleLabel.text = "Time: \(String(vm.gameTimeLeft))"
        } else {
            // Adds gesture to label to restart game
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapFunction))
            subtitleLabel.isUserInteractionEnabled = true
            subtitleLabel.addGestureRecognizer(tap)
            subtitleLabel.text = "Restart"
            vm.timer.invalidate()
        }
        scoreLabel.text = "Score: \(vm.scoreCount)"
    }

    @IBAction func tapFunction(sender: UITapGestureRecognizer) {
        vm.gameTimeLeft = 7
        vm.scoreCount = 0
        runTimer()
    }

}
