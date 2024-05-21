//
//  OnboardinMoviewViewController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 21.05.2024.
//

import UIKit
import Foundation
import AVFoundation

class OnboardinMoviewViewController: UIViewController {

    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        playVideo()
        
    }
    private func playVideo() {
        
        guard let path = Bundle.main.path(forResource: "movie", ofType: "mp4") else {
            print("video not found")
            return
        }
        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = self.containerView.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        
        if let playerLayer {
            self.containerView.layer.addSublayer(playerLayer)
        }
        player?.play()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = self.containerView.bounds
    }
}
extension OnboardinMoviewViewController {
    fileprivate func setupLayout() {
        
        self.view.backgroundColor = .clear
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 4/5),
            containerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 4/5),
            containerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
}
