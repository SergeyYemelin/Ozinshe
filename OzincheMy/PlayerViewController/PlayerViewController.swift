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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        setupPlayerView()
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

    private func loadVideo() {
        let id = videoId ?? ""

        playerView.load(withVideoId: id, playerVars: [
            "playsinline": 1,
            "autoplay": 1,
            "controls": 1,
            "modestbranding": 1
        ])
    }
}
