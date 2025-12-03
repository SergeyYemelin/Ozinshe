//
//  RegistrationViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 01.07.2025.
//

import UIKit
import SnapKit
import SVProgressHUD
import Alamofire
import SwiftyJSON
import Localize_Swift

class SignUpViewController: UIViewController {
    
    //MARK: UI Elements
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    let registrationLabel = {
       let label = UILabel()
        
        label.text = "Тіркелу"
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        
        return label
    }()
    
    let registrationSubLabel = {
       let label = UILabel()
        
        label.text = "Деректерді толтырыңыз"
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
        view.backgroundColor = UIColor(named: "FFFFFF-1C2431")
        view.layer.borderColor = UIColor(named: "E5EBF0-374151")?.cgColor
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
        
        textField.keyboardType = .asciiCapable
        
        textField.backgroundColor = .clear
        textField.placeholder = "Сіздің email"
        textField.borderStyle = .none
        textField.textColor = UIColor(named: "TextColor")
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        
        return textField
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
        
        view.backgroundColor = UIColor(named: "FFFFFF-1C2431")
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor(named: "E5EBF0-374151")?.cgColor
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
        
        textField.keyboardType = .asciiCapable
        
        textField.backgroundColor = .clear
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
    
    let repeatPasswordLabel = {
       let label = UILabel()
        
        label.text = "Құпия сөзді қайталаңыз"
        label.textColor = UIColor(named: "TextColor")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 14)
        
        return label
    }()
    
    let repeatPasswordView = {
       let view = UIView()
        
        view.backgroundColor = UIColor(named: "FFFFFF-1C2431")
        view.layer.cornerRadius = 12
        view.layer.borderColor = UIColor(named: "E5EBF0-374151")?.cgColor
        view.layer.borderWidth = 1
        
        return view
    }()
    
    let repeatPasswordTextFieldIcon = {
           let imageView = UIImageView()
            
            imageView.image = UIImage(named: "PasswordIcon")
            imageView.tintColor = UIColor(named: "9CA3AF")
            
            return imageView
            
        }()

    let repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        
        textField.keyboardType = .asciiCapable
        
        textField.backgroundColor = .clear
        textField.placeholder = "Сіздің құпия сөзіңіз"
        textField.isSecureTextEntry = true
        textField.textColor = UIColor(named: "111827")
        textField.borderStyle = .none
        textField.textColor = UIColor(named: "TextColor")
        textField.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        
        return textField
    }()
    
    lazy var showRepeatPasswordButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "ShowPasswordIcon"), for: .normal)
        button.addTarget(self, action: #selector(showRepeatPassButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    let errorLabel = {
        let label = UILabel()
        
        label.text = "Мұндай email-ы бар пайдаланушы тіркелген"
        label.textColor = UIColor(named: "FF402B")
        label.font = UIFont(name: "SFProDisplay", size: 14)
        
        return label
    }()
    
    lazy var registrationButton = {
        let button = UIButton()
        
        button.setTitle("Тіркелу", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Bold", size: 16)
        button.backgroundColor = UIColor(named: "7E2DFC")
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        
        return button
    }()
    
    let questionLabel = {
       let label = UILabel()
       
        label.text = "Сізде аккаунт бар ма? "
        label.textColor = UIColor(named: "6B7280")
        label.font = UIFont(name: "SFProDisplay", size: 14)
        
       return label
    }()
    
    lazy var toSignInVCButton = {
       let button = UIButton()
        
        button.setTitle("Кіру", for: .normal)
        button.setTitleColor(UIColor(named: "B376F7"), for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.addTarget(self, action: #selector(toSignUpVC), for: .touchUpInside)
        
        return button
    }()
    
    lazy var questoinStack = {
        let stack = UIStackView(arrangedSubviews: [self.questionLabel, self.toSignInVCButton])
        
        stack.alignment = .firstBaseline
        stack.axis = .horizontal
        stack.spacing = 0
        stack.alignment = .center
        
        return stack
    }()

//MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "FFFFFF-111827")
        let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(named: "FFFFFF-111827")
            appearance.shadowColor = .clear

            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        setupBackArrow(style: .black)
        
        setupUI()
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
        
        view.addSubview(scrollView)
        scrollView.isScrollEnabled = false
        scrollView.addSubview(contentView)

        errorLabel.isHidden = true
        
        contentView.addSubviews(registrationLabel, registrationSubLabel, emailLabel, emailView, passwordLabel, passwordView, repeatPasswordLabel, repeatPasswordView, errorLabel, registrationButton, questoinStack)
        
        emailView.addSubviews(emailTextFieldIcon, emailTextField)
        
        passwordView.addSubviews(passwordTextFieldIcon, passwordTextField, showPasswordButton)
        
        repeatPasswordView.addSubviews(repeatPasswordTextFieldIcon, repeatPasswordTextField, showRepeatPasswordButton)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        registrationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
            make.leading.equalToSuperview().inset(24)
        }
        
        registrationSubLabel.snp.makeConstraints { (make) in
            make.top.equalTo(registrationLabel.snp.bottom)
            make.leading.equalToSuperview().inset(24)
        }
        
        emailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(registrationSubLabel.snp.bottom).offset(29)
            make.leading.equalToSuperview().inset(24)
        }
        
        emailView.snp.makeConstraints { (make) in
            make.top.equalTo(emailLabel.snp.bottom).offset(4)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
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
        
        repeatPasswordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(passwordView.snp.bottom).offset(13)
            make.leading.equalToSuperview().inset(24)
        }
        
        repeatPasswordView.snp.makeConstraints { (make) in
            make.top.equalTo(repeatPasswordLabel.snp.bottom).offset(4)
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
        
        repeatPasswordTextFieldIcon.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        repeatPasswordTextField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(44)
        }
        
        showRepeatPasswordButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(16)
        }
        
        errorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(repeatPasswordView.snp.bottom).offset(31)
            make.centerX.equalToSuperview()
        }
        
        registrationButton.snp.makeConstraints { (make) in
            make.top.equalTo(repeatPasswordView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
        
        questoinStack.snp.makeConstraints { (make) in
            make.top.equalTo(registrationButton.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(27)
        }
        
    }
    
    //MARK: - Actions
    
    @objc func showPassButtonTapped() {
        passwordTextField.isSecureTextEntry = !passwordTextField.isSecureTextEntry
    }
    
    @objc func showRepeatPassButtonTapped() {
        repeatPasswordTextField.isSecureTextEntry = !repeatPasswordTextField.isSecureTextEntry
    }
    
    @objc func signUpTapped() {
        let signUpEmail = emailTextField.text!
        let signUpPassword = passwordTextField.text!
        let confirmPassword = repeatPasswordTextField.text!
        
        if signUpPassword == confirmPassword {
            
        SVProgressHUD.show()
        let parameters = ["email": signUpEmail, "password": signUpPassword]
        AF.request(URLs.SIGN_UP_URL, method: .post, parameters: parameters, encoding: JSONEncoding.default).responseData { response in
            
        SVProgressHUD.dismiss()
        var resultString = ""
            if let data = response.data {
                resultString = String(data: data, encoding: .utf8)!
                print(resultString)
            }
            
            if response.response?.statusCode == 200 {
                let json = JSON(response.data!)
                print("JSON: \(json)")
            
                if let token = json["accessToken"].string {
                    Storage.sharedInstance.accessToken = token
                    UserDefaults.standard.set(token, forKey: "accessToken")
                    self.startApp()
                } else {
                    SVProgressHUD.showError(withStatus: "CONNECTION_ERROR".localized())
                }
            } else {
                var ErrorString = "CONNECTION_ERROR".localized()
                    if let sCode = response.response?.statusCode {
                        ErrorString = ErrorString + "\(sCode)"
                    }
                    ErrorString = ErrorString + "\(resultString)"
                    SVProgressHUD.showError(withStatus: "\(ErrorString)")
                }
            }
            print("Registration is successful")
        } else {
            showAlert(message: "Try again")
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func startApp() {
    
        let tabViewController = TabBarViewController()
        
        tabViewController.modalPresentationStyle = .fullScreen
        self.present(tabViewController, animated: true, completion: nil)
    }

    
    
    @objc func toSignUpVC() {
        let signUpVC = SignInViewController()
        
        navigationController?.pushViewController(signUpVC, animated: true)
    }

    //MARK: - Private Methods
    
    private func updateLayout(hasError: Bool) {
        if hasError {
            
            errorLabel.isHidden = false
            
            registrationButton.snp.remakeConstraints { make in
                make.top.equalTo(errorLabel.snp.bottom).offset(40)
                make.leading.trailing.equalToSuperview().inset(24)
                make.height.equalTo(56)
            }

        } else {
            registrationButton.snp.remakeConstraints { make in
                make.top.equalTo(repeatPasswordView.snp.bottom).offset(40)
                make.leading.trailing.equalToSuperview().inset(24)
                make.height.equalTo(56)
            }
        }
        
        UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
    }
    
    @objc private func localizeLanguage() {
        registrationLabel.text = "REGISTRATION_LABEL".localized()
        registrationSubLabel.text = "REGISTRATION_SUBLABEL".localized()
        emailTextField.placeholder = "YOUR_EMAIL_PLACEHOLDER".localized()
        passwordLabel.text = "PASSWORD_LABEL".localized()
        passwordTextField.placeholder = "YOUR_PASSWORD_PLACEHOLDER".localized()
        repeatPasswordLabel.text = "REPEAT_PASSWORD_LABEL".localized()
        errorLabel.text = "ERROR_LABEL".localized()
        registrationButton.setTitle("REGISTRATION_BUTTON".localized(), for: .normal)
        questionLabel.text = "QUESTION_LABEL_SIGN_UP".localized()
        toSignInVCButton.setTitle("TO_SIGN_IN_VC_BUTTON".localized(), for: .normal)
        }
}

