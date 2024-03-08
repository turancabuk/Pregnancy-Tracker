//
//  UIOnboardingHelper.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 8.03.2024.
//

import UIKit
import UIOnboarding

struct UIOnboardingHelper {
    
    static func setupIcon() -> UIImage {
        return Bundle.main.appIcon ?? .init(named: "AppIcon")!
    }
    static func setupFirstTitleLine() -> NSMutableAttributedString {
        .init(string: "Wellcome to Pregnancy Tracker", attributes: [.foregroundColor: UIColor.label])
    }
    static func setupSecondTitleLine() -> NSMutableAttributedString {
        .init(string: Bundle.main.displayName ?? "Pregnancy Tracker", attributes: [
            .foregroundColor: UIColor.init(named: "camou") ?? UIColor.init(red: 0.654, green: 0.618, blue: 0.494, alpha: 1.0)
        ])
    }
    static func setUpFeatures() -> Array<UIOnboardingFeature> {
        return .init([
            .init(icon: .init(named: "onboarding1")!,
                  title: "Deneme Deneme Deneme",
                  description: "Deneme Deneme Deneme"),
            .init(icon: .init(named: "onboarding1")!,
                  title: "Deneme Deneme Deneme",
                  description: "Deneme Deneme Deneme"),
            .init(icon: .init(named: "onboarding1")!,
                  title: "Deneme Deneme Deneme",
                  description: "Deneme Deneme Deneme")
        ])
    }
    static func setUpButton() -> UIOnboardingButtonConfiguration {
        return .init(title: "Contunie",
                     titleColor: .white,
                     backgroundColor: .init(named: "camou")!)
    }
}
extension UIOnboardingViewConfiguration {
    static func setUp() -> UIOnboardingViewConfiguration {
        return .init(appIcon: UIOnboardingHelper.setupIcon(),
                     firstTitleLine: UIOnboardingHelper.setupFirstTitleLine(),
                     secondTitleLine: UIOnboardingHelper.setupSecondTitleLine(),
                     features: UIOnboardingHelper.setUpFeatures(),
                     buttonConfiguration: UIOnboardingHelper.setUpButton())
    }
}
