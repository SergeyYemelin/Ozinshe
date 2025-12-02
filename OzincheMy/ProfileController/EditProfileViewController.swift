//
//  EditProfileViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 12.05.2025.
//

import UIKit
import Localize_Swift
import SVProgressHUD

class EditProfileViewController: UIViewController {

    private var currentProfile: UserProfileResponse?
    
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
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        
        return button
        
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "FFFFFF-111827")

        navigationItem.title = "Жеке деректер"
        
        navigationItem.largeTitleDisplayMode = .inline
        
        navigationItem.hidesBackButton = true
        
        setupBackArrow(style: .black)
        setupUI()
        
        localizeLanguage()
        
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(localizeLanguage),
                                                   name: NSNotification.Name("languageChanged"),
                                                   object: nil)
        
        emailTextField.isEnabled = false

    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            Task {
                await loadProfileAndFillUI()
            }
        }
    
    private func loadProfileAndFillUI() async {

            do {
                let profile = try await UserService.shared.fetchProfile()
                self.currentProfile = profile

                await MainActor.run {

                    self.nameTextField.text = profile.name
                    self.emailTextField.text = profile.user?.email
                    self.phoneTextField.text = profile.phoneNumber
                    self.birthDateTextField.text = profile.birthDate
                }

            } catch {
                print("Ошибка получения профиля:", error)
                await MainActor.run {

                    self.showSimpleAlert(title: "Ошибка", message: "Не удалось загрузить профиль.")
                }
            }

            DispatchQueue.main.async {
            }
        }
    
    @objc private func saveButtonTapped() {
        Task {
            await MainActor.run {
                self.saveChangesButton.isEnabled = false
            }

            let name = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let phone = phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            let birthDateInput = birthDateTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)

            guard let nameUnwrapped = name, !nameUnwrapped.isEmpty else {
                await MainActor.run {
                    self.showSimpleAlert(title: "Ошибка", message: "Введите имя.")
                    self.saveChangesButton.isEnabled = true
                }
                return
            }

            var convertedBirthDate: String? = nil
            if let birthDateInput, !birthDateInput.isEmpty {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yyyy"
                formatter.isLenient = false
                if let date = formatter.date(from: birthDateInput) {

                    let serverFormatter = DateFormatter()
                    serverFormatter.dateFormat = "yyyy-MM-dd"
                    convertedBirthDate = serverFormatter.string(from: date)
                } else {
                    await MainActor.run {
                        self.showSimpleAlert(title: "Ошибка", message: "Введите дату в формате дд.мм.гггг")
                        self.saveChangesButton.isEnabled = true
                    }
                    return
                }
            }

            let dto = UpdateUserProfileRequest(
                id: currentProfile?.id ?? 0,
                name: nameUnwrapped,
                phoneNumber: phone ?? "",
                language: currentProfile?.language ?? "ru",
                birthDate: convertedBirthDate ?? ""
            )

            do {
                await MainActor.run {
                    SVProgressHUD.show()
                }

                let updated = try await UserService.shared.updateProfile(dto)

                self.currentProfile = updated
                await MainActor.run {
                    self.nameTextField.text = updated.name
                    self.phoneTextField.text = updated.phoneNumber
                    self.birthDateTextField.text = birthDateInput
                    self.showSimpleAlert(title: "Успех", message: "Профиль обновлён.")
                }

            } catch {
                print("Ошибка обновления профиля:", error)
                await MainActor.run {
                    self.showSimpleAlert(title: "Ошибка", message: "Не удалось сохранить изменения.")
                }
            }

            await MainActor.run {
                SVProgressHUD.dismiss()
                self.saveChangesButton.isEnabled = true
            }
        }
    }
    
    private func convertToAPIDate(_ text: String) -> String? {
        let input = DateFormatter()
        input.dateFormat = "dd.MM.yyyy"

        let output = DateFormatter()
        output.dateFormat = "yyyy-MM-dd"

        if let date = input.date(from: text) {
            return output.string(from: date)
        }

        return nil
    }
    
    func showSimpleAlert(title: String, message: String) {
            let a = UIAlertController(title: title, message: message, preferredStyle: .alert)
            a.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(a, animated: true)
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
    
    //MARK: Deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

