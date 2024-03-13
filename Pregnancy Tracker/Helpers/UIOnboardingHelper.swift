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
        .init(string: "Hoşgeldiniz ", attributes: [.foregroundColor: UIColor.label])
    }
    static func setupSecondTitleLine() -> NSMutableAttributedString {
        .init(string: Bundle.main.displayName ?? "Pregnancy Tracker", attributes: [
            .foregroundColor: UIColor.init(named: "camou") ?? UIColor.init(red: 0.654, green: 0.618, blue: 0.494, alpha: 1.0)
        ])
    }
    static func setUpFeatures() -> Array<UIOnboardingFeature> {
        return .init([
            .init(icon: .init(named: "onboarding2")!,
                  title: "Gebelik Takip Ekranı",
                  description: "Gebelik Takip sürecinizi kolayca takip edip önemli tarihleri ve randevularınızı oluşturun."),
            .init(icon: .init(named: "onboarding3")!,
                  title: "Bebek Gelişim Takip Ekranı",
                  description: "Gebelik sürecinizde bebeğinizin ve kendi gelişiminizi kolayca yönetin.Bu süreçte bebeğinizin gelişim aşamlarına dair bilgiler edinin, semptomlar hakkında bilgi sahibi olun"),
            .init(icon: .init(named: "onboarding1")!,
                  title: "Beslenme ve Egzersiz Ekranı",
                  description: "Gebelik sürecinizde sağlıklı ve dengeli bir beslenme alışkanlığı edinin.Günlük beslenme planları oluşturun.")
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
