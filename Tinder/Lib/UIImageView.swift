//
//  UIImageView.swift
//  Tinder
//
//  Created by Pedro Henrique  on 17/03/20.
//  Copyright © 2020 Pedro Henrique . All rights reserved.
//

import UIKit

extension UIImageView{
    
    static func fotoImageView(named: String? = nil) -> UIImageView{
        
        let imageView = UIImageView()
        if let named = named {
            imageView.image = UIImage(named: named)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    static func iconCard (named: String) -> UIImageView{
        let imageView = UIImageView()
        imageView.image = UIImage(named: named)
        imageView.size(size: .init(width: 130, height: 130))
        //porcentagem em que a imagem aparece
        imageView.alpha = 0.0
        return imageView
        
    }
    
}
