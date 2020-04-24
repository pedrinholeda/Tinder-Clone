//
//  CombineVC.swift
//  Tinder
//
//  Created by Pedro Henrique  on 17/03/20.
//  Copyright © 2020 Pedro Henrique . All rights reserved.
//

import UIKit

enum Acao{
    case deslike
    case superlike
    case like
}

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
        
        let loading = Loading(frame: view.frame)
        
        view.insertSubview(loading, at: 0)
        
        self.adicionarHeader()
        self.adicionarFooter()
        self.buscaUsuarios()
    }
    
    func buscaUsuarios(){
//        self.usuarios = UsuarioService.shared.buscaUsuarios()
//        self.adicionarCard()
        
        UsuarioService.shared.buscaUsuarios { (usuarios, err) in
            if let usuarios = usuarios {
                DispatchQueue.main.async {
                    self.usuarios = usuarios
                    self.adicionarCard()
                }
            }
        }
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
        
        deslikeButton.addTarget(self, action: #selector(deslikeClique), for: .touchUpInside)
        superlikeButton.addTarget(self, action: #selector(superLikeClique), for: .touchUpInside)
        likeButton.addTarget(self, action: #selector(likeClique), for: .touchUpInside)
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
            
            //card de informaçoes
            card.callback = {(data) in
                self.vizualizarUsuario(usuario: usuario)
            }
            
            //interação (arrastar card)
            let gesture = UIPanGestureRecognizer()
            gesture.addTarget(self, action: #selector(handlerCard))
            
            card.addGestureRecognizer(gesture)
            
            //ADICIONANDO VIEW DENTRO DA COMBINE VIEWCONTROLLER
            view.insertSubview(card, at: 1)
        }
    }
    
    func removerCard(card: UIView){
        card.removeFromSuperview()
        
        self.usuarios = self.usuarios.filter({ (usuario) -> Bool in
            return usuario.id != card.tag
        })
    }
    
    func verificarMach(usuario:Usuario){
        if usuario.match{
            
            let matchVC = MatchVC()
            matchVC.usuario = usuario

            //iniciando logica de match
            matchVC.modalPresentationStyle = .fullScreen
            self.present(matchVC, animated: true, completion: nil)
        }
    }
    
    func vizualizarUsuario(usuario:Usuario){
       let detalheVC = DetalheVC()
        detalheVC.modalPresentationStyle = .fullScreen
        
        self.present(detalheVC, animated: true, completion: nil)
    }
    
}

extension CombineVC {
    @objc func deslikeClique (){
        animaCard(rotationAngle: -0.4, acao: .deslike)
    }
    @objc func likeClique (){
        animaCard(rotationAngle: 0.4, acao: .like)
    }
    @objc func superLikeClique(){
        animaCard(rotationAngle: 0, acao: .superlike)
    }
    
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
                
                if card.center.x > self.view.bounds.width + 50 {
                    self.animaCard(rotationAngle: rotationAngle, acao: .like)
                    return
                }
                if card.center.x < -50 {
                    self.animaCard(rotationAngle: rotationAngle, acao: .deslike)
                    return
                }
                
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
    
    func animaCard (rotationAngle: CGFloat,acao:Acao){
        if let usuario = self.usuarios.first{
            for view in self.view.subviews{
                if view.tag == usuario.id {
                    
                    if let card = view as? CombineCardView{
                        
                        let center : CGPoint
                        var like: Bool
                        
                        switch acao{
                        case .deslike:
                            center = CGPoint(x: card.center.x - self.view.bounds.width, y: card.center.y + 50)
                            like = false
                        case .like:
                            center = CGPoint(x: card.center.x + self.view.bounds.width, y: card.center.y + 50)
                            like = true
                        case .superlike:
                            center = CGPoint(x: card.center.x, y: card.center.y - self.view.bounds.height)
                            like = true
                        }
                        
                        UIView.animate(withDuration: 0.2, animations: {
                            card.center = center
                            card.transform = CGAffineTransform(rotationAngle: rotationAngle)
                            
                            card.deslikeImageView.alpha = like == false ? 1 : 0
                            card.deslikeImageView.alpha = like == true ? 1 : 0
                            
                        }) {(_) in
                            
                            if like{
                                self.verificarMach(usuario: usuario)
                            }
                            
                            self.removerCard(card: card)
                        }
                    }
                }
            }
        }
    }
}
