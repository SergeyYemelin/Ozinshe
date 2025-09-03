//
//  LanguageTableViewCell.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 14.05.2025.
//

import UIKit

class LanguageTableViewCell: UITableViewCell {
    
    //MARK: - UI Elements
    
    let identifier = "LanguageTableViewCell"
    
    lazy var languageLabel = {
       let label = UILabel()
        
        label.text = ""
        label.textColor = UIColor(named: "111827-FFFFFF")
        label.font = UIFont(name: "SfProDisplay-Bold", size: 16)
        
        return label
    }()
    
    lazy var checkImage = {
       let image = UIImageView()
        
        image.image = UIImage(named: "CheckImage")
        
        return image
    }()
    
    lazy var separatorLine = {
        let imageView = UIView()
        
        imageView.backgroundColor = UIColor(named: "D1D5DB-374151")
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        
        return imageView
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
        contentView.addSubviews(languageLabel, checkImage, separatorLine)
        
        languageLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        
        checkImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
        
        separatorLine.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    //MARK: - Cell Configuration
    
    func configure(with title: String, showSeparator: Bool) {
            textLabel?.text = title
        separatorLine.isHidden = !showSeparator
        }
}
