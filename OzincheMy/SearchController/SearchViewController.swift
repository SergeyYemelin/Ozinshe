//
//  SearchViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 21.02.2025.
//

import UIKit
import SnapKit
import Localize_Swift

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            guard layoutAttribute.representedElementCategory == .cell else { return }
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY, maxY)
        }
        return attributes
    }
}

class SearchViewController: UIViewController {
    
    let categoriesArray = ["Телехикая", "Ситком", "Көркем фильм", "Мультфильм", "Мультсериал", "Аниме", "Тв-бағдарлама және реалити-шоу", "Деректі фильм", "Музыка", "Шетел фильмдері"]

    //MARK: - UIElements
    
    lazy var searchTextField = {
       let textField = PaddedTextField()
        
        textField.backgroundColor = UIColor(named: "FFFFFF-1C2431")
        textField.padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        textField.placeholder = "Іздеу"
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        textField.textColor = UIColor(named: "111827-FFFFFF")
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(named: "E5EBF0")!.cgColor
        textField.layer.cornerRadius = 12
        
        return textField
    }()
    
    lazy var exitButton = {
       let button = UIButton()
        
        button.setImage(UIImage(named: "ExitButton"), for: .normal)
        button.contentMode = .scaleToFill
        button.addTarget(self, action: #selector(clearTextField), for: .touchUpInside)
        
        return button
    }()
    
    lazy var searchButton = {
       let button = UIButton()
        
        button.setImage(UIImage(named: "SearchButtonIcon"), for: .normal)
        button.contentMode = .scaleToFill
        button.backgroundColor = UIColor(named: "F3F4F6")
        button.layer.cornerRadius = 12
        
        return button
    }()
    
    lazy var titleLabel = {
       let label = UILabel()
        
        label.text = "Санаттар"
        label.textColor = UIColor(named: "111827-FFFFFF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        
        return label
    }()
    
    let collectionView: UICollectionView = {
       let layout = LeftAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 24, bottom: 16, right: 24)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 128, height: 34)
        layout.estimatedItemSize.width = 100
        
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "FFFFFF-111827")
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
        collectionView.contentInsetAdjustmentBehavior = .automatic
        
        
        return collectionView
    }()
    
    let tableView: UITableView = {
    
        let tv = UITableView()
        tv.separatorStyle = .none
        tv.allowsSelection = true
        tv.showsVerticalScrollIndicator = false
        tv.showsHorizontalScrollIndicator = false
        tv.backgroundColor = .white
        tv.register(MoviesTableViewCell.self, forCellReuseIdentifier: MoviesTableViewCell.identifier)
        
        return tv
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "FFFFFF-111827")

        navigationItem.title = "Іздеу"
        navigationItem.largeTitleDisplayMode = .inline
        
        // Do any additional setup after loading the view.
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        setupUI()
        
        downloadSearchMovies()
        hideKeyboardWhenTappedArround()
        
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        localizeLanguage()
        
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(localizeLanguage),
                                                   name: NSNotification.Name("languageChanged"),
                                                   object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - UI Setup
    
    func setupUI() {
        view.addSubviews(searchTextField, exitButton, searchButton, titleLabel, collectionView, tableView)
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(24)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(24)
            make.width.height.equalTo(56)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(24)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(24)
            make.trailing.equalTo(searchButton.snp.leading).offset(-16)
            make.height.equalTo(56)
        }
        
        exitButton.snp.makeConstraints { make in
            make.height.width.equalTo(52)
            make.trailing.equalTo(searchTextField.snp.trailing)
            make.centerY.equalTo(searchTextField)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(35)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(24)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tableView.snp.top)
            make.height.equalTo(340)
        }
        
        tableView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    //MARK: - Gesture Setup
    
    func hideKeyboardWhenTappedArround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    //MARK: - Actions
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func clearTextField() {
        searchTextField.text = ""
        downloadSearchMovies()
    }
    
    //MARK: - Methods
    
    func downloadSearchMovies() {
        if searchTextField.text!.isEmpty {
            titleLabel.text = "Санаттар"
            collectionView.isHidden = false
            tableView.isHidden = true
//            movies.removeAll()
            tableView.reloadData()
            exitButton.isHidden = true
            tableView.snp.remakeConstraints { (make) in
                make.top.equalTo(collectionView.snp.bottom)
                make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            }
            return
        } else {
            titleLabel.text = "SEARCH_RESULTS_LABEL".localized()
            collectionView.isHidden = true
            
            tableView.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(10)
                make.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            }
            tableView.isHidden = false
            exitButton.isHidden = false
        }
    }
    
    @objc private func localizeLanguage() {
        navigationItem.title = "SEARCH_LABEL".localized()
        searchTextField.placeholder = "SEARCH_TEXTFIELD_PLACEHOLDER".localized()
        titleLabel.text = "CATEGORIES_LABEL".localized()
    }

}

//MARK: - UICollectionViewDataSource & UICollectionViewDelegate, UITableViewDataSource & UITableViewDelegate

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDataSource, UITableViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as! SearchCollectionViewCell
        cell.label.text = categoriesArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.identifier) as! MoviesTableViewCell
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        153
    }
}

//MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == searchTextField {
            searchTextField.layer.borderColor = UIColor(named: "9753F0" )!.cgColor
        }
    }
        
    func textFieldDidEndEditing(_ textField: UITextField) {
            if textField == searchTextField {
                searchTextField.layer.borderColor = UIColor(named: "E5EBF0")!.cgColor
            }
        }
        
    @objc func textFieldDidChange(_ textField: UITextField){
            downloadSearchMovies()
        }
}
