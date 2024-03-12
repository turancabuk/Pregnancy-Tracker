//
//  PaddedPlaceHolder.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 12.03.2024.
//

import UIKit

class PaddedPlaceHolder: UITextField {
    
    
    var placeHolderPadding: CGFloat = 0
    
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: placeHolderPadding, dy: 0)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: placeHolderPadding, dy: 0)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: placeHolderPadding, dy: 0)
    }
}
