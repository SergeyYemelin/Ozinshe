//
//  MainBannerTableViewCell.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 20.08.2025.
//

import UIKit
import SDWebImage

protocol MainBannerTableViewCellDelegate: AnyObject {
    func mainBannerTableViewCell(_ cell: MainBannerTableViewCell, didSelect banner: Banner)
}

class TopAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)?
            .map { $0.copy() } as? [UICollectionViewLayoutAttributes]

        attributes?
            .reduce([CGFloat: (CGFloat, [UICollectionViewLayoutAttributes])]()) {
                guard $1.representedElementCategory == .cell else { return $0 }
                return $0.merging([ceil($1.center.y): ($1.frame.origin.y, [$1])]) {
                    ($0.0 < $1.0 ? $0.0 : $1.0, $0.1 + $1.1)
                }
            }
            .values.forEach { minY, line in
                line.forEach {
                    $0.frame = $0.frame.offsetBy(
                        dx: 0,
                        dy: minY - $0.frame.origin.y
                    )
                }
            }

        return attributes
    }
}

class MainBannerTableViewCell: UITableViewCell {

    static let identifier = "MainBannerCell"
    
    weak var delegate: MainBannerTableViewCellDelegate?
    
    var bannerMovies: [Banner] = [] {
            didSet {
                bannerCollection.reloadData()
            }
        }
    
    let bannerCollection: UICollectionView = {
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 22.0, left: 24.0, bottom: 10.0, right: 24.0)
        layout.itemSize = CGSize(width: 300, height: 240)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: "BannerCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(named: "FFFFFF-111827")
        
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bannerCollection.dataSource = self
        bannerCollection.delegate = self
    
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setupUI() {
        contentView.backgroundColor = UIColor(named: "ViewBackGroundColor")
        contentView.addSubview(bannerCollection)
        
        bannerCollection.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(32)
        }
    }
    
    func configure(with bannerMovies: [Banner]) {
            self.bannerMovies = bannerMovies               // сохраняем модель для этого row
            bannerCollection.reloadData()        // и перерисовываем collection
        }
    
}

extension MainBannerTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCollectionViewCell
        
            let bannerMovies = bannerMovies[indexPath.item]
            cell.configure(with: bannerMovies) // ✅ прокидываем данные отдельной ячейке коллекции
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedBanner = bannerMovies[indexPath.item]
        delegate?.mainBannerTableViewCell(self, didSelect: selectedBanner)
    }
}
