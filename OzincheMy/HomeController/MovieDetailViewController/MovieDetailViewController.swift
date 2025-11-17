//
//  MovieDetailViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 17.10.2025.
//

import UIKit
import SnapKit
import Alamofire
import SVProgressHUD
import SwiftyJSON
import SDWebImage

class MovieDetailViewController: UIViewController {
    
    private let movieID: Int
    
    var movie: Movie?
    
    var screenshots: [Poster] = []
    
    private var tabBarHeight: CGFloat {
        tabBarController?.tabBar.frame.height ?? 49
    }
    
    private let similarMovies: [SimilarMovie] = [
        SimilarMovie(imageName: "similarImage1", title: "Айдар", subtitle: "Мультсериал"),
        SimilarMovie(imageName: "similarImage2", title: "Суперкөлік Самұрық", subtitle: "Мультсериал"),
        SimilarMovie(imageName: "similarImage3", title: "Каникулы off-line 2", subtitle: "Телехикая"),
    ]
    
    // ✅ Создаем инициализатор, который принимает movieID
    init(movieID: Int) {
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: UI Elements
    
    let movieScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentMode = .scaleToFill
        scrollView.bounces = false
        scrollView.backgroundColor = UIColor(named: "FFFFFF-111827")
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    let movieContentView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "FFFFFF-111827")
        return view
    }()
    
    let posterImageView = {
        let ImageView = UIImageView()
        ImageView.image = UIImage(named: "PosterDetailImage")
        ImageView.contentMode = .scaleAspectFill
        return ImageView
    }()
    
    let gradient = {
        let image = UIImageView()
        
        image.image = UIImage(named: "GradientDetailPoster")
        
        return image
    }()
    
    let backgroundView = {
        let viewBack = UIView()
        
        viewBack.contentMode = .scaleToFill
        viewBack.layer.cornerRadius = 32
        viewBack.backgroundColor = UIColor(named: "FFFFFF-111827")
        viewBack.clipsToBounds = true
        viewBack.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return viewBack
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "PlayButtonImage"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        // Создаем дополнительный UIImageView
        let playView = UIImageView()
        playView.image = UIImage(named: "playView")
        playView.contentMode = .scaleAspectFit
        playView.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляем внутрь кнопки
        button.addSubview(playView)
        
        playView.snp.makeConstraints { (make) in
            make.centerY.equalTo(button)
            make.centerX.equalTo(button).offset(3.715)
            make.size.equalTo(CGSize(width: 20, height: 27.43))
        }
        
        button.addTarget(self, action: #selector(playMovieTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var favoriteButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "FavoriteButtonImage"), for: .normal)
        return button
    }()
    
    lazy var favoriteButtonLabel = {
        let label = UILabel()
        label.text = "Тізімге қосу"
        label.font = UIFont(name: "SF-ProDisplay", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()
    
    lazy var shareButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ShareButtonImage"), for: .normal)
        return button
    }()
    
    lazy var shareButtonLabel = {
        let label = UILabel()
        label.text = "Бөлісу"
        label.font = UIFont(name: "SF-ProDisplay", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
        return label
    }()
    
    let nameLabel = {
        let label = UILabel()
        label.text = "Айдар"
        label.textColor = UIColor(named: "111827-FFFFFF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        return label
    }()
    
    let detailLabel = {
        let label = UILabel()
        label.text = "2020 • Телехикая • 5 сезон, 46 серия, 7 мин"
        label.textColor = UIColor(named: "9CA3AF")
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.numberOfLines = 0
        return label
    }()
    
    let grayView1 = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB")
        return view
    }()
    
    let descriptionLabel = {
        let label = UILabel()
        let text = """
        Шытырман оқиғалы мультсериал Елбасының «Ұлы даланың жеті қыры» бағдарламасы аясында жүзеге асырылған. Мақалада қызғалдақтардың отаны Қазақстан екені айтылады. Ал, жоба қызғалдақтардың отаны – Алатау баурайы екенін анимация тілінде дәлелдей түседі.
                Шытырман оқиғалы мультсериал Елбасының «Ұлы даланың жеті қыры» бағдарламасы аясында жүзеге асырылған. Мақалада қызғалдақтардың отаны Қазақстан екені айтылады. Ал, жоба қызғалдақтардың отаны – Алатау баурайы екенін анимация тілінде дәлелдей түседі.
        """
        
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        //        label.numberOfLines = 4
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 12 // расстояние между строками
        
        let attributedString = NSAttributedString(
            string: text,
            attributes: [
                .paragraphStyle: paragraphStyle, // межстрочный интервал
                .kern: 0.5 // расстояние между буквами
            ]
        )
        
        label.attributedText = attributedString
        
        // ✅ Добавляем приоритеты
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        return label
    }()
    
    let descriptionGradientView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(named: "FFFFFF-111827")!.withAlphaComponent(0.0).cgColor,
            UIColor(named: "FFFFFF-111827")!.withAlphaComponent(0.25).cgColor,
            UIColor(named: "FFFFFF-111827")!.withAlphaComponent(0.5).cgColor,
            UIColor(named: "FFFFFF-111827")!.cgColor
        ]
        gradientLayer.locations = [0.0, 0.25, 0.5, 1.0]
        
        view.layer.addSublayer(gradientLayer)
        return view
    }()
    
    lazy var fullDescriptionButton = {
        let button = UIButton()
        button.setTitle("Толығырақ", for: .normal)
        button.setTitleColor(UIColor(named: "B376F7"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        button.addTarget(self, action: #selector(fullDescription), for: .touchUpInside)
        return button
    }()
    
    
    let directorLabel = {
        let label = UILabel()
        label.text = "Режиссер:"
        label.textColor = UIColor(named: "4B5563")
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        return label
    }()
    
    let directorNameLabel = {
        let label = UILabel()
        label.text = "Бақдәулет Әлімбеков"
        label.textColor = UIColor(named: "9CA3AF")
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        return label
    }()
    
    let producerLabel = {
        let label = UILabel()
        label.text = "Продюсер:"
        label.textColor = UIColor(named: "4B5563")
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        return label
    }()
    
    let producerNameLabel = {
        let label = UILabel()
        label.text = "Сандуғаш Кенжебаева"
        label.textColor = UIColor(named: "9CA3AF")
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        return label
    }()
    
    let grayView2 = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB")
        return view
    }()
    
    let seasonsLabel = {
        let label = UILabel()
        label.text = "Бөлімдер"
        label.textColor = UIColor(named: "111827-FFFFFF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        return label
    }()
    
    lazy var seasonsButton = {
        let button = UIButton()
        button.setTitle("5 сезон, 46 серия", for: .normal)
        button.contentHorizontalAlignment = .right
        button.setTitleColor(UIColor(named: "9CA3AF"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        //        button.addTarget(self, action: #selector(playMovieTapped), for: .touchUpInside)
        return button
    }()
    
    let arrowImage = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ArrowImage")
        return iv
    }()
    
    let screenshotsLabel = {
        let label = UILabel()
        label.text = "Скриншоттар"
        label.textColor = UIColor(named: "111827 - FFFFFF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        return label
    }()
    
    let similarMoviesLabel = {
        let label = UILabel()
        label.text = "Ұқсас телехикаялар"
        label.textColor = UIColor(named: "111827-FFFFFF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        return label
    }()
    
    //MARK: - Collection View
    let screenshotsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 24.0, bottom: 0.0, right: 24.0)
        layout.itemSize = CGSize(width: 184, height: 112)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ScreenshotCollectionViewCell.self, forCellWithReuseIdentifier: "ScreenshotCell")
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor(named: "FFFFFF-111827")
        
        return collectionView
    }()
    
    let similarCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 24.0, bottom: 0.0, right: 24.0)
        layout.itemSize = CGSize(width: 112, height: 224)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SimilarCollectionViewCell.self, forCellWithReuseIdentifier: SimilarCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.backgroundColor = UIColor(named: "FFFFFF-111827")
        
        return collectionView
    }()
    
    let bottomSpacerView = UIView()
    
    //MARK: Lifecycle
    
    override func viewDidLoad() {
        if let navBar = navigationController?.navigationBar {
            
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear
            appearance.shadowColor = .clear
            navBar.standardAppearance = appearance
            navBar.scrollEdgeAppearance = appearance
        }
        setupWhiteBackArrow()
        setupUI()
        screenshotsCollectionView.delegate = self
        screenshotsCollectionView.dataSource = self
        
        similarCollectionView.delegate = self
        similarCollectionView.dataSource = self
        
        fetchMovieDetails()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let gradientLayer = descriptionGradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = descriptionGradientView.bounds
        }
    }
    
    
    
    //MARK: UI Setup
    
    func setupUI() {
        view.addSubview(movieScrollView)
        movieScrollView.addSubview(movieContentView)
        
        // Добавляем все элементы в contentView
        movieContentView.addSubviews(
            posterImageView, gradient, backgroundView,
            playButton, favoriteButton, favoriteButtonLabel,
            shareButton, shareButtonLabel, bottomSpacerView
        )
        
        backgroundView.addSubviews(
            nameLabel, detailLabel, grayView1, descriptionLabel,descriptionGradientView,
            fullDescriptionButton, directorLabel, directorNameLabel,
            producerLabel, producerNameLabel, grayView2,
            seasonsLabel, seasonsButton, arrowImage,
            screenshotsLabel, screenshotsCollectionView,
            similarMoviesLabel, similarCollectionView
        )
        
        bottomSpacerView.snp.makeConstraints { make in
            make.top.equalTo(similarCollectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(tabBarHeight + 45)
            make.bottom.equalToSuperview()
        }
        
        // ScrollView
        movieScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        //ContentView
        movieContentView.snp.makeConstraints { make in
            make.edges.equalTo(movieScrollView.contentLayoutGuide)
            make.width.equalTo(movieScrollView.frameLayoutGuide)
        }
        
        
        // Poster и Gradient
        posterImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(movieContentView)
            make.height.equalTo(400)
        }
        
        gradient.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(posterImageView)
            make.height.equalTo(364)
        }
        
        playButton.snp.makeConstraints { make in
            make.centerX.equalTo(movieContentView.snp.centerX)
            make.top.equalTo(movieContentView.snp.top).offset(222)
            make.width.height.equalTo(66)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.centerY.equalTo(playButton.snp.centerY)
            make.leading.equalTo(movieContentView.snp.leading).offset(77)
            make.width.height.equalTo(24)
        }
        
        favoriteButtonLabel.snp.makeConstraints { make in
            make.centerX.equalTo(favoriteButton)
            make.top.equalTo(favoriteButton.snp.bottom).offset(8)
        }
        
        shareButton.snp.makeConstraints { make in
            make.centerY.equalTo(playButton.snp.centerY)
            make.trailing.equalTo(movieContentView.snp.trailing).inset(65)
            make.width.height.equalTo(24)
        }
        
        shareButtonLabel.snp.makeConstraints { make in
            make.centerX.equalTo(shareButton)
            make.top.equalTo(shareButton.snp.bottom).offset(8)
        }
        
        // BackgroundView
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(324)
            make.leading.trailing.equalTo(movieContentView)
            make.bottom.equalTo(movieContentView.snp.bottom)
        }
        
        // Labels в backgroundView
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(backgroundView.snp.top).offset(24)
            make.leading.equalTo(backgroundView.snp.leading).inset(24)
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalTo(backgroundView.snp.leading).inset(24)
            make.trailing.equalTo(backgroundView.snp.trailing).inset(24)
        }
        
        grayView1.snp.makeConstraints { make in
            make.top.equalTo(detailLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(grayView1.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        descriptionGradientView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(descriptionLabel) // привязка к нижней части descriptionLabel
            make.height.equalTo(150) // высота градиента, можно подкорректировать
        }
        
        fullDescriptionButton.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(24)
        }
        
        directorLabel.snp.makeConstraints { make in
            make.top.equalTo(fullDescriptionButton.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(24)
        }
        
        directorNameLabel.snp.makeConstraints { make in
            make.top.equalTo(fullDescriptionButton.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(113)
            make.trailing.equalToSuperview().inset(24)
        }
        
        producerLabel.snp.makeConstraints { make in
            make.top.equalTo(directorLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(24)
        }
        
        producerNameLabel.snp.makeConstraints { make in
            make.top.equalTo(directorNameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(113)
            make.trailing.equalToSuperview().inset(24)
        }
        
        grayView2.snp.makeConstraints { make in
            make.top.equalTo(producerNameLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(1)
        }
        
        seasonsLabel.snp.makeConstraints { make in
            make.top.equalTo(grayView2.snp.bottom).offset(24)
            make.leading.equalToSuperview().inset(24)
        }
        
        seasonsButton.snp.makeConstraints { make in
            make.centerY.equalTo(seasonsLabel)
            make.leading.equalTo(seasonsLabel.snp.trailing)
            make.trailing.equalToSuperview().inset(45)
        }
        
        arrowImage.snp.makeConstraints { make in
            make.centerY.equalTo(seasonsLabel)
            make.trailing.equalToSuperview().inset(24)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        
        screenshotsLabel.snp.makeConstraints { make in
            make.top.equalTo(seasonsLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().inset(24)
        }
        
        screenshotsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(screenshotsLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(112)
        }
        
        similarMoviesLabel.snp.makeConstraints { make in
            make.top.equalTo(screenshotsCollectionView.snp.bottom).offset(32)
            make.leading.equalToSuperview().inset(24)
        }
        
        similarCollectionView.snp.makeConstraints { make in
            make.top.equalTo(similarMoviesLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(224)
            make.bottom.equalTo(bottomSpacerView.snp.top)
        }
    }
    
    private func fetchMovieDetails() {
        print("Загружаем детали фильма с id: \(movieID)")
        
        guard let url = URL(string: URLs.MOVIE_BY_ID_URL + "\(movieID)") else {
            print("❌ Неверный URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Добавляем токен
        let token = Storage.sharedInstance.accessToken
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        Task {
            do {
                let (data, response) = try await URLSession.shared.data(for: request)
                
                if let httpResponse = response as? HTTPURLResponse {
                    print("📡 Код ответа:", httpResponse.statusCode)
                }
                
                // Декодируем объект Movie
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                
                await MainActor.run {
                    self.movie = movie
                    
                    self.updateUI(with: movie)
                    
                    if let shots = movie.screenshots {
                        self.screenshots = shots
                        self.screenshotsCollectionView.reloadData()
                    }
                }
                
            } catch {
                print("❌ Ошибка загрузки деталей фильма:", error)
            }
        }
    }
    
    func updateUI(with movie: Movie) {
        print("✅ Фильм получен:", movie.name)
        
        if let posterString = movie.poster?.link {
            let fixedURLString = posterString.replacingOccurrences(
                of: "api.ozinshe.com",
                with: "apiozinshe.mobydev.kz"
            )
            
            if let url = URL(string: fixedURLString) {
                posterImageView.sd_imageTransition = .fade // плавное появление
                posterImageView.sd_setImage(
                    with: url,
                    placeholderImage: nil,
                    options: [.continueInBackground, .retryFailed],
                    completed: nil
                )
            }
            nameLabel.text = movie.name
            detailLabel.text = makeDetailText(from: movie)
            setDescriptionText(movie.description)
            directorNameLabel.text = movie.director
            producerNameLabel.text = movie.producer
            
        }
    }
    
    private func makeDetailText(from movie: Movie) -> String {
        let year = "\(movie.year)"
        let genresString = movie.genres?.map { $0.name }.joined(separator: ", ") ?? ""
        let durationString = movie.timing != nil ? "\(movie.timing!) мин" : ""
        
        // Допустим, у тебя потом будет поле type: "MOVIE" или "SERIAL"
        if movie.categories?.contains(where: { $0.name == "Телехикая" }) == true {
            // сериал
            let seasonText = "5 сезон, 46 серия" // позже можно заменить на реальные данные
            return "\(year) • Телехикая • \(seasonText) • \(durationString)"
        } else {
            // фильм
            return "\(year) • \(genresString) • \(durationString)"
        }
    }
    
    private func setDescriptionText(_ text: String) {
        // 1. Убираем переносы строк из JSON
        let cleanText = text.replacingOccurrences(of: "\n", with: " ")
        
        // 2. Создаём paragraphStyle с lineSpacing
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 12
        paragraph.alignment = descriptionLabel.textAlignment
        
        // 3. Атрибуты текста
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraph,
            .font: descriptionLabel.font as Any,
            .foregroundColor: descriptionLabel.textColor as Any,
            .kern: 0.5 // расстояние между буквами, если нужно
        ]
        
        // 4. Устанавливаем текст и numberOfLines
        descriptionLabel.numberOfLines = 4
        descriptionLabel.attributedText = NSAttributedString(string: cleanText, attributes: attributes)
        
        // 5. Определяем, нужно ли показывать кнопку "Толығырақ" и градиент
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            
            let lines = descriptionLabel.visibleLineCount()
            
            if lines > 4 {
                fullDescriptionButton.isHidden = false
                descriptionGradientView.isHidden = false
            } else {
                fullDescriptionButton.isHidden = true
                descriptionGradientView.isHidden = true
            }
        }
    }
    
    func updateDescriptionGradient() {
        guard let gradientLayer = descriptionGradientView.layer.sublayers?.first as? CAGradientLayer else { return }
        gradientLayer.frame = descriptionGradientView.bounds
        
        // Скрыть, если текст полностью раскрыт
        descriptionGradientView.isHidden = descriptionLabel.numberOfLines == 0
    }
    
    //MARK: Action
    
    @objc func fullDescription() {
        if descriptionLabel.numberOfLines == 4 {
            // показать весь текст
            descriptionLabel.numberOfLines = 0
            fullDescriptionButton.setTitle("Жасыру", for: .normal)
        } else {
            // показать только 4 строки
            descriptionLabel.numberOfLines = 4
            fullDescriptionButton.setTitle("Толығырақ", for: .normal)
        }
        updateDescriptionGradient()
    }
    
    @objc func playMovieTapped() {
        guard let videoID = movie?.video?.link else { return }

        let playerVC = PlayerViewController()
        playerVC.videoID = videoID
        
        navigationController?.pushViewController(playerVC, animated: true)
    }
}
    
    //MARK: - Extension UICollectionViewDelegate
extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.similarCollectionView {
            return similarMovies.count
        }
        
        return screenshots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.similarCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarCollectionViewCell.identifier, for: indexPath) as! SimilarCollectionViewCell
            
            //            let transformer = SDImageResizingTransformer(size: CGSize(width: 112, height: 164), scaleMode: .aspectFill)
            cell.imageView.layer.cornerRadius = 8
            
            //            similarCell.contentView.layer.borderColor = UIColor.red.cgColor
            //            similarCell.contentView.layer.borderWidth = 2
            
            //            similarCell.imageView.layer.borderColor = UIColor.blue.cgColor
            //            similarCell.imageView.layer.borderWidth = 2
            let movie = similarMovies[indexPath.item]
            
            cell.imageView.image = UIImage(named: movie.imageName)
            cell.movieNameLabel.text = movie.title
            cell.movieGenreNameLabel.text = movie.subtitle
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenshotCell", for: indexPath) as! ScreenshotCollectionViewCell
        
        //        let transformer = SDImageResizingTransformer(size: CGSize(width: 184, height: 112), scaleMode: .aspectFill)
        
        guard indexPath.item < screenshots.count else {
            print("⚠️ ERROR: indexPath \(indexPath.item) >= screenshots.count \(screenshots.count)")
            return cell
        }
        
        let shot = screenshots[indexPath.item]
        
        if let posterString = shot.link {
            let fixedURLString = posterString.replacingOccurrences(
                of: "api.ozinshe.com",
                with: "apiozinshe.mobydev.kz"
            )
            
            if let url = URL(string: fixedURLString) {
                cell.imageView.sd_imageTransition = .fade
                cell.imageView.sd_setImage(
                    with: url,
                    placeholderImage: nil,
                    options: [.continueInBackground, .retryFailed],
                    completed: nil
                )
            }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.similarCollectionView {
            //            let movieDetailVC = MovieDetailViewController()
            //            navigationController?.show(movieDetailVC, sender: self)
            
            let seasonVC = SeriesAndSeasonsViewController()
            navigationController?.show(seasonVC, sender: self)
        }
    }
}
