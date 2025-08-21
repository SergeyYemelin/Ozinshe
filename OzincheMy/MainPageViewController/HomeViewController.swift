//
//  HomeViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 21.02.2025.
//

import UIKit
import Alamofire
import SnapKit
import SVProgressHUD
import SwiftyJSON

class HomeViewController: UIViewController {
   
    var mainMovies: [MainMovies] = []
    
//MARK: - Add TableView
    
    let tableView = {
       let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor(named: "ViewBackGroundColor")
        

        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func addNavBarImage() {
        let image = UIImage(named: "logoImage")
        
        let logoImageView = UIImageView(image: image)
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        navigationItem.leftBarButtonItem = imageItem
    }
    
    func setupUi() {
        view.backgroundColor = UIColor(named: "ViewBackGroundColor")
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    //MARK: - Downloads
    
//    func downloadMainBanners() {
//        SVProgressHUD.show()
//        
//        let headers : HTTPHeaders = [
//            "Autorization": "Bearer \(Storage.sharedInstance.accessToken)"
//            ]
//        AF.request(urls.MAIN_BANNERS_URL, method: .get, headers: headers).responseData { (response) in
//            SVProgressHUD.dismiss()
//            var resultString = ""
//            if let data = response.data {
//                resultString = String(data: data, encoding: .utf8)!
//                print(resultString)
//            }
//            
//            if response.response?.statusCode == 200 {
//                let json = JSON(response.data!)
//                print("JSON: \(json)")
//                
//                if let array = json.array {
//                    let movie = MainMovies()
//                    movie.cellType = .mainBanner
//                    for item in array {
//                        let bannerMovie.append(bannerMovie)
//                    }
//                    self.mainMovies.append(movie)
//                    self.tableView.reloadData()
//                } else {
//                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
//                }
//            } else {
//                var ErrorString = "CONNECTION_ERROR".localized()
//                if let sCode = response.response?.statusCode {
//                    ErrorString = ErrorString + " \(sCode)"
//                }
//                ErrorString = ErrorString + " \(resultString)"
//                SVProgressHUD.showError(withStatus: ErrorString)
//            }
//            self.downloadUserHistory()
//        }
//        
//    }
    
   
    
    
}

//extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return mainMovies.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        //mainBanner
//        if mainMovies[indexPath.row].CellType == .mainBanner {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "MainBannerCell", for: IndexPath) as! MainBannerTableViewCell
//            
//            cell.setData(mainMovie: mainMovies[indexPath.row])
//            self.delegate = self
//            
//            return cell
//        }
//        
//    }
//}
