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
    @IBOutlet weak var collectionView: UICollectionView!

    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        runTimer()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.icons.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.reuseIdentifier, for: indexPath as IndexPath) as? IconCollectionViewCell

        cell?.setIcon(iconIndex: self.viewModel.icons[indexPath.row], variableValue: 0.5)
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.gameTimeLeft != 0 && viewModel.icons[Int(indexPath.row)] == viewModel.chosenIcon {
            viewModel.scoreCount += 1
            viewModel.gameTimeLeft = 7
            viewModel.timer.invalidate()
            runTimer()
        }
    }

    func runTimer() {
        setIcon()
        viewModel.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }

    func setIcon() {
        viewModel.chosenIcon = viewModel.icons.randomElement() ?? "suit.heart.fill"
        let config = UIImage.SymbolConfiguration.preferringMulticolor()
        if #available(iOS 16.0, *) {
            let image = UIImage(systemName: viewModel.chosenIcon, variableValue: 0.5, configuration: config)
            iconImageView.image = image
        } else {
            // Fallback on earlier versions
            let image = UIImage(systemName: viewModel.chosenIcon, withConfiguration: config)
            iconImageView.image = image
        }

    }

    @objc func updateTimer() {
        viewModel.gameTimeLeft -= 1
        if viewModel.gameTimeLeft > 0 {
            subtitleLabel.text = "Time: \(String(viewModel.gameTimeLeft))"
        } else {
            // adds gesture to label to restart game
            let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapFunction))
                    subtitleLabel.isUserInteractionEnabled = true
                    subtitleLabel.addGestureRecognizer(tap)
            subtitleLabel.text = "Restart"
            // arrow.triangle.2.circlepath.circle
            viewModel.isTimerActive = false
            viewModel.timer.invalidate()
            scoreLabel.text = "Game Over! You got \(viewModel.scoreCount)"
        }
        scoreLabel.text = "Score: \(viewModel.scoreCount)"
    }

    @IBAction func tapFunction(sender: UITapGestureRecognizer) {
        viewModel.gameTimeLeft = 7
        viewModel.scoreCount = 0
        updateTimer()
    }

}
