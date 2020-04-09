//
//  MatchVC.swift
//  Tinder
//
//  Created by Pedro Henrique  on 07/04/20.
//  Copyright © 2020 Pedro Henrique . All rights reserved.
//

import UIKit

class MatchVC : UIViewController{
    
    let fotoImageView: UIImageView = .fotoImageView(named: "pessoa-1")
    let likeImageView: UIImageView = .fotoImageView(named: "icone-like")
    
    let mensagemLabel: UILabel = .textLabel(18, textColor: .white, numberOfLines: 1)
    
    let mensagemTxt : UITextField = {
        let textField = UITextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
        textField.placeholder = "Diga algo Legal"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 8
        textField.textColor = .darkText
        textField.returnKeyType = .go
        
        //Formatando input
        
        //margin no texto
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        textField.leftViewMode = .always
        
        textField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 90, height: 0))
        textField.rightViewMode = .always
        
        return textField
        
    }()
    
    let mensagemEnviarButton: UIButton = {
        let button = UIButton()
        
        button.setTitle("Enviar", for: .normal)
        //cor do texto
        button.setTitleColor(UIColor(red: 62/255, green: 163/255, blue: 255/255, alpha: 1), for: .normal)
        //tamanho da fonte
        button.titleLabel?.font = .systemFont(ofSize: 16)
        
        
        return button
    }()
    
    let voltarButton: UIButton = {
       let button = UIButton()
        button.setTitle("voltar para o tinder ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(fotoImageView)
        fotoImageView.preencherSuperview()
        
        mensagemLabel.text =  "Ela te curtiu Também"
        mensagemLabel.textAlignment = .center
        
        likeImageView.translatesAutoresizingMaskIntoConstraints = false
        likeImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
        likeImageView.contentMode = .scaleAspectFit
        
        //adicionando o button dentro do textfield
        mensagemTxt.addSubview(mensagemEnviarButton)
        mensagemEnviarButton.preencher(
            top: mensagemTxt.topAnchor,
            leading: nil,
            trailing: mensagemTxt.trailingAnchor,
            bottom: mensagemTxt.bottomAnchor,
            padding: .init(top: 0, left: 0, bottom: 0, right: 16))
        
        let stackView = UIStackView(arrangedSubviews: [likeImageView, mensagemLabel, mensagemTxt, voltarButton])
        
        //alterando eixo
        stackView.axis = .vertical
        stackView.spacing = 16
        
        view.addSubview(stackView)
        stackView.preencher(
            top: nil,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: view.bottomAnchor,
            padding: .init(top: 0, left: 32, bottom: 46, right: 32))
    }
}
