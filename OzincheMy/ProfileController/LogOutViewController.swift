//
//  ExitViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 27.05.2025.
//

import UIKit
import Localize_Swift

class LogOutViewController: UIViewController {
    
    // MARK: - UI Elements
    
    let backgroundView = UIView()
    let modalView = UIView()
    
    lazy var homeView = {
        let homeView = UIView()
        
        homeView.backgroundColor = UIColor(named: "D1D5DB")
        homeView.layer.cornerRadius = 3
        
        homeView.snp.makeConstraints { make in
            make.width.equalTo(64)
            make.height.equalTo(5)
        }
        
        return homeView
    }()
    
    lazy var logOutLabel = {
        let label = UILabel()
        
        label.text = "Шығу"
        label.textColor = UIColor(named: "111827-FFFFFF")
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        
        return label
    }()
    
    lazy var logOutSubLabel = {
        let sublabel = UILabel()
        
        sublabel.text = "Сіз шынымен аккаунтыныздан"
        sublabel.textColor = UIColor(named: "9CA3AF")
        sublabel.font = UIFont(name: "SFProDisplay-Regular", size: 16)
        
        return sublabel
    }()
    
    lazy var yesExitButton = {
        
        let button = UIButton()
        
        button.backgroundColor = UIColor(named: "7E2DFC")
        button.setTitle("Иә, шығу", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(tappedLogOut), for: .touchUpInside)
        
        return button
    }()
    
    lazy var noExitButton = {
        
        let button = UIButton()
        
        button.backgroundColor = .clear
        button.setTitle("Жоқ", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.setTitleColor(UIColor(named: "5415C6-B376F7"), for: .normal)
        button.layer.cornerRadius = 12
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "FFFFFF-111827")
        
        setupBackground()
        setupModal()
        addDismissGesture()
        
        localizeLanguage()
        
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(localizeLanguage),
                                                   name: NSNotification.Name("languageChanged"),
                                                   object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - UI Setup
    
    func setupBackground() {
        view.backgroundColor = .clear
        
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
        
        modalView.addSubviews(homeView, logOutLabel, logOutSubLabel, yesExitButton, noExitButton)
        
        homeView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21)
            make.centerX.equalTo(modalView)
        }
        
        logOutLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(58)
            make.leading.equalToSuperview().offset(24)
        }
        
        logOutSubLabel.snp.makeConstraints { make in
            make.top.equalTo(logOutLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(24)
        }
        
        yesExitButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.top.equalTo(logOutSubLabel.snp.bottom).offset(32)
            make.left.right.equalToSuperview().inset(24)
        }
        
        noExitButton.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.top.equalTo(yesExitButton.snp.bottom).offset(8)
            make.left.right.equalToSuperview().inset(24)
        }
    }
    
    func addDismissGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        backgroundView.addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handleDissMiss))
        modalView.addGestureRecognizer(panGesture)
    }
    
    @objc private func dismissView() {
        dismiss(animated: true)
    }
    
    // MARK: - Actions
    
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
    
    @objc func tappedLogOut() {
        if let sceneDelegate = UIApplication.shared.connectedScenes
                .first?.delegate as? SceneDelegate {
                sceneDelegate.showOnboardingScreen()
            }
    }
    
    @objc private func localizeLanguage() {
        logOutLabel.text = "LOG_OUT_LABEL".localized()
        logOutSubLabel.text = "LOG_OUT_SUBLABEL".localized()
        yesExitButton.setTitle("YES_EXIT_BUTTON".localized(), for: .normal)
        noExitButton.setTitle("NO_EXIT_BUTTON".localized(), for: .normal)
    }
}
