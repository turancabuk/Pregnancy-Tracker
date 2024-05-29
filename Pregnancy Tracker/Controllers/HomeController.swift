//
//  HomeController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 6.03.2024.
//

import UIKit


class HomeController: UIViewController, UICollectionViewDelegate, OnboardingMovieVieControllerDelegate {
    
        
    var viewModel: HomeViewModel
    let safeAreaView: SafeAreaView
    let profileController: ProfileController
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
            self.safeAreaView.updateUI()
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isFirstLaunch = UserDefaults.standard.bool(forKey: "hasLaunchedBefore1")
        
        if !isFirstLaunch {
            UserDefaults.standard.setValue(true, forKey: "hasLaunchedBefore1")
            UserDefaults.standard.synchronize()
            
            self.showOnboardingMovieView()
        }
    }
    private func showOnboardingMovieView() {
        
        let onboardingMovieViewController = OnboardingMovieViewController()
        onboardingMovieViewController.modalPresentationStyle = .overFullScreen
        onboardingMovieViewController.modalTransitionStyle = .crossDissolve
        onboardingMovieViewController.delegate = self
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView!)
        
        present(onboardingMovieViewController, animated: true)
    }
    private func setupCollectionView() {

        viewModel.setupCollectionView(controller: self)
        collectionView = viewModel.collectionView
        collectionView.delegate = self
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
    func handleCancel() {
        blurEffectView?.removeFromSuperview()
    }
}
extension HomeController {
    fileprivate func setupLayout() {

        let color = #colorLiteral(red: 0.938759625, green: 0.8843975663, blue: 0.8854001164, alpha: 1)
        safeAreaView.setPersonelView(backgroundColor: color)
        tabBarController?.tabBar.backgroundColor = .white
        
        view.addSubview(seperatorView)
        view.addSubview(safeAreaView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(collectionView)
        
        disableAutoResizingMaskConstraints(for: [safeAreaView, seperatorView, scrollView, contentView, collectionView])
        
        NSLayoutConstraint.activate([
            seperatorView.topAnchor.constraint(equalTo: view.topAnchor),
            seperatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            seperatorView.heightAnchor.constraint(equalToConstant: 62),
            seperatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            safeAreaView.topAnchor.constraint(equalTo: seperatorView.bottomAnchor),
            safeAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            safeAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            safeAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            scrollView.topAnchor.constraint(equalTo: safeAreaView.personelView.bottomAnchor, constant: 6),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95),
            collectionView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        view.backgroundColor = .white
    }
    
    fileprivate func disableAutoResizingMaskConstraints(for views: [UIView]) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}
