//
//  OnboardingController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 8.03.2024.
//

import UIKit
import UIOnboarding

class OnboardingController: UIViewController, UIOnboardingViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @objc private func presentOnboarding() {
        let onboardingController: UIOnboardingViewController = .init(withConfiguration: .setUp())
        onboardingController.delegate = self
        navigationController?.present(onboardingController, animated: false)
    }
}
extension OnboardingController {
    private func setUp() {
        view.backgroundColor = .systemBackground
    }
}
extension OnboardingController {
    func didFinishOnboarding(onboardingViewController: UIOnboardingViewController) {
        onboardingViewController.modalTransitionStyle = .crossDissolve
        onboardingViewController.dismiss(animated: true) { [weak self] in
            guard let self = self else {return}
            
            if let navigationController = self.navigationController {
                let tabBarController = MainTabbarController()
                
                navigationController.setNavigationBarHidden(true, animated: false)
                navigationController.pushViewController(tabBarController, animated: true)
            }else{
                print("Hata: ViewController bir UINavigationController içinde değil.")
            }
        }
    }
}
