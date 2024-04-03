//
//  ShadowLayer.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 15.03.2024.
//

import UIKit

class ShadowLayer {
    static func setShadow(view: UIView, color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = offset
        view.layer.shadowRadius = radius
        view.layer.masksToBounds = false
    }
}
