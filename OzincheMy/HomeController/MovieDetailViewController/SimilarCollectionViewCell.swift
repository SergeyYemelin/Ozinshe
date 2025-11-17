//
//  SimilarCollectionViewCell.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 23.10.2025.
//

import UIKit

class SimilarCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SimilarCell"
    
    let imageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "similarImage")
        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let movieNameLabel = {
        let label = UILabel()
        label.text = "Суперкөлік Самұрық"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(red: 0.07, green: 0.09, blue: 0.15, alpha: 1)
        label.numberOfLines = 2
        return label
    }()
    
    let movieGenreNameLabel = {
        let label = UILabel()
        label.text = "Мультсериал"
        label.textColor = UIColor(named: "111827-FFFFFF")
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
        
        contentView.addSubviews(imageView, movieNameLabel, movieGenreNameLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(164)
    }
        
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
    }
        
        movieGenreNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(movieNameLabel.snp.bottom).offset(4)
        }
    }
    
}
