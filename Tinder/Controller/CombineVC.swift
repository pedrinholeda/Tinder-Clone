//
//  CombineVC.swift
//  Tinder
//
//  Created by Pedro Henrique  on 17/03/20.
//  Copyright © 2020 Pedro Henrique . All rights reserved.
//

import UIKit

class CombineVC: UIViewController{
    
    var usuarios : [Usuario] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemGroupedBackground
        self.buscaUsuarios()
    }
    
    func buscaUsuarios(){
        self.usuarios = UsuarioService.shared.buscaUsuarios()
        self.adicionarCard()
    }
}

extension CombineVC {
    func adicionarCard(){

        for usuario in usuarios{
            
            let card = CombineCardView()
            card.frame = CGRect(x: 0, y: 0, width: view.bounds.width - 32, height: view.bounds.height * 0.7)
            
            //centralizando view
            card.center = view.center
            card.usuario = usuario
            card.tag = usuario.id
            
            //interação (arrastar card)
            let gesture = UIPanGestureRecognizer()
            gesture.addTarget(self, action: #selector(handlerCard))
            
            card.addGestureRecognizer(gesture)
            
            //ADICIONANDO VIEW DENTRO DA COMBINE VIEWCONTROLLER
            view.insertSubview(card, at: 0)
        }
    }
}

extension CombineVC {

    @objc func handlerCard(_ gesture:UIPanGestureRecognizer){
        if let card = gesture.view{
            //pegando posição pra onde o usuario está arrastando
            let point = gesture.translation(in: view)
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
            //fazendo rotação do card
            let rotationAngle = point.x / view.bounds.width * 0.4
            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
            //fazendo o card voltar para a posição inicial
            if gesture.state == .ended{
                UIView.animate(withDuration: 0.2) {
                    card.center = self.view.center
                    card.transform = .identity
                }
            }
        }
    }
}
