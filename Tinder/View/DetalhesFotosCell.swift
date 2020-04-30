//
//  DetalhesFotoCell.swift
//  Tinder
//
//  Created by Pedro Henrique  on 29/04/20.
//  Copyright © 2020 Pedro Henrique . All rights reserved.
//

import UIKit

class DetalhesFotosCell: UICollectionViewCell {
    
    let descricaoLabel: UILabel = .textBoldLabel(16)
    
    let slideFotosVC = SlideFotosVC()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .blue
        
        descricaoLabel.text = "Fotos recentes do Instagram"
        addSubview(descricaoLabel)
        descricaoLabel.preencher(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 20, bottom: 0, right: 20)
            )
        
        addSubview(slideFotosVC.view)
        slideFotosVC.view.preencher(
            top: descricaoLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
