//
//  SeriesAndSeasonsViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 24.10.2025.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class SeriesAndSeasonsViewController: UIViewController {

    var movie: Movie?
    var currentSeason = 0

    //MARK: UI Elements
    
    let seriesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 24.0, left: 24.0, bottom: 8.0, right: 24.0)
        layout.itemSize = CGSize(width: 115, height: 34)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SeasonsAndSeriesCollectionViewCell.self, forCellWithReuseIdentifier: "SeasonCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor =  UIColor(named: "FFFFFF-111827")
        
        return collectionView
    }()
    
    let seriesTableView: UITableView = {
       let tv = UITableView()
        tv.separatorStyle = .none
        tv.allowsSelection = true
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        tv.backgroundColor = UIColor(named: "FFFFFF-111827")
        
        tv.register(SeasonSeriesTableViewCell.self, forCellReuseIdentifier: "SeriesCell")
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seriesCollectionView.dataSource = self
        seriesCollectionView.delegate = self
        
        seriesTableView.dataSource = self
        seriesTableView.delegate = self
        
        self.title = "Бөлімдер"
        setupUI()
    }
    
    //MARK: Setup UI
    
    func setupUI() {
        view.backgroundColor = UIColor(named: "FFFFFF - 111827")
        
        view.addSubviews(seriesCollectionView, seriesTableView)
        
        seriesCollectionView.snp.makeConstraints { make in
            make.top.right.left.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(74)
        }
        
        seriesTableView.snp.makeConstraints { make in
            make.bottom.right.left.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(seriesCollectionView.snp.bottom)
        }
    }
    
   
}

extension SeriesAndSeasonsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movie?.seasonCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeasonCell", for: indexPath) as! SeasonsAndSeriesCollectionViewCell
        
        cell.seasonLabel.text = "\(indexPath.item + 1)-ші сезон"
        
        cell.backView.layer.cornerRadius = 8
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        currentSeason = indexPath.item + 1
        seriesTableView.reloadData()
    }
    
    // MARK: - Table view data source
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movie?.seriesCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SeriesCell", for: indexPath) as! SeasonSeriesTableViewCell
        
        cell.seriesLabel.text = "\(indexPath.row + 1)-ші бөлім"
        
        if let posterString = movie?.poster?.link {
                
                let fixedURLString = posterString.replacingOccurrences(
                    of: "api.ozinshe.com",
                    with: "apiozinshe.mobydev.kz"
                )
                
                if let url = URL(string: fixedURLString) {
                    cell.seriesImage.sd_imageTransition = .fade
                    cell.seriesImage.sd_setImage(
                        with: url,
                        placeholderImage: nil,
                        options: [.continueInBackground, .retryFailed]
                    )
                }
            }
        
        cell.seriesImage.layer.cornerRadius = 12
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 240
    }
}
