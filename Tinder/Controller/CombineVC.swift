//
//  CombineVC.swift
//  Tinder
//
//  Created by Pedro Henrique  on 17/03/20.
//  Copyright © 2020 Pedro Henrique . All rights reserved.
//

import UIKit

class CombineVC: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemGroupedBackground
        self.adicionarCard()
    }
}

extension CombineVC {
    func adicionarCard(){

        for item in 1...3{
            let redView = UIView()
            redView.backgroundColor = item == 2 ?.blue : .red
            redView.frame = CGRect(x: 0, y: 0, width: 200, height: 300)
            
            //centralizando view
            redView.center = view.center
            
            //interação (arrastar card)
            let gesture = UIPanGestureRecognizer()
            gesture.addTarget(self, action: #selector(handlerCard))
            
            redView.addGestureRecognizer(gesture)
            
            //ADICIONANDO VIEW DENTRO DA COMBINE VIEWCONTROLLER
            view.addSubview(redView)
        }
    }
}

extension CombineVC {

    @objc func handlerCard(_ gesture:UIPanGestureRecognizer){
        if let card = gesture.view{
            //pegando posição pra onde o usuario está arrastando
            let point = gesture.translation(in: view)
            card.center = CGPoint(x: view.center.x + point.x, y: view.center.y + point.y)
            
            //fazendo o card voltar para a posição inicial
            if gesture.state == .ended{
                UIView.animate(withDuration: 0.2) {
                      card.center = self.view.center
                }
            }
        }
    }
}
