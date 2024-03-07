//
//  UIFont.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 7.03.2024.
//

import Foundation
import UIKit

class FontHelper {
    static func customFont(size: CGFloat) -> UIFont {
        if let customFont = UIFont(name: "Kinoble", size: size) {
            return customFont
        }else{
            return UIFont.systemFont(ofSize: size)
        }
    }
}
