//
//  CategoriesDetailVC.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 15.03.2024.
//

import UIKit
import AVKit


class CategoriesDetailVC: UIViewController {
    
    var videoURLs: [String] = []
    var currentVideoIndex = 0
    var player: AVPlayer?
    var playerViewController : AVPlayerViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupPlayer()
        
    }
    func setupPlayer() {
        guard !videoURLs.isEmpty else {return}
        playVideo(at: currentVideoIndex)
    }
    func playVideo(at index: Int) {
        guard index < videoURLs.count, let url = URL(string: videoURLs[index])  else {return}
        
        player = AVPlayer(url: url)
        playerViewController = AVPlayerViewController()
        playerViewController?.player = player
        
        if let playerVC = playerViewController {
            addChild(playerVC)
            view.addSubview(playerVC.view)
            playerVC.view.frame = view.frame
            playerVC.didMove(toParent: self)
            player?.play()
        }
    }
}
