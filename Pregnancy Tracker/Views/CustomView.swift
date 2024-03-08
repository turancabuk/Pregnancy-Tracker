//
//  ContainerView.swift
//  Pregnancy Tracker
//
//  Created by Hüseyin HÖBEK on 8.03.2024.
//

import UIKit

class CustomView: UIView {
    
    var backgroundColorOption: BackgroundColorOption = .defaultColor {
        didSet {
            switch backgroundColorOption {
                case .settingsColor:
                    backgroundColor = UIColor(hex: "E2D6CD")
                case .homeColor:
                    backgroundColor = .blue
                case .profileColor:
                    backgroundColor = .green
                default:
                    backgroundColor = .white
            }
        }
    }
    
    enum BackgroundColorOption {
        case settingsColor
        case homeColor
        case profileColor
        case defaultColor
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        frame = CGRect(x: 24, y: 60, width: frame.width - 24 * 2 , height: frame.height - 60 * 2)
        layer.cornerRadius = 16
        layer.masksToBounds = true
    }

}

