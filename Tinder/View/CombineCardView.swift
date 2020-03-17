//
//  CombineCardView.swift
//  Tinder
//
//  Created by Pedro Henrique  on 17/03/20.
//  Copyright © 2020 Pedro Henrique . All rights reserved.
//

import UIKit

class CombineCardView: UIView{
    
    //adicionando imagem de fundo
    let fotoImagemView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pessoa-1")
        //ajustando a imagem para nao ficar esticada
        imageView.contentMode = .scaleAspectFill
        //cortando a imagem caso ela passe do card
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init (frame: CGRect){
        super.init(frame:frame)
        
       addSubview(fotoImagemView)
        
        fotoImagemView.preencherSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
