//
//  OnboardingMovieViewController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 21.05.2024.
//

import UIKit
import AVKit


protocol OnboardingMovieVieControllerDelegate: AnyObject {
    func handleCancel()
}

class OnboardingMovieViewController: UIViewController {
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    var playerObserver: Any?
    weak var delegate: OnboardingMovieVieControllerDelegate?

    private func createCustomView(viewColor: UIColor) -> UIView {
        let view = UIView()
        view.backgroundColor = viewColor
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    lazy var uniqueView = createCustomView(viewColor: #colorLiteral(red: 0.938759625, green: 0.8843975663, blue: 0.8854001164, alpha: 1))
    lazy var containerView = createCustomView(viewColor: .white)
    
    lazy var startButton: UIButton = {
        let button = UIComponentsFactory.createCustomButton(title: "", state: .normal, titleColor: .black, borderColor: .clear, borderWidth: 2.0, cornerRadius: 12, clipsToBounds: true, action: handleCancel)
        button.isHidden = true
        button.setImage(UIImage(named: "start"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupLayout()
        playVideo()
    }
    private func playVideo() {
        guard let filePath = Bundle.main.path(forResource: "onboarding", ofType: "mp4") else {
            print("Video file not found")
            return
        }
        let fileURL = URL(fileURLWithPath: filePath)

        player = AVPlayer(url: fileURL)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.frame = self.containerView.bounds
        playerLayer?.videoGravity = .resizeAspectFill

        if let playerLayer = playerLayer {
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
        if let playerObserver = playerObserver {
            NotificationCenter.default.removeObserver(playerObserver)
        }
    }

    func handleCancel() {
        delegate?.handleCancel()
        dismiss(animated: true)
    }
}

extension OnboardingMovieViewController {
    fileprivate func setupLayout() {
        self.view.backgroundColor = .clear
        view.addSubview(uniqueView)
        uniqueView.addSubview(containerView)
        view.addSubview(startButton)

        NSLayoutConstraint.activate([
            uniqueView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 4/5),
            uniqueView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 4/5),
            uniqueView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            uniqueView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),

            containerView.topAnchor.constraint(equalTo: uniqueView.topAnchor, constant: 4),
            containerView.bottomAnchor.constraint(equalTo: uniqueView.bottomAnchor, constant: -4),
            containerView.leadingAnchor.constraint(equalTo: uniqueView.leadingAnchor, constant: 4),
            containerView.trailingAnchor.constraint(equalTo: uniqueView.trailingAnchor, constant: -4),

            startButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
            startButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            startButton.heightAnchor.constraint(equalToConstant: 64),
            startButton.widthAnchor.constraint(equalToConstant: 154),
        ])
    }
}
