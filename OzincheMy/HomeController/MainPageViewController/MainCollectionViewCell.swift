//
//  MainCollectionViewCell.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 15.10.2025.
//

import UIKit

protocol MainCollectionViewCellDelegate: AnyObject {
    func mainCollectionViewCellDidTap(_ cell: MainCollectionViewCell)
}

class MainCollectionViewCell: UICollectionViewCell {
    
    let identifier = "MainCollectionCell"
    
    weak var delegate: MainCollectionViewCellDelegate?
    
    let imageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "mainImage")
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "Суперкөлік Самұрық"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        label.numberOfLines = 2
        
        return label
    }()
    
    let subTitleLabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = ""
        label.textColor = UIColor(red: 0.61, green: 0.64, blue: 0.69, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Добавляем жест нажатия на всю ячейку
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(cellTapped))
                contentView.addGestureRecognizer(tapGesture)
        
        setupUI()
        backgroundColor = UIColor(named: "FFFFFF - 111827")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        contentView.addSubviews(imageView, titleLabel, subTitleLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(164)
            make.width.equalTo(112)
    }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(8)
    }
        subTitleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview()
        }
    }
    
    @objc func cellTapped() {
           delegate?.mainCollectionViewCellDidTap(self)
       }
    
    func configure(with movie: Movie) {
        titleLabel.text = movie.name
        subTitleLabel.text = movie.categories?.map { $0.name }.joined(separator: ", ") ?? ""

        if let posterString = movie.poster?.link {
            let fixedURLString = posterString.replacingOccurrences(
                of: "api.ozinshe.com",
                with: "apiozinshe.mobydev.kz"
            )

            if let url = URL(string: fixedURLString) {
                imageView.sd_imageTransition = .fade
                imageView.sd_setImage(
                    with: url,
                    placeholderImage: nil,
                    options: [.continueInBackground, .retryFailed],
                    completed: nil
                )
            }
        }
    }
}
