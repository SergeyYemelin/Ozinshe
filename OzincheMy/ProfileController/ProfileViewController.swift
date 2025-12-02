//
//  ProfileViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 21.02.2025.
//

import UIKit
import SnapKit
import Localize_Swift

class ProfileViewController: UIViewController {
    
    var buttons: [UIButton] = []
    
    //MARK: - UI Elements
    
    lazy var profileImage = {
        
        let image = UIImageView()
        image.image = UIImage(named: "ProfileDefaultImage")
        
        return image
        
    }()
    
    lazy var profileLabel = {
        
        let label = UILabel()
        label.text = "Менің профилім"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "TextColor")
        
        return label
    }()
    
    lazy var subProfileLabel = {
       
        let label = UILabel()
        label.text = "ali@gmail.com"
        label.font = UIFont(name: "SFProDisplay-Regular", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var backView = {
        
        let backView = UIView()

        backView.backgroundColor = UIColor(named: "F9FAFB-111827")
        
        
        return backView
    }()
    
    lazy var userInfoButtonSubLabel = {
       let label = UILabel()
        
        label.text = "Өңдеу"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var languageSublabel = {
       
        let label = UILabel()
        
        label.text = "Қазақша"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var switchControl = {
        let switchControl = UISwitch()
        
        switchControl.onTintColor = UIColor(named: "B376F7")
        switchControl.isOn = false
        switchControl.addTarget(self, action: #selector(darkModeToggled(_:)), for: .valueChanged)
        
        return switchControl
    }()
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await loadProfileAndFillUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "FFFFFF-1C2431")
       
        navigationItem.title = "Профиль"
        navigationItem.largeTitleDisplayMode = .inline
        
        let buttonImage = UIImage(named: "LogOut")?.withRenderingMode(.alwaysOriginal)
            let rightButton = UIBarButtonItem(image: buttonImage,
                                              style: .plain,
                                              target: self,
                                              action: #selector(logoutTapped))

            navigationItem.rightBarButtonItem = rightButton

        setupUI()
        
        localizeLanguage()
        
        NotificationCenter.default.addObserver(
                self,
                selector: #selector(localizeLanguage),
                name: NSNotification.Name("languageChanged"),
                object: nil
            )
    }
    
    //MARK: - UI Setup
    
    func setupUI() {
        
        view.addSubviews(profileImage, profileLabel, subProfileLabel, backView)
        
        profileImage.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            make.centerX.equalToSuperview()
        }
        
        profileLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileImage.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        subProfileLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        backView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(subProfileLabel.snp.bottom).offset(24)
            make.bottom.equalToSuperview()
        }
        
        var heightButton = 64

        let separatorLines = (0..<5).map { _ in makeSeparatorLine() }
        
        for separatorLine in separatorLines {
            
            backView.addSubview(separatorLine)
            
            separatorLine.snp.makeConstraints { (make) in
                make.height.equalTo(1)
                make.left.right.equalToSuperview().inset(24)
                make.top.equalTo(backView.snp.top).offset(heightButton)
            }
            heightButton += 64
        }
        
        let buttonTitles = ["Жеке деректер", "Құпия сөзді өзгерту", "Тіл", "Ережелер мен шарттар", "Хабарландырулар", "Қараңғы режим"]
        
        buttons = createButtons(titles: buttonTitles, in: backView)
        
        backView.addSubviews(userInfoButtonSubLabel, languageSublabel, switchControl)
     
        userInfoButtonSubLabel.snp.makeConstraints{ (make) in
            make.centerY.equalTo(buttons[0].snp.centerY)
            make.right.equalTo(backView.snp.right).inset(48)
        }
        
        languageSublabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(buttons[2].snp.centerY)
            make.right.equalTo(backView.snp.right).inset(48)
        }
        
        addArrows(buttons: buttons, in: backView)
        
        switchControl.snp.makeConstraints { (make) in
            make.centerY.equalTo(buttons[5].snp.centerY)
            make.right.equalTo(backView.snp.right).inset(24)
        }
        
        buttons[0].addTarget(self, action: #selector(editProfileButtonTapped), for: .touchUpInside)
        buttons[1].addTarget(self, action: #selector(changePasswordButton), for: .touchUpInside)
        buttons[2].addTarget(self, action: #selector(languagebuttonTapped), for: .touchUpInside)
    }
    
    func makeSeparatorLine() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB")
        return view
    }
    
    func addArrows(buttons: [UIButton], in currentView: UIView) {
        
        var buttonIndex = 0
        
        for _ in 0...3 {
            let arrow = UIImageView()
            arrow.image = UIImage(named: "Arrow")
            
            currentView.addSubview(arrow)
            
            arrow.snp.makeConstraints { (make) in
                make.centerY.equalTo(buttons[buttonIndex].snp.centerY)
                make.right.equalTo(backView.snp.right).inset(24)
            }
            buttonIndex += 1
        }
    }
    
    //MARK: - Actions
    
    @objc func editProfileButtonTapped() {
        
        let editProfileVC = EditProfileViewController()
        
        editProfileVC.modalPresentationStyle = .fullScreen
        editProfileVC.hidesBottomBarWhenPushed = true
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        navigationController?.show(editProfileVC, sender: self)
    }
    
    @objc func changePasswordButton() {
        
        let changePasswordVC = ChangePasswordViewController()
        
        changePasswordVC.modalPresentationStyle = .fullScreen
        changePasswordVC.hidesBottomBarWhenPushed = true
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        navigationController?.show(changePasswordVC, sender: self)
    }
    
    
    @objc func logoutTapped () {
        let modalVC = LogOutViewController()
        modalVC.modalPresentationStyle = .overFullScreen
        modalVC.modalTransitionStyle = .crossDissolve
        present(modalVC, animated: true)
        print("logOutTapped")
    }
    
    @objc func languagebuttonTapped() {
                let languageVC = LanguageViewController()
                languageVC.modalPresentationStyle = .overFullScreen
                languageVC.modalTransitionStyle = .crossDissolve
        
                present(languageVC, animated: true)
    }
    
    @objc func darkModeToggled(_ sender: UISwitch) {
        ThemeManager.shared.currentTheme = sender.isOn ? .dark : .light
    }
    
    //MARK: - Private Methods

    private func createButtons(titles: [String], in view: UIView) -> [UIButton] {
        
        var buttons: [UIButton] = []
        var previousButton: UIButton?
        
        for title in titles {
            let button = UIButton()
                    
                    var config = UIButton.Configuration.plain()
                    config.title = title
                    config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0)
            config.baseBackgroundColor = UIColor(named: "FFFFFF-111827")
                    
                    var attributes = AttributeContainer()
                    attributes.font = UIFont(name: "SFProDisplay-Medium", size: 16)
                    attributes.foregroundColor = UIColor(named: "1C2431-FFFFFF")
                    
                    config.attributedTitle = AttributedString(title, attributes: attributes)
                    
                    button.configuration = config
                    button.backgroundColor = .clear
                    button.contentHorizontalAlignment = .leading

            view.addSubview(button)
            
            button.snp.makeConstraints { (make) in
                if let previousButton = previousButton {
                    make.height.equalTo(64)
                    make.width.equalToSuperview()
                    make.top.equalTo(previousButton.snp.bottom)
                } else {
                    make.height.equalTo(64)
                    make.width.equalToSuperview()
                    make.top.equalTo(backView.snp.top)
                }
            }
            
            previousButton = button
            buttons.append(button)
        }

        return buttons
    }
    
    private func loadProfileAndFillUI() async {
        do {
            let profile = try await UserService.shared.fetchProfile()
            await MainActor.run {
                self.subProfileLabel.text = profile.user?.email ?? "No email"
            }
        } catch {
            print("Ошибка получения профиля:", error)
            await MainActor.run {
                self.subProfileLabel.text = "Не удалось загрузить"
            }
        }
    }
    
    @objc private func localizeLanguage() {
        navigationItem.title = "PROFILE_TITLE".localized()
        profileLabel.text = "PROFILE_LABEL".localized()
        
        let buttonTitles = [
        "USER_INFO_BUTTON",
        "CHANGE_PASSWORD_BUTTON",
        "LANGUAGE_BUTTON",
        "TERMS_AND_CONDITIONS_BUTTON",
        "ANNOUNCEMENTS_BUTTON",
        "DARK_MODE_BUTTON"]
        
        guard let font = UIFont(name: "SFProDisplay-Medium", size: 16) else { return }
        guard let color = UIColor(named: "1C2431-FFFFFF") else { return }
        
        for (index, key) in buttonTitles.enumerated() {
            buttons[index].setLocalizedStyledTitle(key, lang: Localize.currentLanguage(), font: font, color: color)
            
            userInfoButtonSubLabel.text = "USER_INFO_BUTTON_SUBLABEL".localized()
            languageSublabel.text = "LANGUAGE_BUTTON_SUBLABEL".localized()
        }
    }
    
    //MARK: Deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


