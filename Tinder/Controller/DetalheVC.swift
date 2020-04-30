//
//  DetalheVC.swift
//  Tinder
//
//  Created by Pedro Henrique  on 20/04/20.
//  Copyright © 2020 Pedro Henrique . All rights reserved.
//

import UIKit

class HeaderLayout: UICollectionViewFlowLayout {
    //percorrendo todos os elementos
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        //fazendo ele percorrer
        layoutAttributes?.forEach({(attribute) in
            //pra pegar o header
            if attribute.representedElementKind == UICollectionView.elementKindSectionHeader{
                guard let collectionView = collectionView else {return}
                
                let contentOffSetY = collectionView.contentOffset.y
                attribute.frame = CGRect(x: 0, y: contentOffSetY, width: collectionView.bounds.width, height: attribute.bounds.height - contentOffSetY)
            }
        })
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
}

class DetalheVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var usuario : Usuario?{
        didSet{
            self.collectionView.reloadData()
        }
    }
    
    let cellId = "cellId"
    let headerId = "headerId"
    let perfilId = "perfilId"
    let fotosId = "fotosId"
    
    init(){
        super.init(collectionViewLayout: HeaderLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fazendo header preencher a parte de cima da tela
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.backgroundColor = .white
        //registrando layout da coleção
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        //registrando header
        collectionView.register(DetalheHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:headerId )
        //registrando celula de perfil
        collectionView.register(DetalhePerfilCell.self, forCellWithReuseIdentifier: perfilId)
        //registrando parte de fotos do instagram
        collectionView.register(DetalhesFotosCell.self, forCellWithReuseIdentifier: fotosId)
    }
    
    //numero de linhas que vai ter
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    //setando tamanho no header
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.bounds.width, height: view.bounds.height * 0.7)
    }

    //criando header
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! DetalheHeaderView
        
        header.usuario = self.usuario
        
        return header
    }
    
    //layout da coleção
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
//        cell.backgroundColor = .blue
//        return cell
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: perfilId, for: indexPath) as! DetalhePerfilCell
                cell.usuario = self.usuario
            
                return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: fotosId, for: indexPath) as! DetalhesFotosCell
        
        return cell
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = UIScreen.main.bounds.width
        var height: CGFloat = UIScreen.main.bounds.width * 0.66
        
        
        if indexPath.item == 0 {
            
            let cell = DetalhePerfilCell(frame: CGRect(x: 0, y: 0, width: width, height: height))
            cell.usuario = self.usuario
            cell.layoutIfNeeded()
            let estimativaTamanho = cell.systemLayoutSizeFitting(CGSize(width: width, height: 1000))
            height = estimativaTamanho.height
        
        }
        
        
        
        
        return .init(width: width, height: height)
    }
    
}
