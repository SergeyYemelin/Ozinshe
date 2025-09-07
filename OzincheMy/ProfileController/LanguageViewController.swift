//
//  languageViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 13.05.2025.
//

import UIKit
import SnapKit
import Localize_Swift

class LanguageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UI Elements
    
    let backgroundView = UIView()
    let modalView = UIView()
    let languagesLabelArray = ["English", "Қазақша", "Русский"]
    var selectedLanguageIndex: IndexPath? = nil
    
    lazy var homeView = {
       let homeView = UIView()
        
        homeView.backgroundColor = UIColor(named: "D1D5DB-6B7280")
        homeView.layer.cornerRadius = 3
        
        homeView.snp.makeConstraints { make in
            make.width.equalTo(64)
            make.height.equalTo(5)
        }
        
        return homeView
    }()
    
    lazy var languageLabel = {
        let label = UILabel()
        
        label.text = "Тіл"
        label.textColor = UIColor(named: "111827-FFFFFF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        
        return label
    }()
    
    lazy var tableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: "LanguageTableViewCell")
        
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupModal()
        addDismissGesture()
        
        tableView.delegate = self
        tableView.dataSource = self
        
            if let savedIndex = UserDefaults.standard.value(forKey: "SelectedLanguageIndex") as? Int {
                selectedLanguageIndex = IndexPath(row: savedIndex, section: 0)
            } else {
                selectedLanguageIndex = IndexPath(row: languageCodeToIndex(Localize.currentLanguage()) ?? 0, section: 0)
            }
    }
    
    // MARK: - Setup UI
    
    func setupBackground() {
        
        backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        view.addSubview(backgroundView)
        backgroundView.frame = view.bounds
    }
    
    func setupModal() {
        modalView.backgroundColor = UIColor(named: "FFFFFF-1C2431")
        modalView.layer.cornerRadius = 32
        modalView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        modalView.clipsToBounds = true
        
        view.addSubview(modalView)
        modalView.translatesAutoresizingMaskIntoConstraints = false
        
        modalView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(303)
        }
        
        modalView.addSubviews(homeView, languageLabel, tableView)
        
        homeView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.centerX.equalTo(modalView)
        }
        
        languageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(58)
            make.leading.equalToSuperview().offset(24)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(98)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - UITableViewDelegate, DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        languagesLabelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableViewCell", for: indexPath) as? LanguageTableViewCell else {
                return UITableViewCell()
            }
        
        cell.backgroundColor = .clear
        
        let isLastCell = indexPath.row == languagesLabelArray.count - 1
        
            cell.configure(with: languagesLabelArray[indexPath.row], showSeparator: !isLastCell)
            
        if indexPath == selectedLanguageIndex {
                cell.checkImage.isHidden = false
            } else {
                cell.checkImage.isHidden = true
            }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLanguageIndex = indexPath
        
        let selectedLanguage: String

            switch indexPath.row {
                case 0: selectedLanguage = "en"
                case 1: selectedLanguage = "kk"
                case 2: selectedLanguage = "ru"
            default: return
            }
            switchLanguage(to: selectedLanguage)

        tableView.reloadData()
       }
    
    func addDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        backgroundView.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleDissMiss))
        modalView.addGestureRecognizer(panGesture)
    }
    
    

        // MARK: - Actions
    
    @objc private func dismissView() {
        dismiss(animated: true)
    }
    
    @objc func handleDissMiss(sender: UIPanGestureRecognizer) {
        let viewTranslation = sender.translation(in: view)
        
        switch sender.state {
        case .changed:
            if viewTranslation.y > 0 {
                UIView.animate(withDuration: 0.1) {
                    self.modalView.transform = CGAffineTransform(translationX: 0, y: viewTranslation.y)
                }
            }

        case .ended:
            if viewTranslation.y > 100 {
                dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut) {
                    self.modalView.transform = .identity
                }
            }

        default:
            break
        }
    }
    
    func switchLanguage(to languageCode: String) {
        guard Localize.currentLanguage() != languageCode else { return }

        Localize.setCurrentLanguage(languageCode)
        
        UserDefaults.standard.set(languageCode, forKey: "SelectedLanguageCode")
        
        if let index = languageCodeToIndex(languageCode) {
            UserDefaults.standard.set(index, forKey: "SelectedLanguageIndex")
            selectedLanguageIndex = IndexPath(row: index, section: 0)
        }

        tableView.reloadData()
        
        NotificationCenter.default.post(name: NSNotification.Name("languageChanged"), object: nil)
    }
    
    func languageCodeToIndex(_ code: String) -> Int? {
        switch code {
        case "en": return 0
        case "kk": return 1
        case "ru": return 2
        default: return nil
        }
    }
    
}
