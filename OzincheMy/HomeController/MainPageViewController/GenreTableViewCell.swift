//
//  GenreTableViewCell.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 17.10.2025.
//

import UIKit
import SDWebImage

class GenreTableViewCell: UITableViewCell {
        
    static let identifier = "GenreCell"
    
    var items: [Genre] = [] {
        didSet {
            genreCollection.reloadData()
            genreCollection.layoutIfNeeded()
        }
    }
     
    let genreCollection: UICollectionView = {
         let layout = TopAlignedCollectionViewFlowLayout()
         layout.scrollDirection = .horizontal
         layout.minimumLineSpacing = 16
         layout.minimumInteritemSpacing = 16
         layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
         layout.itemSize = CGSize(width: 184, height: 112)
         
         let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
         collectionView.register(GenreCollectionViewCell.self, forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
         collectionView.showsHorizontalScrollIndicator = false
         
         collectionView.backgroundColor = UIColor(named: "FFFFFF-111827")
         
         return collectionView
     }()
     
    let titleLabel: UILabel = {
         let label = UILabel()
         
         label.text = "Жанрды таңдаңыз"
         label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
         label.textColor = UIColor(named: "111827-FFFFFF")
         
         return label
     }()
     
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         
         genreCollection.dataSource = self
         genreCollection.delegate = self
         
         contentView.backgroundColor = UIColor(named: "FFFFFF-111827")

     
         setupUI()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    
     func setupUI() {
         
         contentView.addSubviews(genreCollection, titleLabel)
         
         genreCollection.snp.makeConstraints { make in
             make.top.equalToSuperview( ).offset(40)
             make.left.right.equalToSuperview()
             make.bottom.equalToSuperview().inset(32)
         }
         
         titleLabel.snp.makeConstraints { make in
             make.top.equalToSuperview()
             make.left.equalToSuperview().inset(24)
             make.right.equalToSuperview().inset(24)
             make.height.equalTo(20)
         }
     }
    
    func configure(with genres: [Genre], title: String) {
        self.items = genres
        self.titleLabel.text = title
        genreCollection.reloadData()
    }
 }

 extension GenreTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
     
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
         return items.count
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
         let genre = items[indexPath.item]
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as! GenreCollectionViewCell
         
         cell.configure(with: genre)
         
         return cell
     }
}
