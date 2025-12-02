//
//  PlayerViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 17.11.2025.
//

import UIKit
import SnapKit
import youtube_ios_player_helper

class PlayerViewController: UIViewController {

    let playerView = YTPlayerView()
    var videoId: String?

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("✕", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 30, weight: .bold)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        button.layer.cornerRadius = 20
        button.clipsToBounds = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        setupPlayerView()
        setupCloseButton()
        loadVideo()
    }

    private func setupPlayerView() {
        playerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(playerView)

        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: 9.0/16.0)
        ])
    }

    private func setupCloseButton() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            closeButton.widthAnchor.constraint(equalToConstant: 40),
            closeButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc private func closeTapped() {
        dismiss(animated: true)
    }

    private func loadVideo() {
        let id = videoId ?? ""

        playerView.load(withVideoId: id, playerVars: [
            "playsinline": 1,    // inline = 1, fullscreen = 0
            "autoplay": 1,
            "controls": 1,
            "modestbranding": 1
        ])
    }
}
