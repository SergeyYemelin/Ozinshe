//
//  FavoriteViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 21.02.2025.
//

import UIKit
import Localize_Swift

class FavoriteViewController: UITableViewController {
    
    private var favoriteMovies: [Movie] = []

    //MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "FFFFFF-111827")
        
        navigationItem.title = "Тізім"
            navigationItem.largeTitleDisplayMode = .inline
        
        tableView.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 153
        
        localizeLanguage()
        
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(localizeLanguage),
                                                   name: NSNotification.Name("languageChanged"),
                                                   object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadFavorites()
    }
    
    private func loadFavorites() {
            Task {
                do {
                    let movies = try await FavoritesService.shared.fetchFavoriteMovies()
                    self.favoriteMovies = movies
                    tableView.reloadData()
                } catch {
                    print("Ошибка загрузки избранного:", error)
                }
            }
        }
    
    func makeSubTitleText(with row: Int, movies: [Movie])-> String {
        let movie = movies[row]
        let year = "\(movie.year)"
        let categoriesString = movie.categories?.map { $0.name }.joined(separator: ", ") ?? ""
        
        return "\(year) • \(categoriesString)"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier) as! MoviesTableViewCell
        
        cell.titleLabel.text = favoriteMovies[indexPath.row].name
        cell.subTitleLabel.text = makeSubTitleText(with: indexPath.row, movies: favoriteMovies)
        
        if let posterString = favoriteMovies[indexPath.item].poster?.link {
            let fixedURLString = posterString.replacingOccurrences(
                of: "api.ozinshe.com",
                with: "apiozinshe.mobydev.kz"
            )

            if let url = URL(string: fixedURLString) {
                cell.posterImageView.sd_imageTransition = .fade
                cell.posterImageView.sd_setImage(
                    with: url,
                    placeholderImage: nil,
                    options: [.continueInBackground, .retryFailed],
                    completed: nil
                )
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let movie = favoriteMovies[indexPath.row]
            let detailVC = MovieDetailViewController(movieID: movie.id)
            navigationController?.pushViewController(detailVC, animated: true)
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    
    //MARK: - Private Methods
    
    @objc private func localizeLanguage() {
        navigationItem.title = "FAVORITE_LABEL".localized()
        
        }
    
    //MARK: Deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
