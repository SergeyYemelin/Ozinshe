//
//  OnBoardingViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 22.06.2025.
//

import UIKit
import SnapKit

class OnBoardingViewController: UIViewController {
    
//    var arraySlides = [["firstSlide", "ÖZINŞE-ге қош келдің!", "Фильмдер, телехикаялар, ситкомдар, анимациялық жобалар, телебағдарламалар мен реалити-шоулар, аниме және тағы басқалары"],["secondSlide", "ÖZINŞE-ге қош келдің!", "Кез келген құрылғыдан қара. Сүйікті фильміңді  қосымша төлемсіз телефоннан, планшеттен, ноутбуктан қара"],["thirdSlide", "ÖZINŞE-ге қош келдің!", "Тіркелу оңай. Қазір тіркел де қалаған фильміңе қол жеткіз"]]
    
    let slidesArray = [
        OnboardingSlide(imageName: "firstSlide", /*overlayName: "firstSlideOverlay",*/ localizedTextKey: "SLIDE1_LABEL"),
        OnboardingSlide(imageName: "secondSlide", /*overlayName: "secondSlideOverlay",*/ localizedTextKey: "SLIDE2_LABEL"),
        OnboardingSlide(imageName: "thirdSlide", /*overlayName: "thirdSlideOverlay",*/ localizedTextKey: "SLIDE3_LABEL")
    ]
    
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            updatePageControlImages()
        }
    }
    
    //MARK: - UI Elements
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(OnBoardingCell.self, forCellWithReuseIdentifier: OnBoardingCell.identifier)
        
        cv.backgroundColor = .clear
        
        cv.contentInsetAdjustmentBehavior = .never
        cv.isPagingEnabled = true
        cv.isScrollEnabled = true
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    let pageControl = {
        let pc = UIPageControl()
        pc.numberOfPages = 3
        pc.tintColor = .black
        pc.currentPage = 0
        pc.currentPageIndicatorTintColor = UIColor(named: "B376F7")
        pc.pageIndicatorTintColor = UIColor(named: "D1D5DB")
        
        pc.contentVerticalAlignment = .center
        pc.contentHorizontalAlignment = .center
        
        return pc
    }()
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.title = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "FFFFFF-111827")
        
        setupUI()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        // Do any additional setup after loading the view.
        
        updatePageControlImages()
        
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - UI Setup
    
    func setupUI() {
        view.addSubviews(collectionView, pageControl)
        
        collectionView.snp.makeConstraints {make in
            make.top.bottom.leading.trailing.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints {make in
            make.bottom.equalToSuperview().inset(152)
            make.centerX.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    //MARK: - Navigation
    
    @objc func nextButtonTouched() {
        let signInVC = SignInViewController()
        navigationController?.pushViewController(signInVC, animated: true)
        
//        let tabBarVC = TabBarViewController()
//        tabBarVC.modalPresentationStyle = .fullScreen
//        self.present(tabBarVC, animated: true, completion: nil)

    }
    
    //MARK: - Private Methods
    
    private func updatePageControlImages() {
        
        for index in 0..<pageControl.numberOfPages {
            let imageName = index == currentPage ? "CurrentPageIndicator" : "PageIndicator"
            if let image = UIImage(named: imageName) {
                pageControl.setIndicatorImage(image, forPage: index)
                
            }
        }
    }
}

//MARK: - UICollectionViewDelegate & UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension OnBoardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slidesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnBoardingCell.identifier, for: indexPath) as! OnBoardingCell
        
        let slide = slidesArray[indexPath.item]
        cell.configure(with: slide)
        
//        cell.slideImage.image = UIImage(named: arraySlides[indexPath.row][0])
//        cell.welcomeLabel.text = arraySlides[indexPath.row][1]
//        cell.fullInfoLabel.text = arraySlides[indexPath.row][2]
        
        cell.skipButton.layer.cornerRadius = 8
        if indexPath.row == 2 {
            cell.skipButton.isHidden = true
            cell.nextButton.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        }

        cell.nextButton.layer.cornerRadius = 12
        if indexPath.row != 2 {
            cell.nextButton.isHidden = true
            cell.skipButton.addTarget(self, action: #selector(nextButtonTouched), for: .touchUpInside)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)

        currentPage = Int(pageIndex)
    }
}
