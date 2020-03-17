//
//  CombineCardView.swift
//  Tinder
//
//  Created by Pedro Henrique  on 17/03/20.
//  Copyright © 2020 Pedro Henrique . All rights reserved.
//

import UIKit

class CombineCardView: UIView{
    
    var usuario: Usuario?{
        didSet{
            if let usuario = usuario{
                fotoImagemView.image = UIImage(named: usuario.foto)
                nomeLabel.text = usuario.nome
                idadeLabel.text = String(usuario.idade)
                fraseLabel.text = usuario.frase
            }
        }
    }
    
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
    
    let nomeLabel: UILabel = .textBoldLabel(32, textColor: .white)
    let idadeLabel: UILabel = .textLabel(28, textColor: .white)
    let fraseLabel : UILabel = .textLabel(18, textColor: .white, numberOfLines: 2)
    
    
    override init (frame: CGRect){
        super.init(frame:frame)
        
        //ajustando bordas do card
        layer.borderWidth = 0.3
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 8
        //fazendo o recorte
        clipsToBounds = true
        
        nomeLabel.text = "Ana Laura"
        idadeLabel.text = "20"
        fraseLabel.text = "chama a novinha no zap"
        
        nomeLabel.adicionaShadow()
        idadeLabel.adicionaShadow()
        fraseLabel.adicionaShadow()
        
        addSubview(fotoImagemView)
        
        fotoImagemView.preencherSuperview()
        
        let nomeIdadeStackView = UIStackView(arrangedSubviews: [nomeLabel, idadeLabel, UIView()])
        nomeIdadeStackView.spacing = 12
        
        let stackView = UIStackView(arrangedSubviews: [nomeIdadeStackView, fraseLabel])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        
        addSubview(stackView)
        stackView.preencher(
            top: nil,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 0, left: 16, bottom: 16, right: 16)
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
