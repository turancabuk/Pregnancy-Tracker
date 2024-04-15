//
//  OnboardingController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 8.03.2024.
//

import UIKit
import UIOnboarding

class OnboardingController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        presentOnboarding()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isFirstLaunch = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
        
        if isFirstLaunch {
            UserDefaults.standard.setValue(true, forKey: "hasLaunchedBefore")
            UserDefaults.standard.synchronize()
            
            self.showPersonalInfoView()
        }
    }
    fileprivate func showPersonalInfoView() {

        let personalInfoView = PersonalInformationView()
        personalInfoView.modalPresentationStyle = .fullScreen
        self.present(personalInfoView, animated: true, completion: nil)
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
extension OnboardingController: UIOnboardingViewControllerDelegate {
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
