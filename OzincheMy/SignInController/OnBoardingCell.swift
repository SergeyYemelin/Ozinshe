//
//  OnBoardingCellCollectionViewCell.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 22.06.2025.
//

import UIKit
import Localize_Swift

class OnBoardingCell: UICollectionViewCell {
    
    static let identifier = String(describing: OnBoardingCell.self)
    
    //MARK: - UI Elements
    
    let slideImage = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "firstSlide")
        
        return imageView
    }()
    
    let overlayView = {
       let overlay = UIImageView()
        
        overlay.image = UIImage(named: "firstSlideOverlay")
        
        return overlay
    }()
    
    let welcomeLabel = {
       let label = UILabel()
        label.text = "ÖZINŞE-ге қош келдің!"
        label.font = UIFont(name: "SFProDisplay-Bold", size: 24)
        label.textColor = UIColor(named: "111827-FFFFFF")
        label.textAlignment = .center
        label.numberOfLines = 0
        
        return label
    }()
    
    let fullInfoLabel = {
        let label = UILabel()
        label.text = "Фильмдер, телехикаялар, ситкомдар, анимациялық жобалар, телебағдарламалар мен реалити-шоулар, аниме және тағы басқалары"
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 14)
        label.textColor = UIColor(named: "6B7280")
        label.textAlignment = .center
        label.numberOfLines = 4
        
        return label
    }()
    
    lazy var skipButton = {
       let button = UIButton()
        button.backgroundColor = UIColor(named: "F9FAFB-111827")
        button.setTitle("Өткізу", for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 12)
        button.setTitleColor(UIColor(named: "111827-FFFFFF"), for: .normal)
        button.layer.cornerRadius = 8
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16)
        
        return button
    }()
    
    lazy var nextButton = {
       
        let button = UIButton()
        
        button.backgroundColor = UIColor(named: "7E2DFC")
        button.setTitle("Әрі қарай", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProDisplay-Semibold", size: 16)
        button.layer.cornerRadius = 12
        
        return button
        
    }()
    
    //MARK: - Initializers
    
    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        
        setupUI()
        localizeLanguage()
        
        NotificationCenter.default.addObserver(self,
                                                   selector: #selector(localizeLanguage),
                                                   name: NSNotification.Name("languageChanged"),
                                                   object: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - UI Setup
    
    func setupUI() {
        contentView.addSubviews(slideImage, overlayView, skipButton, welcomeLabel, fullInfoLabel, nextButton)
        
        slideImage.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.62)        }
        
        overlayView.snp.makeConstraints { (make) in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.71)
        }
        
        skipButton.snp.makeConstraints { (make) in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).inset(16)
            make.trailing.equalTo(contentView.snp.trailing).inset(16)
            make.size.equalTo(CGSize(width: 70, height: 24))
        }
        
        welcomeLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(slideImage.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        fullInfoLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(welcomeLabel.snp.bottom).offset(24)
        }
        
        nextButton.snp.makeConstraints { (make) in
            make.height.equalTo(56)
            make.bottom.equalToSuperview().inset(72)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
    
    //MARK: - Private Methods
    
    func configure(with slide: OnboardingSlide) {
        slideImage.image = UIImage(named: slide.imageName)
        fullInfoLabel.text = slide.localizedTextKey.localized(lang: Localize.currentLanguage())
    }
    
    @objc private func localizeLanguage() {
        skipButton.setTitle("SKIP_BUTTON".localized(), for: .normal)
        welcomeLabel.text = "WELCOME_LABEL".localized(lang: Localize.currentLanguage())
        nextButton.setTitle("NEXT_BUTTON".localized(), for: .normal)
    }
}
