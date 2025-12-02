//
//  HistoryTableViewCell.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 14.10.2025.
//

import UIKit
import SDWebImage

class HistoryTableViewCell: UITableViewCell {
    
    static let identifier = "HistoryCell"
    
    let historyCollection: UICollectionView = {
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.itemSize = CGSize(width: 184, height: 156)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: "HistoryCollectionCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.backgroundColor = UIColor(named: "FFFFFF-111827")
        
        return collectionView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.numberOfLines = 0
        label.text = "Қарауды жалғастырыңыз"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "111827 - FFFFFF")
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
        historyCollection.delegate = self
        historyCollection.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        contentView.addSubviews(historyCollection, titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(24)
            make.height.equalTo(24)
        }

        historyCollection.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(156)
            
        }
    }
}

extension HistoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCollectionCell", for: indexPath) as! HistoryCollectionViewCell
        
        return cell
    }
}
