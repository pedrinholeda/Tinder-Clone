//
//  MatchVC.swift
//  Tinder
//
//  Created by Pedro Henrique  on 07/04/20.
//  Copyright © 2020 Pedro Henrique . All rights reserved.
//

import UIKit

class MatchVC : UIViewController{
    
    //implementando dados do usuario
    var usuario : Usuario? {
        didSet{
            if let usuario = usuario {
                fotoImageView.image = UIImage(named: usuario.foto)
                mensagemLabel.text = "\(usuario.nome) curtiu você também!"
            }
        }
    }
    
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
        
        //criando um observe para quando o teclado abrir criar uma ação
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        //criando uma observe para o a view voltar ao tamanho normal depois que o teclado sumir
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        view.addSubview(fotoImageView)
        fotoImageView.preencherSuperview()
        
        //criando gradiente
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        //clear pra limpar entre as duas cores
        gradient.colors = [UIColor.clear.cgColor,UIColor.clear.cgColor, UIColor.black.cgColor]
        fotoImageView.layer.addSublayer(gradient)
        
        mensagemLabel.textAlignment = .center
        
        voltarButton.addTarget(self, action: #selector(voltarClique), for: .touchUpInside)
        
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
    //fazer o teclado sumir com o toque na tela
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //forca o teclado a sumir
        view.endEditing(true)
    }
    
    //função de fechar modal
    @objc func voltarClique() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func keyboardShow(notification: NSNotification) {
        //pegar o tamanho do teclado
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue{
            if let duracao = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
               
            //criando animaçao
                UIView.animate(withDuration: duracao){
                 
                    self.view.frame = CGRect(
                        x: self.view.frame.origin.x,
                        y: self.view.frame.origin.y,
                        width: self.view.frame.width,
                        //diminuindo o tamanho do teclado
                        height: self.view.frame.height - keyboardSize.height
                    )
                    //funçao para redefinir layout
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
    
    @objc func keyboardHide(notification: NSNotification){
            if let duracao = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double {
                UIView.animate(withDuration: duracao - 1){
                    //voltando a tela para o tamanho normal
                    self.view.frame = UIScreen.main.bounds
                    //funçao para redefinir layout
                    self.view.layoutIfNeeded()
                    
            }
        }
    }
}
