//
//  SignUpViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 28.06.2025.
//

import UIKit
import Localize_Swift

class SignInViewController: UIViewController {

    //MARK: UI Elements
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    let signInLabel = {
       let label = UILabel()
        
        label.text = "Сәлем"
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        
        return label
    }()
    
    let signInSubLabel = {
       let label = UILabel()
        
        label.text = "Аккаунтқа кіріңіз"
        label.textColor = UIColor(named: "6B7280")
        label.font = UIFont(name: "SFProDisplay", size: 16)
        
        return label
    }()
    
    let emailLabel = {
       let label = UILabel()
        
        label.text = "Email"
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        
        return label
    }()
    
    let emailView = {
       let view = UIView()
        
        view.layer.cornerRadius = 12
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor(named: "E5EBF0")?.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    let emailTextFieldIcon = {
            let imageView = UIImageView()
            
            imageView.image = UIImage(named: "EmailTextFieldIcon")
            imageView.tintColor = UIColor(named: "9CA3AF")
            
            return imageView
        }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        
        textField.backgroundColor = UIColor(named: "TextFieldBackGroundColor")
        textField.placeholder = "Сіздің email"
        textField.borderStyle = .none
        textField.textColor = UIColor(named: "TextColor")
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        
        return textField
    }()
    
    let errorLabel = {
        let label = UILabel()
        
        label.text = "Қате формат"
        label.textColor = UIColor(named: "FF402B")
        label.font = UIFont(name: "SFProDisplay", size: 14)
        
        return label
    }()
    
    let passwordLabel = {
       let label = UILabel()
        
        label.text = "Құпия сөз"
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        
        return label
    }()
    
    let passwordView = {
       let view = UIView()
        
        view.backgroundColor = .clear
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor(named: "E5EBF0")?.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    let passwordTextFieldIcon = {
           let imageView = UIImageView()
            
            imageView.image = UIImage(named: "PasswordIcon")
            imageView.tintColor = UIColor(named: "9CA3AF")
            
            return imageView
            
        }()

    let passwordTextField: UITextField = {
        let textField = UITextField()
        
        textField.backgroundColor = UIColor(named: "TextFieldBackGroundColor")
        textField.placeholder = "Сіздің құпия сөзіңіз"
        textField.isSecureTextEntry = true
        textField.textColor = UIColor(named: "111827")
        textField.borderStyle = .none
        textField.textColor = UIColor(named: "TextColor")
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        
        return textField
    }()
    
    lazy var showPasswordButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "ShowPasswordIcon"), for: .normal)
        button.addTarget(self, action: #selector(showPassButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var signInButton = {
        let button = UIButton()
        
        button.setTitle("Кіру", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.backgroundColor = UIColor(named: "7E2DFC")
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        return button
    }()
    
    let questionLabel = {
       let label = UILabel()
       
        label.text = "Аккаунтыныз жоқ па? "
        label.textColor = UIColor(named: "6B7280")
        label.font = UIFont(name: "SFProDisplay", size: 14)
        
       return label
    }()
    
    lazy var registrationButton = {
       let button = UIButton()
        
        button.setTitle("Тіркелу", for: .normal)
        button.setTitleColor(UIColor(named: "B376F7"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.addTarget(self, action: #selector(registrationTapped), for: .touchUpInside)
        
        return button
    }()
    
    lazy var questoinStack = {
        let stack = UIStackView(arrangedSubviews: [self.questionLabel, self.registrationButton])
        
        stack.alignment = .firstBaseline
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .center
        
        return stack
    }()
    
    let orLabel = {
        let label = UILabel()
        
        label.text = "Немесе"
        label.textColor = UIColor(named: "9CA3AF")
        label.font = UIFont(name: "SFProDisplay", size: 14)
        
        return label
    }()
    
    lazy var signInWithAppleIDButton = {
            var config = UIButton.Configuration.plain()
            
            config.image = UIImage(named: "AppleIcon")?.withRenderingMode(.alwaysOriginal)
            config.imagePlacement = .leading
            config.imagePadding = 10

            let title = "Apple ID-мен тіркеліңіз"
            let font = UIFont(name: "SFProDisplay-Semibold", size: 14) ?? .systemFont(ofSize: 14)
            let color = UIColor(named: "TextColor") ?? .black
            
            let attributedTitle = AttributedString(title, attributes: AttributeContainer([
                .font: font,
                .foregroundColor: color
            ]))
            config.attributedTitle = attributedTitle

            let button = UIButton(configuration: config)
            button.backgroundColor = .white
            button.layer.borderColor = UIColor(named: "E5EBF0")?.cgColor
            button.layer.borderWidth = 1
            button.layer.cornerRadius = 12
            button.clipsToBounds = true

            return button
    }()
    
    lazy var signInWithGoogleButton = {
        var config = UIButton.Configuration.plain()
        
        config.image = UIImage(named: "GoogleIcon")?.withRenderingMode(.alwaysOriginal)
        config.imagePlacement = .leading
        config.imagePadding = 10
        
        let title = "Google-мен тіркеліңіз"
        let font = UIFont(name: "SFProDisplay-Semibold", size: 14) ?? .systemFont(ofSize: 14)
        let color = UIColor(named: "TextColor") ?? .black
        
        let attributedTitle = AttributedString(title, attributes: AttributeContainer([
            .font: font,
            .foregroundColor: color
            ]))
        
        config.attributedTitle = attributedTitle
        
        let button = UIButton(configuration: config)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor(named: "E5EBF0")?.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        
        return button
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "ViewBackGroundColor")
        let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground() // или .configureWithTransparentBackground(), если нужен прозрачный
            appearance.shadowColor = .clear

            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        emailTextField.delegate = self
        passwordTextField.delegate = self

        setupBackArrow()
        
        setupUI()
        localizeLanguage()
        
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(localizeLanguage),
                                                   name: NSNotification.Name("languageChanged"),
                                                   object: nil)
//        updateLayout(true)
        // Do any additional setup after loading the view.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - UI Setup
    
    func setupUI() {
        
        view.addSubview(scrollView)
        scrollView.isScrollEnabled = false
        scrollView.addSubview(contentView)
        
        contentView.addSubview(errorLabel)

        errorLabel.isHidden = true
        
        contentView.addSubviews(signInLabel, signInSubLabel, emailLabel, emailView, passwordLabel, passwordView, signInButton, /*questionLabel,*/ questoinStack, orLabel, signInWithAppleIDButton, signInWithGoogleButton)
        
        emailView.addSubviews(emailTextFieldIcon, emailTextField)
        
        passwordView.addSubviews(passwordTextFieldIcon, passwordTextField, showPasswordButton)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        signInLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(24)
            make.leading.equalToSuperview().inset(24)
        }
        
        signInSubLabel.snp.makeConstraints { (make) in
            make.top.equalTo(signInLabel.snp.bottom)
            make.leading.equalToSuperview().inset(24)
        }
        
        emailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(signInSubLabel.snp.bottom).offset(29)
            make.leading.equalToSuperview().inset(24)
        }
        
        emailView.snp.makeConstraints { (make) in
            make.top.equalTo(emailLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emailView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(24)
        }
        
        passwordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emailView.snp.bottom).offset(13)
            make.leading.equalToSuperview().inset(24)
        }
        
        passwordView.snp.makeConstraints { (make) in
            make.top.equalTo(passwordLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        emailTextFieldIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(44)
            make.trailing.equalToSuperview().inset(16)
        }
        
        passwordTextFieldIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(44)
        }
        
        showPasswordButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }
        
        signInButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordView.snp.bottom).offset(79)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        questoinStack.snp.makeConstraints { (make) in
            make.top.equalTo(signInButton.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        orLabel.snp.makeConstraints { (make) in
            make.top.equalTo(questoinStack.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        signInWithAppleIDButton.snp.makeConstraints { (make) in
            make.top.equalTo(orLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(52)
        }
        
        signInWithGoogleButton.snp.makeConstraints { (make) in
            make.top.equalTo(signInWithAppleIDButton.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(52)
            make.bottom.equalToSuperview().inset(27)
        }
        
    }
    
    //MARK: - Actions
    
    @objc func showPassButtonTapped() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @objc func registrationTapped() {
        let registrationVC = SignUpViewController()
        
        navigationController?.pushViewController(registrationVC, animated: true)
    }
    
    @objc func signUpTapped() {
        let tabBarVC = TabBarViewController()
        
        tabBarVC.modalPresentationStyle = .fullScreen
        self.present(tabBarVC, animated: true, completion: nil)
    }

    //MARK: - Private Methods
    
    private func updateLayout(_ hasError: Bool) {
        if hasError {
            
            errorLabel.isHidden = false
            emailView.layer.borderColor = UIColor(named: "FF402B")?.cgColor
            
            passwordLabel.snp.remakeConstraints { make in
                make.top.equalTo(errorLabel.snp.bottom).offset(16)
                make.leading.equalToSuperview().offset(24)
            }

        } else {
            passwordLabel.snp.remakeConstraints { make in
                make.top.equalTo(emailView.snp.bottom).offset(13)
                make.leading.equalToSuperview().offset(24)
            }
        }
        
        UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
    }

}

//MARK: - UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailView.layer.borderColor = UIColor(named: "9753F0" )?.cgColor
            if errorLabel.isHidden == false {
                emailView.layer.borderColor = UIColor(named: "FF402B")?.cgColor
            }
        }
    }
        
    func textFieldDidEndEditing(_ textField: UITextField) {
            if textField == emailTextField {
                emailView.layer.borderColor = UIColor(named: "E5EBF0")?.cgColor
            }
        }

    @objc private func localizeLanguage() {
        signInLabel.text = "SIGN_IN_LABEL".localized()
        signInSubLabel.text = "SIGN_IN_SUBLABEL".localized()
        emailTextField.placeholder = "YOUR_EMAIL_PLACEHOLDER".localized()
        errorLabel.text = "ERROR_LABEL".localized()
        passwordLabel.text = "PASSWORD_LABEL".localized()
        passwordTextField.placeholder = "YOUR_PASSWORD_PLACEHOLDER".localized()
        signInButton.setTitle("SIGN_IN_BUTTON".localized(), for: .normal)
        questionLabel.text = "QUESTION_LABEL".localized()
        registrationButton.setTitle("REGISTRATION_BUTTON".localized(), for: .normal)
        orLabel.text = "OR_LABEL".localized()
        signInWithAppleIDButton.setTitle("SIGN_IN_WITH_APPLEID_BUTTON".localized(), for: .normal)
        signInWithGoogleButton.setTitle("SIGN_IN_WITH_GOOGLE_BUTTON".localized(), for: .normal)
        }
}
