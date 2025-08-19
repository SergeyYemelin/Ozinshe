//
//  ChangePasswordViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 27.05.2025.
//

import UIKit
import Localize_Swift

class ChangePasswordViewController: UIViewController {
    
    //MARK: - UI Elements
    
    lazy var passwordLabel = {
       let label = UILabel()
        
        label.text = "Құпия сөз"
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        
        return label
    }()
    
    lazy var passwordView = {
       let view = UIView()
        
        view.backgroundColor = UIColor(named: "TextFieldBackGroundColor")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.layer.borderColor = UIColor(named: "TextFieldFrameColor")?.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    lazy var passwordTextField = {
        let textField = UITextField()
        
        textField.backgroundColor = .clear
        textField.placeholder = "Сіздің құпия сөзіңіз"
        textField.isSecureTextEntry = true
        textField.textColor = UIColor(named: "TextColor")
        textField.backgroundColor = .clear

        
        return textField
    }()
    
    lazy var textFieldIcon: UIImageView = {
       let iconTextField = UIImageView()
        
        iconTextField.image = UIImage(named: "PasswordIcon")
        iconTextField.tintColor = UIColor(named: "9CA3AF")
        
        return iconTextField
    }()
    
    lazy var showPasswordButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "ShowPasswordIcon"), for: .normal)
        button.addTarget(self, action: #selector(showPassButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var repeatPasswordView = {
       let view = UIView()
        
        view.backgroundColor = UIColor(named: "TextFieldBackGroundColor")
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.layer.borderColor = UIColor(named: "TextFieldFrameColor")?.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    lazy var repeatPasswordLabel = {
       let label = UILabel()
        
        label.text = "Құпия сөзді қайталаңыз"
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        
        return label
    }()
    
    lazy var repeatPasswordTextField = {
        let textField = UITextField()
        
        textField.backgroundColor = .clear
        textField.placeholder = "Сіздің құпия сөзіңіз"
        textField.isSecureTextEntry = true
        textField.textColor = UIColor(named: "TextColor")
        textField.backgroundColor = .clear

        
        return textField
    }()
    
    lazy var repeatIconTextField: UIImageView = {
       let iconTextField = UIImageView()
        
        iconTextField.image = UIImage(named: "PasswordIcon")
        iconTextField.tintColor = UIColor(named: "9CA3AF")
        
        return iconTextField
    }()
    
    lazy var repeatShowPasswordButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "ShowPasswordIcon"), for: .normal)
        button.addTarget(self, action: #selector(repeatShowPassButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var saveChangesButton = {
       
        let button = UIButton()
        
        button.backgroundColor = UIColor(named: "7E2DFC")
        button.setTitle("Өзгерістерді сақтау", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.layer.cornerRadius = 12
        
        return button
        
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "ViewBackGroundColor")

        navigationItem.title = "Құпия сөзді өзгерту"
        navigationItem.largeTitleDisplayMode = .inline
        navigationItem.hidesBackButton = true
        
        setupBackArrow()
        setupUi()
        localizeLanguage()
        
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(localizeLanguage),
                                                   name: NSNotification.Name("languageChanged"),
                                                   object: nil)
        // Do any additional setup after loading the view.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - UI Setup
    
    func setupUi() {
        
        view.addSubviews(passwordLabel, passwordView, repeatPasswordLabel, repeatPasswordView, saveChangesButton)
        
        passwordView.addSubviews(passwordTextField, textFieldIcon, showPasswordButton)
        
        repeatPasswordView.addSubviews(repeatPasswordTextField, repeatIconTextField, repeatShowPasswordButton)
        
        passwordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(21)
            make.leading.equalToSuperview().inset(24)
        }
        
        passwordView.snp.makeConstraints { (make) in
            make.top.equalTo(passwordLabel.snp.bottom).offset(4)
            make.height.equalTo(56)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.height.equalTo(passwordView)
            make.top.equalTo(passwordView)
            make.left.right.equalTo(passwordView).inset(44)
        }
        
        textFieldIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(passwordView)
            make.leading.equalTo(passwordView.snp.leading).inset(16)
        }
        
        showPasswordButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(passwordView)
            make.trailing.equalTo(passwordView.snp.trailing).inset(16)
        }
        
        repeatPasswordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordView.snp.bottom).offset(21)
            make.leading.equalToSuperview().inset(24)
        }
        
        repeatPasswordView.snp.makeConstraints { (make) in
            make.top.equalTo(repeatPasswordLabel.snp.bottom).offset(4)
            make.height.equalTo(56)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        
        repeatPasswordTextField.snp.makeConstraints { (make) in
            make.height.equalTo(repeatPasswordView)
            make.top.equalTo(repeatPasswordView)
            make.left.right.equalTo(repeatPasswordView).inset(44)
        }
        
        repeatIconTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(repeatPasswordView)
            make.leading.equalTo(repeatPasswordView.snp.leading).inset(16)
        }
        
        repeatShowPasswordButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(repeatPasswordView)
            make.trailing.equalTo(passwordView.snp.trailing).inset(16)
        }
        
        saveChangesButton.snp.makeConstraints { (make) in
            make.height.equalTo(56)
            make.bottom.equalTo(view.snp.bottom).inset(42)
            make.left.right.equalToSuperview().inset(24)
        }
    }
    
    //MARK: - Actions
    
    @objc func showPassButtonTapped() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @objc func repeatShowPassButtonTapped() {
        repeatPasswordTextField.isSecureTextEntry = !repeatPasswordTextField.isSecureTextEntry
    }
    
    @objc func languageChanged() {
        localizeLanguage()
    }
    
    //MARK: - Private Methods
    
    @objc func localizeLanguage() {
        navigationItem.title = "CHANGE_PASSWORD_LABEL".localized()
        passwordLabel.text = "PASSWORD_LABEL".localized()
        passwordTextField.placeholder = "YOUR_PASSWORD_PLACEHOLDER".localized()
        repeatPasswordLabel.text = "REPEAT_PASSWORD_LABEL".localized()
        repeatPasswordTextField.placeholder = "REPEAT_YOUR_PASSWORD_PLACEHOLDER".localized()
        saveChangesButton.setTitle("SAVE_CHANGES_BUTTON".localized(), for: .normal)
        }
}
