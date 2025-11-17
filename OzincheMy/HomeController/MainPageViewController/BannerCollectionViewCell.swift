//
//  BannerCollectionViewCell.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 23.08.2025.
//

import UIKit
import SDWebImage

class BannerCollectionViewCell: UICollectionViewCell {
    
    let identifier = "BannerCell"
    
    let titleLabel = {
       let label = UILabel()
        
        label.text = "Қызғалдақтар мекені"
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let subTitleLabel = {
       let label = UILabel()
        
        label.text = "Шытырман оқиғалы мультсериал Елбасының «Ұлы даланың жеті қыры» бағдарламасы аясында жүз..."
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    var imageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "bannerImage")
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let genreNameView = {
        let labelView = UIView()
        
        labelView.backgroundColor = UIColor(named: "7E2DFC")
        labelView.layer.cornerRadius = 8
        
        return labelView
    }()
    
    let genreNameLabel: UILabel = {
        let label = UILabel()
       
        label.text = "Телехикая"
        label.font = UIFont(name: "SFProDisplay-Medium", size: 12)
        label.textColor = UIColor(named: "FFFFFF-111827")
        
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        subTitleLabel.text = nil
        imageView.image = nil // чтобы не показывалась старая картинка
    }
    
    //MARK: - UI Setup
    
    func setupUI() {
        
        addSubviews(titleLabel, subTitleLabel, imageView, genreNameView)
        genreNameView.addSubview(genreNameLabel)
        
        imageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(164)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageView.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        genreNameView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(8)
            make.height.equalTo(24)
        }
        
        genreNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(genreNameView.snp.top)
            make.bottom.equalTo(genreNameView.snp.bottom)
            make.leading.equalToSuperview().inset(8)
            make.trailing.equalToSuperview().inset(8)
        }
    }

    func configure(with bannerMovies: Banner) {
        let genreNames = bannerMovies.movie.genres?.map { $0.name }.first
        genreNameLabel.text = genreNames
        titleLabel.text = bannerMovies.movie.name
        subTitleLabel.text = bannerMovies.movie.description

        if let posterString = bannerMovies.movie.poster?.link {
            let fixedURLString = posterString.replacingOccurrences(
                of: "api.ozinshe.com",
                with: "apiozinshe.mobydev.kz"
            )

            if let url = URL(string: fixedURLString) {
                imageView.sd_imageTransition = .fade // плавное появление
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
