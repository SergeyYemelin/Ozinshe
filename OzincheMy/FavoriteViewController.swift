//
//  FavoriteViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 21.02.2025.
//

import UIKit
import Localize_Swift

class FavoriteViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "FFFFFF-111827")
        
        navigationItem.title = "Тізім"
        navigationItem.largeTitleDisplayMode = .inline
        
        
//        let appearance = UINavigationBarAppearance()
//        appearance.backgroundColor = .white
//        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        tableView.separatorStyle = .none
        // Do any additional setup after loading the view.
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 153
        
        localizeLanguage()
        
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(localizeLanguage),
                                                   name: NSNotification.Name("languageChanged"),
                                                   object: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier) as! MoviesTableViewCell
        
        return cell
    }
    
    //MARK: - Private Methods
    
    @objc private func localizeLanguage() {
        navigationItem.title = "FAVORITE_LABEL".localized()
        
        }

}
