//
//  CustomCollectionViewCell.swift
//  TestApp_1
//
//  Created by Глеб Никитенко on 04.09.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit
import Kingfisher

class CustomCollectionViewCell: UICollectionViewCell {
 
    
    let myimageView: UIImageView = {
       let iv = UIImageView()
       iv.contentMode = .scaleAspectFill
       iv.image = UIImage(named: "image1")
       iv.clipsToBounds = true
       return iv
        
    }()
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Название"
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.textColor = .white
        return lb
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myimageView)
        setUpmyImageView()
        
        addSubview(titleLabel)
        setupTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        myimageView.kf.cancelDownloadTask()
    }
    
    private func setUpmyImageView() {
        myimageView.translatesAutoresizingMaskIntoConstraints = false
        myimageView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        myimageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        myimageView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        myimageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -40).isActive = true
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        titleLabel.topAnchor.constraint(equalTo: myimageView.bottomAnchor, constant: 15).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    
     
}
