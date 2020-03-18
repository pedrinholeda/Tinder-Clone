//
//  CombineVC.swift
//  Tinder
//
//  Created by Pedro Henrique  on 17/03/20.
//  Copyright © 2020 Pedro Henrique . All rights reserved.
//

import UIKit

class CombineVC: UIViewController{
    
    var perfilButton: UIButton = .iconMenu(named: "icone-perfil")
    var logoButton : UIButton = .iconMenu(named: "icone-logo")
    var chatButton : UIButton = .iconMenu(named: "icone-chat")
    
    var deslikeButton: UIButton = .iconFooter(named: "icone-deslike")
    var superlikeButton: UIButton = .iconFooter(named: "icone-superlike")
    var likeButton: UIButton = .iconFooter(named: "icone-like")
    
    var usuarios : [Usuario] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = UIColor.systemGroupedBackground
        self.adicionarHeader()
        self.adicionarFooter()
        self.buscaUsuarios()
    }
    
    func buscaUsuarios(){
        self.usuarios = UsuarioService.shared.buscaUsuarios()
        self.adicionarCard()
    }
}

extension CombineVC{
    func adicionarHeader(){
        //em caso de ser iphone x etc (contem SafeArea)
        let window = UIApplication.shared.windows.first {$0.isKeyWindow}
        let top: CGFloat = window?.safeAreaInsets.top ?? 44
        ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        
        let stackView = UIStackView(arrangedSubviews: [perfilButton, logoButton, chatButton])
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        stackView.preencher(
            top: view.topAnchor,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: nil,
            padding: .init(top: top, left: 16, bottom: 0, right: 16)
            )
    }
    
    func adicionarFooter(){
        let stackView = UIStackView(arrangedSubviews: [UIView(),deslikeButton,superlikeButton, likeButton, UIView()])
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        stackView.preencher(
            top: nil,
            leading: view.leadingAnchor,
            trailing: view.trailingAnchor,
            bottom: view.bottomAnchor,
            padding: .init(top: 0, left: 16, bottom: 34, right: 16)
            )
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
        if let card = gesture.view as? CombineCardView {
            //pegando posição pra onde o usuario está arrastando
            let point = gesture.translation(in: view)
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
            //fazendo rotação do card
            let rotationAngle = point.x / view.bounds.width * 0.4
            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
            
            //fazendo animação do like e deslike
                //significa que ele esta indo pra direita
            if point.x > 0{
                card.likeImageView.alpha = rotationAngle * 5
                card.deslikeImageView.alpha = 0
            }else{
                card.likeImageView.alpha = 0
                card.deslikeImageView.alpha =  rotationAngle * 5 * -1
            }
            
            //fazendo o card voltar para a posição inicial
            if gesture.state == .ended{
                UIView.animate(withDuration: 0.2) {
                    card.center = self.view.center
                    card.transform = .identity
                    
                    //quando finalizar o toque sumir imagem de like e deslike
                    card.likeImageView.alpha = 0
                    card.deslikeImageView.alpha = 0
                }
            }
        }
    }
}
