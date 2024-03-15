//
//  ShadowLayer.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 15.03.2024.
//

import UIKit

class ShadowLayer {
    static func setShadow(imageView: UIImageView, color: UIColor, opacity: Float, offset: CGSize, radius: CGFloat) {
        imageView.layer.shadowColor = color.cgColor
        imageView.layer.shadowOpacity = opacity
        imageView.layer.shadowOffset = offset
        imageView.layer.shadowRadius = radius
        imageView.layer.masksToBounds = false
    }
}
