//
//  HistoryTableViewCell.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 14.10.2025.
//

import UIKit
import SDWebImage

protocol HistoryTableViewCellDelegate: AnyObject {
    func historyTableViewCell(_ cell: HistoryTableViewCell, didSelect movie: Movie)
}

class HistoryTableViewCell: UITableViewCell {
    
    var movies: [Movie] = []
    
    weak var delegate: HistoryTableViewCellDelegate?
    
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
        
        contentView.backgroundColor = UIColor(named: "FFFFFF-111827")
        
        NotificationCenter.default.addObserver(
                self,
                selector: #selector(localizeLanguage),
                name: NSNotification.Name("languageChanged"),
                object: nil
            )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        contentView.addSubviews(historyCollection, titleLabel)
        
        historyCollection.translatesAutoresizingMaskIntoConstraints = false
        
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
    
    func configure(with movies: [Movie]) {
        self.movies = movies

        historyCollection.reloadData()
    }
    
    @objc func localizeLanguage() {
        self.titleLabel.text = "HISTORY_TITLE".localized()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension HistoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, HistoryCollectionViewCellDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCollectionCell", for: indexPath) as! HistoryCollectionViewCell
        
        let movie = movies[indexPath.item]
            cell.configure(with: movie) // метод configure для ячейки HistoryCollectionViewCell
        
        cell.delegate = self
        
        return cell
    }
    
    func historyCollectionViewCellDidTap(_ cell: HistoryCollectionViewCell) {
            guard let indexPath = historyCollection.indexPath(for: cell) else { return }
            let movie = movies[indexPath.item]
            delegate?.historyTableViewCell(self, didSelect: movie)
        }
}
