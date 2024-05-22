//
//  OnboardingMoviewViewController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 21.05.2024.
//


import UIKit
import Foundation
import AVKit
import FirebaseStorage

protocol OnboardingMoviewViewControllerDelegate: AnyObject {
    func handleCancel()
}
class OnboardingMoviewViewController: UIViewController {
    

    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var playerObserver: Any?
    weak var delegate: OnboardingMoviewViewControllerDelegate?
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var startButton: UIButton = {
     let button =  UIComponentsFactory.createCustomButton(title: "", state: .normal, titleColor: .black, borderColor: .clear, borderWidth: 2.0, cornerRadius: 12, clipsToBounds: true, action: handleSkip)
        button.isHidden = true
        button.setImage(UIImage(named: "start"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        fetchVideo()
        
    }
    private func fetchVideo() {
        DispatchQueue.global(qos: .background).async {
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let videoRef = storageRef.child("onboarding/onboarding1.mp4")
            
            videoRef.downloadURL { url, error in
                if let error {
                    print("yoga video fetch error: \(error)")
                    return
                }
                guard let url = url else {
                    print("video URL is nil")
                    return
                }
                DispatchQueue.main.async {
                    self.playVideo(url: url)
                }
            }
        }
    }
    private func playVideo(url: URL) {
 
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = self.containerView.bounds
        playerLayer?.videoGravity = .resizeAspectFill
        
        if let playerLayer {
            self.containerView.layer.addSublayer(playerLayer)
        }
        player?.play()
        
        playerObserver = NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: .main) { [weak self] _ in
            self?.startButton.isHidden = false
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = self.containerView.bounds
    }
    deinit {
        if let playerObserver {
            NotificationCenter.default.removeObserver(playerObserver)
        }
    }
    @objc fileprivate func handleSkip() {
        dismiss(animated: true)
        handleCancel()
    }
    func handleCancel() {
        dismiss(animated: true)
        delegate?.handleCancel()
    }
}
extension OnboardingMoviewViewController {
    fileprivate func setupLayout() {
        
        self.view.backgroundColor = .clear
        view.addSubview(containerView)
        view.addSubview(startButton)
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 4/5),
            containerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 4/5),
            containerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            
            startButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            startButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            startButton.heightAnchor.constraint(equalToConstant: 64),
            startButton.widthAnchor.constraint(equalToConstant: 154),
        ])
    }
}


