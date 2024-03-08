//
//  SettingsPageButtons.swift
//  Pregnancy Tracker
//
//  Created by Hüseyin HÖBEK on 7.03.2024.
//

import UIKit

class SettingsPageButtons: UIButton {

    let buttonColor = UIColor(hex: "DDBEA8")
    enum ButtonState {
        case active
        case inactive
    }

    var buttonState: ButtonState = .active {
        didSet {
            updateButtonAppearance()
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        solidColorLayer.frame = bounds
    }

    lazy var solidColorLayer: CALayer = {
        let layer = CALayer()
        layer.frame = self.bounds
        layer.backgroundColor = buttonColor.cgColor
        return layer
    }()


    func setButtonTextFont(font: UIFont?) {
        titleLabel?.font = font
    }

    func setCornerRadius(radius: CGFloat) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }

    private func updateButtonAppearance() {
        switch buttonState {
        case .active:
            solidColorLayer.isHidden = false
            backgroundColor = buttonColor
            setTitleColor(.white, for: .normal)
        case .inactive:
            solidColorLayer.isHidden = true
            backgroundColor = UIColor(hex: "1D1B20").withAlphaComponent(0.1)
            setTitleColor(UIColor(red: 0x88/255.0, green: 0x88/255.0, blue: 0x88/255.0, alpha: 1.0), for: .normal)
        }
    }

}

extension UIColor {
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
