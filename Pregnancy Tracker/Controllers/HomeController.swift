//
//  HomeController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit


class HomeController: UIViewController, UICollectionViewDelegate, OnboardingMoviewViewControllerDelegate {
    
        
    var viewModel: HomeViewModel
    let safeAreaView: SafeAreaView
    let profileController: ProfileController
    let advertView: AdvertView
    let scrollView = UIScrollView()
    let contentView = UIView()
    var collectionView: UICollectionView!
    var blurEffectView: UIVisualEffectView?

    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.938759625, green: 0.8843975663, blue: 0.8854001164, alpha: 1)
        return view
    }()
    
    init() {
        self.viewModel = HomeViewModel()
        self.safeAreaView = SafeAreaView()
        self.profileController = ProfileController()
        self.advertView = AdvertView()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setupCollectionView()
        setupLayout()
        safeAreaView.viewModel = SafeAreaViewModel()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.showOnboardingMovieView()
            self.safeAreaView.updateUI()
        }
    }
    private func setupCollectionView() {

        viewModel.setupCollectionView(controller: self)
        collectionView = viewModel.collectionView
        collectionView.delegate = self
    }
    private func showOnboardingMovieView() {
        
        let onboardingMoviewViewController = OnboardingMoviewViewController()
        onboardingMoviewViewController.modalPresentationStyle = .overFullScreen
        onboardingMoviewViewController.modalTransitionStyle = .crossDissolve
        onboardingMoviewViewController.delegate = self
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView!)
        
        present(onboardingMoviewViewController, animated: true)
    }
    private func applyInitialSnapshot(){
        
        viewModel.applyInitialSnapshot()
    }
    private func createCompositionalLayout() -> UICollectionViewLayout {
        
        viewModel.createCompositionalLayout()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewModel.didSelect(collectionView, didSelectItemAt: indexPath, viewController: self)
    }
    @objc private func getButtonTapped() {
        
        viewModel.advertViewContact()
    }
    func handleCancel() {
        blurEffectView?.removeFromSuperview()
    }
}
extension HomeController {
    fileprivate func setupLayout() {

        let color = #colorLiteral(red: 0.938759625, green: 0.8843975663, blue: 0.8854001164, alpha: 1)
        safeAreaView.setPersonelView(backgroundColor: color)
        tabBarController?.tabBar.backgroundColor = .white
        advertView.getButton.addTarget(self, action: #selector(getButtonTapped), for: .touchUpInside)
        
        view.addSubview(safeAreaView)
        view.addSubview(seperatorView)
        view.addSubview(scrollView)
        view.addSubview(contentView)
        contentView.addSubview(collectionView)
        contentView.addSubview(advertView)
        
        disableAutoResizingMaskConstraints(for: [safeAreaView, seperatorView, scrollView, contentView, advertView, collectionView])
        
        NSLayoutConstraint.activate([
            safeAreaView.topAnchor.constraint(equalTo: seperatorView.bottomAnchor, constant: -32),
            safeAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            safeAreaView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            safeAreaView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: safeAreaView.personelView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaView.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            seperatorView.topAnchor.constraint(equalTo: view.topAnchor),
            seperatorView.leadingAnchor.constraint(equalTo: safeAreaView.leadingAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 26),
            seperatorView.trailingAnchor.constraint(equalTo: safeAreaView.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 700),
            
            advertView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 12),
            advertView.widthAnchor.constraint(equalTo: collectionView.widthAnchor, constant: -6),
            advertView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            advertView.heightAnchor.constraint(equalToConstant: 40),
            
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -40),

        ])
        
        if let lastView = contentView.subviews.last {
            NSLayoutConstraint.activate([
                lastView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            ])
        }
        safeAreaView.backgroundColor = .white
    }
    fileprivate func disableAutoResizingMaskConstraints(for views: [UIView]) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}


