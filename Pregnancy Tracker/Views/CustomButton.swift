//
//  CustomButton.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 19.04.2024.
//

import UIKit

class CustomButton: UIButton {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit(){
        self.imageView?.contentMode = .scaleAspectFit
        self.titleLabel?.textAlignment = .center
    }
    override func layoutSubviews() {
        super.layoutSubviews()

        // imageView ve titleLabel için düzgün boyut ve konum hesaplama
        guard let image = imageView?.image, let title = titleLabel?.text else { return }

        let imageRect = CGRect(x: bounds.minX + 10, // 10 piksel kenar boşluğu
                               y: 0,
                               width: image.size.width,
                               height: bounds.height)
        
        let titleSize = titleLabel?.intrinsicContentSize ?? CGSize.zero
        let titleRect = CGRect(x: imageRect.maxX + 10, // image'den sonra 10 piksel boşluk
                               y: 0,
                               width: titleSize.width,
                               height: bounds.height)
        
        imageView?.frame = imageRect
        titleLabel?.frame = titleRect
        titleLabel?.textAlignment = .center // Başlığı ortalamayı burada zorlamak
    }
}
