//
//  SearchCollectionViewCell.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 10.06.2025.
//

import UIKit
import SnapKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: SearchCollectionViewCell.self)
    
    //MARK: - UI Elements
    
    lazy var backView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "F3F4F6")
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    lazy var label = {
        
        let label = UILabel()
        
        label.text = ""
        label.font = UIFont(name: "SfProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "374151")
        
        return label
    }()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = UIColor(named: "F3F4F6")
        layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubview(backView)
        backView.addSubview(label)
        
        backView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
        
        label.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(34)
        }
    }
    
}
