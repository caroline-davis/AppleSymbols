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

        cell?.setIcon(iconIndex: self.viewModel.icons[indexPath.row])
        return cell ?? UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.icons[Int(indexPath.row)] == viewModel.chosenIcon {
            viewModel.scoreCount += 1
            viewModel.gameTimeLeft = 10
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
        let image = UIImage(systemName: viewModel.chosenIcon, withConfiguration: config)
        iconImageView.image = image
    }

    @objc func updateTimer() {
        viewModel.gameTimeLeft -= 1
        if viewModel.gameTimeLeft > 0 {
            subtitleLabel.text = "Time: \(String(viewModel.gameTimeLeft))"
        } else {
            subtitleLabel.text = "Restart"
            // add restart button
            viewModel.isTimerActive = false
            viewModel.timer.invalidate()
            scoreLabel.text = "Game Over! You got \(viewModel.scoreCount)"
        }
        scoreLabel.text = "\(viewModel.scoreCount)"
    }

    // to do:
    // if symbols match change the icon
    // icons.randomElement() ?? "suit.heart.fill"
    // add the restart button



}

