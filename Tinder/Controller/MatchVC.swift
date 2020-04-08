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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(fotoImageView)
        fotoImageView.preencherSuperview()
    }
}
