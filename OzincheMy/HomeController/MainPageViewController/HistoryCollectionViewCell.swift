//
//  HistoryCollectionViewCell.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 14.10.2025.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    
        let identifier = "HistoryCollectionCell"
        
        let image = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "bannerImage")
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 12
            
            return imageView
        }()
        
        let titleLabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.text = "Глобус"
            label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
            label.textColor = UIColor(named: "111827-FFFFFF")
            
            return label
        }()
        
        let subtitleLabel = {
            let label = UILabel()
            label.text = "2-бөлім"
            label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
            label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
            
            return label
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
            contentView.addSubviews(image, titleLabel, subtitleLabel)
            
            image.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.height.equalTo(112)
                make.width.equalTo(164)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.top.equalTo(image.snp.bottom).offset(8)
        }
            subtitleLabel.snp.makeConstraints { make in
                make.left.equalToSuperview()
                make.right.equalToSuperview()
                make.top.equalTo(titleLabel.snp.bottom).offset(4)
                make.bottom.equalToSuperview()
            }
        }
}
