//
//  SlideFotoCell.swift
//  Tinder
//
//  Created by Pedro Henrique  on 30/04/20.
//  Copyright © 2020 Pedro Henrique . All rights reserved.
//

import UIKit

class SlideFotoCell: UICollectionViewCell {
    
    var fotoImageView: UIImageView = .fotoImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8
//        pra fazer o recorte
        clipsToBounds = true
        
        addSubview(fotoImageView)
        fotoImageView.preencherSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
