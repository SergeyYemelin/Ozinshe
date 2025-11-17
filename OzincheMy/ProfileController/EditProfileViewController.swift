//
//  EditProfileViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 12.05.2025.
//

import UIKit
import Localize_Swift

class EditProfileViewController: UIViewController {

    //MARK: - UI Elements
    
    lazy var yourNameLabel = {
       let label = UILabel()
        
        label.text = "Сіздің атыңыз"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    
    lazy var nameTextField = {
       
        let textField = UITextField()
        
        textField.backgroundColor = .clear
        textField.attributedPlaceholder = NSAttributedString(
            string: "Атыңынызды еңгізіңіз...",
            attributes: [
                .foregroundColor: UIColor(named: "9CA3AF")!,
                .font: UIFont(name: "SFProDisplay-Regular", size: 16)!
            ]
        )
        
        textField.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        textField.textColor = UIColor(named: "111827-FFFFFF")
        
        return textField
    }()
    
    lazy var emailLabel = {
       
        let label = UILabel()
        
        
        label.text = "Email"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var emailTextField = {
       
        let textField = UITextField()
        
        textField.backgroundColor = .clear
        textField.attributedPlaceholder = NSAttributedString(
            string: "Электрондық поштаңызды енгізіңіз...",
            attributes: [
                .foregroundColor: UIColor(named: "9CA3AF")!,
                .font: UIFont(name: "SFProDisplay-Regular", size: 16)!
            ]
        )
        
        textField.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        textField.textColor = UIColor(named: "111827-FFFFFF")
        
        return textField
    }()
    
    lazy var phoneLabel = {
       
        let label = UILabel()
        
        
        label.text = "Телефон"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var phoneTextField = {
       
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.attributedPlaceholder = NSAttributedString(
            string: "Телефон нөміріңізді енгізіңіз...",
            attributes: [
                .foregroundColor: UIColor(named: "9CA3AF")!,
                .font: UIFont(name: "SFProDisplay-Regular", size: 16)!
            ]
        )
        
        textField.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        textField.textColor = UIColor(named: "111827-FFFFFF")
        
        return textField
    }()
    
    lazy var birthDateLabel = {
       
        let label = UILabel()
        
        label.text = "Туылған күні"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(named: "9CA3AF")
        
        return label
    }()
    
    lazy var birthDateTextField = {
       
        let textField = UITextField()
        
        textField.backgroundColor = .clear
        textField.attributedPlaceholder = NSAttributedString(
            string: "Туған күніңізді енгізіңіз...",
            attributes: [
                .foregroundColor: UIColor(named: "9CA3AF")!,
                .font: UIFont(name: "SFProDisplay-Regular", size: 16)!
            ]
        )
        
        textField.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        textField.textColor = UIColor(named: "111827-FFFFFF")
        
        return textField
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
        
        view.backgroundColor = UIColor(named: "FFFFFF-111827")

        navigationItem.title = "Жеке деректер"
        if #available(iOS 17.0, *) {
            navigationItem.largeTitleDisplayMode = .inline
        } else {
            // Fallback on earlier versions
        }
        navigationItem.hidesBackButton = true
        
        setupBackArrow()
        setupUI()
        
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
    
    func setupUI() {
        view.addSubviews(yourNameLabel, nameTextField, emailLabel, emailTextField, phoneLabel, phoneTextField, birthDateLabel, birthDateTextField, saveChangesButton)
        
        yourNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(24)
        }
        
        nameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(yourNameLabel.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(24)
        }
        
        var separatorLines: [UIView] = []
        var heightButton = 89

        for _ in 0..<4 {
            let separatorLine = makeSeparatorLine()
            separatorLines.append(separatorLine)
            view.addSubview(separatorLine)
            
            separatorLine.snp.makeConstraints { make in
                make.height.equalTo(1)
                make.left.right.equalToSuperview().inset(24)
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(heightButton)
            }
            
            heightButton += 89
        }
        
        emailLabel.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLines[0].snp.bottom).offset(24)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(24)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailLabel.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(24)
        }
        
        phoneLabel.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLines[1].snp.bottom).offset(24)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(24)
        }
        
        phoneTextField.snp.makeConstraints { (make) in
            make.top.equalTo(phoneLabel.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(24)
        }
        
        birthDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(separatorLines[2].snp.bottom).offset(24)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(24)
        }
        
        birthDateTextField.snp.makeConstraints { (make) in
            make.top.equalTo(birthDateLabel.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(24)
        }
        
        saveChangesButton.snp.makeConstraints { (make) in
            make.height.equalTo(56)
            make.bottom.equalTo(view.snp.bottom).inset(42)
            make.left.right.equalToSuperview().inset(24)
        }
    }
    
    //MARK: - Private UI Helpers
    
   private func makeSeparatorLine() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(named: "D1D5DB")
        return view
    }
    
    @objc func localizeLanguage() {
        navigationItem.title = "EDIT_PROFILE_TITLE".localized()
        yourNameLabel.text = "YOUR_NAME_LABEL".localized()
        nameTextField.placeholder = "ENTER_YOUR_NAME_PLACEHOLDER".localized()
        emailTextField.placeholder = "ENTER_YOUR_EMAIL_PLACEHOLDER".localized()
        phoneLabel.text = "PHONE_LABEL".localized()
        phoneTextField.placeholder = "ENTER_YOUR_PHONE_NUMBER_PLACEHOLDER".localized()
        birthDateLabel.text = "BIRTH_DATE_LABEL".localized()
        birthDateTextField.placeholder = "ENTER_YOUR_BIRTHDAY_PLACEHOLDER".localized()
        saveChangesButton.setTitle("SAVE_CHANGES_BUTTON".localized(), for: .normal)
        }
    
}

