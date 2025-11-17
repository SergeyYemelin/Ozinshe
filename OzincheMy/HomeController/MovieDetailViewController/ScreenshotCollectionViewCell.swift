//
//  ScreenshotCollectionViewCell.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 23.10.2025.
//

import UIKit

class ScreenshotCollectionViewCell: UICollectionViewCell {
    
    let identifier = "ScreenshotCell"
    
    let imageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "genreImage")
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.backgroundColor = .red
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        backgroundColor = UIColor(named: "FFFFFF-111827")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
