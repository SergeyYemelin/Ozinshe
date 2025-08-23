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
        
        return label
    }()
    
    let subTitleLabel = {
       let label = UILabel()
        
        return label
    }()
    
    let image = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let genreNameView = {
        let labelView = UIView()
        
        return labelView
    }()
    
    let genreNameLabel: UILabel = {
        let label = UILabel()
       
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        backgroundColor = UIColor(named: "ViewBackGroundColor")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(bannerMovie: BannerMovie) {
        let transformer = SDImageResizingTransformer(size: CGSize(width: 300, height: 164), scaleMode: .aspectFit)
        
        image.sd_setImage(with: URL(string: bannerMovie.link), placeholderImage: nil, context: [.imageTransformer:transformer])
        
        if let categoryName = bannerMovie.movie.categories.first?.name{
            genreNameLabel.text = categoryName
        }
        
        titlelabel.text = bannerMovie.movie.name
        subTitleLabel.text = bannerMovie.movie.description
    }
    
    func setupUI() {
        
    }
    
}
