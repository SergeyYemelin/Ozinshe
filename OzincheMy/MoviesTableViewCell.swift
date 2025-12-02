//
//  FavoriteTableViewCell.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 21.02.2025.
//

import UIKit
import SnapKit

class MoviesTableViewCell: UITableViewCell {

    static let identifier = String(describing: MoviesTableViewCell.self)
    
    var movie: Movie?
    
    //MARK: - UI Elements
    
    lazy var posterImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "Image")
        
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    lazy var titleLabel = {
        let label = UILabel()
        
        label.text = "Қызғалдақтар мекені"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()

    lazy var subTitleLabel = {
        let label = UILabel()
        
        label.text = "2020 · Телехикая · Мультфильм"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var playView = {
        let view = UIView()
        let play = UIImageView(image: UIImage(named: "Play-Filled"))
        let label = UILabel()
        
        view.backgroundColor = UIColor(named: "F8EEFF-1C2431")
        view.layer.cornerRadius = 8
        
        label.text = "Қарау"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 12)
        label.textColor = UIColor(named: "9753F0")
        
        view.addSubviews(play, label)
        
        play.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(12)
            make.verticalEdges.equalToSuperview().inset(5)
            make.size.equalTo(16)
        }
        
        label.snp.makeConstraints { (make) in
            make.centerY.equalTo(view)
            make.left.equalTo(play.snp.right).offset(4)
            make.right.equalToSuperview().inset(12)
        }
        
        return view
    }()
    
    lazy var bottomView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "D1D5DB")
        
        return view
    }()
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Setup
    
    func setupUI() {
        
        contentView.backgroundColor = UIColor(named: "FFFFFF-111827")
        contentView.addSubviews(posterImageView, titleLabel, subTitleLabel, playView, bottomView)
        
        posterImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(24)
            make.left.equalToSuperview().offset(24)
            make.height.equalTo(104)
            make.width.equalTo(71)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(24)
            make.left.equalTo(posterImageView.snp.right).offset(17)
        }
        
        subTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(posterImageView.snp.right).offset(17)
        }
        
        playView.snp.makeConstraints { (make) in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(24)
            make.left.equalTo(posterImageView.snp.right).offset(17)
            make.height.equalTo(26)
            make.width.equalTo(80)
            
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.height.equalTo(1)
            make.left.right.equalToSuperview().inset(24)
            make.top.equalTo(posterImageView.snp.bottom).offset(24)
            make.bottom.equalToSuperview()
        }
    }
}
