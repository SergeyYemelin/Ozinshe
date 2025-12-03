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

class HomeViewController: UIViewController, MainTableViewCellDelegate, GenreTableViewCellDelegate, HistoryTableViewCellDelegate {
    
    
    //MARK: - Add TableView
    
    var rows: [HomeRow] = []
    var bannerMovies: [Banner] = []
    var genres: [Genre] = []
    var firstRowMovies: [Movie] = []
    var secondRowMovies: [Movie] = []
    var thirdRowMovies: [Movie] = []
    var categoriesAge: [Genre] = []
    var allMovies: [Movie] = []
    
    let tableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor(named: "FFFFFF-111827")
        
        tableView.register(MainBannerTableViewCell.self, forCellReuseIdentifier: MainBannerTableViewCell.identifier)
        tableView.register(GenreTableViewCell.self, forCellReuseIdentifier: GenreTableViewCell.identifier)
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.identifier)
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
    
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        tableView.contentInsetAdjustmentBehavior = .automatic
        tableView.contentInset.top = 32
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "FFFFFF-111827")
        appearance.shadowColor = .clear
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        rows = [
            .bannerMovies([]),
            .history([]),
            .movies(categoryName: "", movies: []),
            .genres(items: [], titleKey: "Жанрды таңдаңыз"),
            .movies(categoryName: "", movies: []),
            .movies(categoryName: "", movies: []),
            .genres(items: [], titleKey: "Жасына сәйкес")
        ]
        
        addNavBarImage()
        setupUi()
        mainBannerDownoloadData()
        loadHistoryMovies()
        genresDownloadData()
        moviesByCategoriesDownloadData()
        categoryAgeDownloadData()
        allMoviesDownloadData()
        
        NotificationCenter.default.addObserver(
                self,
                selector: #selector(languageDidChange),
                name: NSNotification.Name("languageChanged"),
                object: nil
            )
    }
    
    func addNavBarImage() {
        
        let image = UIImage(named: "logoMainPage")
        
        let logoImageView = UIImageView(image: image)
        
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        navigationItem.leftBarButtonItem = imageItem
    }
    
    func setupUi() {
        view.backgroundColor = UIColor(named: "FFFFFF-111827")
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
    
    // MARK: - downloads
    func mainBannerDownoloadData() {
        guard let url = URL(string: URLs.MAIN_BANNERS_URL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let token = Storage.sharedInstance.accessToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(for: request)

                let bannerMovies = try JSONDecoder().decode([Banner].self, from: data)
                
                await MainActor.run {
                    
                    self.bannerMovies = bannerMovies
                    
                    self.rows[0] = .bannerMovies(bannerMovies)
                    self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                    
                    self.tableView.reloadData()
                }
                
            } catch {
                print("Ошибка:", error)
            }
        }
    }
    
    func loadHistoryMovies() {
        guard let url = URL(string: URLs.HISTORY_MOVIES_URL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(Storage.sharedInstance.accessToken)", forHTTPHeaderField: "Authorization")
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let movies = try JSONDecoder().decode([Movie].self, from: data)
                
                await MainActor.run {
                    guard !movies.isEmpty else { return }

                    self.rows[1] = .history(movies)
                    self.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
                    
                    self.tableView.reloadData()
                }
            } catch {
                print("Ошибка загрузки истории:", error)
            }
        }
    }
    
    func genresDownloadData() {
        guard let url = URL(string: URLs.GENRES_URL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let token = Storage.sharedInstance.accessToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                
                let genres = try JSONDecoder().decode([Genre].self, from: data)
                
                await MainActor.run {
                    self.genres = genres
                    
                    self.rows[3] = .genres(items: genres, titleKey: "GENRES_TITLE")
                    self.tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .automatic)
                    
                    self.tableView.reloadData()
                }
                
            } catch {
                print("Ошибка загрузки жанров:", error)
            }
        }
    }
    
    func moviesByCategoriesDownloadData() {
        
        guard let url = URL(string: URLs.MOVIES_BY_CATEGORIES_URL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let token = Storage.sharedInstance.accessToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                
                let categories: [MainPageCategory] = try JSONDecoder().decode([MainPageCategory].self, from: data)
                
                await MainActor.run {
                    for (i, category) in categories.enumerated() {
                        let rowIndex = 2 + i  // 2, 3, 4? — нет. Нам нужно 2, 4, 5

                        let map: [Int] = [2, 4, 5]
                        let index = map[i]

                        self.rows[index] = .movies(categoryName: category.categoryName, movies: category.movies)
                        
                        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    }
                    
                    self.tableView.reloadData()
                }
                
            } catch {
                print("Ошибка загрузки жанров:", error)
            }
        }
    }
    
    func categoryAgeDownloadData() {
        guard let url = URL(string: URLs.CATEGORY_AGES_URL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let token = Storage.sharedInstance.accessToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                
                let categoryAge = try JSONDecoder().decode([Genre].self, from: data)
                
                await MainActor.run {
                    self.categoriesAge = categoryAge
                    
                    self.rows[6] = .genres(items: categoriesAge, titleKey: "AGE_CATEGORIES_TITLE")
                    self.tableView.reloadRows(at: [IndexPath(row: 6, section: 0)], with: .automatic)
                    
                    self.tableView.reloadData()
                }
                
            } catch {
                print("Ошибка загрузки жанров:", error)
            }
        }
    }
    
    func allMoviesDownloadData() {
        guard let url = URL(string: URLs.ALL_MOVIES_URL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let token = Storage.sharedInstance.accessToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        Task {
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                
                let movies = try JSONDecoder().decode([Movie].self, from: data)
                
                await MainActor.run {
                    self.allMovies = movies
                    print("Загружено фильмов: \(movies.count)")
                }
            } catch {
                print("Ошибка загрузки всех фильмов:", error)
            }
        }
    }
    
    func mainTableViewCellDidTapAll(_ cell: MainTableViewCell, categoryName: String, movies: [Movie]) {
        
        let vc = MoviesListTableViewController()
        vc.categoryName = categoryName
        vc.movies = movies
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func genreTableViewCell(_ cell: GenreTableViewCell, didSelect genre: Genre) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }

        let filteredMovies: [Movie]

        switch indexPath.row {
        case 3:
            filteredMovies = allMovies.filter { movie in
                movie.genres?.contains(where: { $0.id == genre.id }) ?? false
            }
        case 6:
            filteredMovies = allMovies.filter { movie in
                movie.categoryAges?.contains(where: { $0.id == genre.id }) ?? false
            }
        default:
            filteredMovies = []
        }

        let vc = MoviesListTableViewController()
        vc.categoryName = genre.name
        vc.movies = filteredMovies
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func languageDidChange() {
        tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, MainBannerTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch rows[indexPath.row] {
        case .bannerMovies(let bannerMovies):
            let cell = tableView.dequeueReusableCell(withIdentifier: MainBannerTableViewCell.identifier, for: indexPath) as! MainBannerTableViewCell
            cell.configure(with: bannerMovies)
            cell.delegate = self
            return cell
            
        case .history(let movies):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: HistoryTableViewCell.identifier,
                for: indexPath
            ) as! HistoryTableViewCell
            cell.delegate = self
            cell.configure(with: movies)
            return cell
        
        case .movies(categoryName: let categoryName, movies: let movies):
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainTableViewCell.identifier,
                for: indexPath
            ) as! MainTableViewCell
            cell.configure(categoryName: categoryName , movies: movies)
            cell.delegate = self
            return cell
        
            
        case .genres(let items, let titleKey):
            let cell = tableView.dequeueReusableCell(withIdentifier: GenreTableViewCell.identifier, for: indexPath) as! GenreTableViewCell
            cell.configure(with: items, title: titleKey.localized())
            cell.delegate = self
            return cell
        }
    }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            switch rows[indexPath.row] {
            case .bannerMovies: return 272
            case .history: return 228
            case .movies: return 296
            case .genres: return 184
            }
        }
    
    func mainBannerTableViewCell(_ cell: MainBannerTableViewCell, didSelect banner: Banner) {
        print("Выбран баннер с id:", banner.id)
                
            let detailVC = MovieDetailViewController(movieID: banner.movie.id)
            navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func mainTableViewCell(_ cell: MainTableViewCell, didSelect movie: Movie) {
            let detailVC = MovieDetailViewController(movieID: movie.id)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    
    func historyTableViewCell(_ cell: HistoryTableViewCell, didSelect movie: Movie) {
            let detailVC = MovieDetailViewController(movieID: movie.id)
            navigationController?.pushViewController(detailVC, animated: true)
        }
}

