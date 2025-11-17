//
//  MainTableViewCell.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 15.10.2025.
//

import UIKit
import SDWebImage

protocol MainTableViewCellDelegate: AnyObject {
    func mainTableViewCell(_ cell: MainTableViewCell, didSelect movie: Movie)
}

class MainTableViewCell: UITableViewCell, MainCollectionViewCellDelegate {

    static let identifier = "MainCell"
    
    weak var delegate: MainTableViewCellDelegate?
    
    var movies: [Movie] = [] {
            didSet {
                mainCollection.reloadData()
                mainCollection.layoutIfNeeded()
            }
        }
    
    let mainCollection: UICollectionView = {
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.estimatedItemSize = CGSize(width: 112, height: 224)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MainCollectionViewCell.self, forCellWithReuseIdentifier: "MainCollectionCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.backgroundColor = UIColor(named: "FFFFFF-111827")
        
        return collectionView
        
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Телехикая"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        label.textColor = UIColor(named: "111827-FFFFFF")
        
        return label
    }()
    
    let allLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Барлығы"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(red: 0.702, green: 0.463, blue: 0.969, alpha: 1)
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        mainCollection.dataSource = self
        mainCollection.delegate = self
    
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "FFFFFF-111827")
        
        contentView.addSubviews(mainCollection, titleLabel, allLabel)
        
        mainCollection.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.right.equalToSuperview()
            make.left.equalToSuperview()
            make.height.equalTo(224)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(24)
        }
        
        allLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(24)
            make.centerY.equalTo(titleLabel)
        }
    }
    
    func configure(categoryName: String, movies: [Movie]) {
        titleLabel.text = categoryName        // 🟣 Название категории
        self.movies = movies           // 🟢 Сохраняем фильмы
        mainCollection.reloadData()    // 🔄 Обновляем коллекцию
    }
}

extension MainTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MainCollectionCell",
            for: indexPath
        ) as! MainCollectionViewCell
        
        cell.delegate = self  // 🔹 ВАЖНО: подключаем делегат!
        
        let movie = movies[indexPath.item]
        cell.configure(with: movie)
        
        return cell
    }
    
    func mainCollectionViewCellDidTap(_ cell: MainCollectionViewCell) {
            guard let indexPath = mainCollection.indexPath(for: cell) else { return }
            let movie = movies[indexPath.item]
            delegate?.mainTableViewCell(self, didSelect: movie)
        }

}

