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
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        
        return label
    }()
    
    let subTitleLabel = {
       let label = UILabel()
        
        label.text = "Шытырман оқиғалы мультсериал Елбасының «Ұлы даланың жеті қыры» бағдарламасы аясында жүз..."
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    let image = {
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
        label.textColor = .white
        
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
    
//    func setData(bannerMovie: BannerMovie) {
//        let transformer = SDImageResizingTransformer(size: CGSize(width: 300, height: 164), scaleMode: .aspectFit)
//        
//        image.sd_setImage(with: URL(string: bannerMovie.link), placeholderImage: nil, context: [.imageTransformer:transformer])
//        
//        if let categoryName = bannerMovie.movie.categories.first?.name{
//            genreNameLabel.text = categoryName
//        }
//        
//        titleLabel.text = bannerMovie.movie.name
//        subTitleLabel.text = bannerMovie.movie.description
//    }
    
    //MARK: - UI Setup
    
    func setupUI() {
        
        addSubviews(titleLabel, subTitleLabel, image, genreNameView)
        genreNameView.addSubview(genreNameLabel)
        
        image.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
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

}
