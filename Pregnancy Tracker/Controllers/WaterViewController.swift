//
//  WaterViewController.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 4.05.2024.
//

import UIKit
import CoreData
import DGCharts

class WaterViewController: UIViewController, WaterReminderViewControllerDelegate {

    var viewModel: WaterViewModel
    var pieChartView: PieChartView
    var blurEffectView: UIVisualEffectView?
    
    var waterLabel: UILabel!
    var coffeeLabel: UILabel!
    var juiceLabel: UILabel!
    var teaLabel: UILabel!

    var waterItem: UIView!
    var coffeeItem: UIView!
    var juiceItem: UIView!
    var teaItem: UIView!
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        if let name = UserDefaults.standard.string(forKey: "userName") {
            label.text = "Hi, \(name)"
        }
        label.textColor = .darkGray
        label.font = FontHelper.customFont(size: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Today, \(viewModel.getCurrentDate())"
        label.font = FontHelper.customFont(size: 16)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var graphicContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        ShadowLayer.setShadow(view: view, color: .black, opacity: 5, offset: .init(width: 0.5, height: 0.5), radius: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        ShadowLayer.setShadow(view: view, color: .black, opacity: 5, offset: .init(width: 0.5, height: 0.5), radius: 12)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var plusButton = createCustomButton(buttonImage: UIImage(named: "plus")!, selector: #selector(handlePlus))
    lazy var alertButton = createCustomButton(buttonImage: UIImage(named: "reminder")!, selector: #selector(handleReminder))
    lazy var backButton = createCustomButton(buttonImage: UIImage(systemName: "chevron.backward")!, selector: #selector(handleBack))
    
    init() {
        self.viewModel = WaterViewModel()
        self.pieChartView = PieChartView()
        super.init(nibName: nil, bundle: nil)
        scheduleResetTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        setupItems()
        setupLayout()
        scheduleResetTimer()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        checkIfResetRequired()
        loadDrinkQunatities()
        updateLabels()
        updateChartData()
        updateAlertButton()

    }
    final func saveDrinkQuantities() {
        
        viewModel.saveDrinkQuantities()
    }
    final func loadDrinkQunatities() {
        
        viewModel.loadDrinkQunatities()
    }
    private func scheduleResetTimer() {
        let calendar = Calendar.current
        let now = Date()
        var resetTime = calendar.date(bySettingHour: 19, minute: 00, second: 0, of: now)!

        if resetTime <= now {
            resetTime = calendar.date(byAdding: .day, value: 1, to: resetTime)!
        }

        let timeInterval = resetTime.timeIntervalSince(now)
        Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(resetDrinkQuantities), userInfo: nil, repeats: false)

        let dailyInterval: TimeInterval = 24 * 60 * 60
        Timer.scheduledTimer(timeInterval: dailyInterval, target: self, selector: #selector(resetDrinkQuantities), userInfo: nil, repeats: true)
    }
    private func checkIfResetRequired() {
           let calendar = Calendar.current
           let now = Date()
           let lastResetDate = UserDefaults.standard.object(forKey: "lastResetDate") as? Date ?? Date.distantPast
           var resetTime = calendar.date(bySettingHour: 22, minute: 35, second: 0, of: lastResetDate)

        if calendar.isDateInToday(lastResetDate) == false || resetTime! <= now {
               resetDrinkQuantities()
           }
    }
    private func updateChartData() {
        let drinkTypes = ["water", "coffee", "juice", "tea"]
        var dataEntries: [PieChartDataEntry] = []

        for type in drinkTypes {
            let value = Double(viewModel.drinkQunatities[type, default: 0])
            let entry = PieChartDataEntry(value: value, label: type.capitalized)
            dataEntries.append(entry)
        }
        let dataSet = PieChartDataSet(entries: dataEntries, label: "")
        let waterColor =  #colorLiteral(red: 0.4244635105, green: 0.7731418014, blue: 0.8198239207, alpha: 1)
        let coffeeColor =  #colorLiteral(red: 0.3430070281, green: 0.6384900212, blue: 0.6003831029, alpha: 1)
        let juiceColor =  #colorLiteral(red: 0.3742775917, green: 0.3643782437, blue: 0.6130426526, alpha: 1)
        let teaColor =  #colorLiteral(red: 0.9988623261, green: 0.1231439188, blue: 0.3038950861, alpha: 1)
        dataSet.colors = [waterColor, coffeeColor, teaColor, juiceColor]
        let data = PieChartData(dataSets: [dataSet])

        pieChartView.data = data
        pieChartView.notifyDataSetChanged()
        ShadowLayer.setShadow(view: pieChartView, color: .black, opacity: 12, offset: .init(width: 0.5, height: 0.5), radius: 5)
    }
    final func updateLabels() {
        waterLabel.text = "\(viewModel.drinkQunatities["water", default: 0]) ml"
        coffeeLabel.text = "\(viewModel.drinkQunatities["coffee", default: 0]) ml"
        juiceLabel.text = "\(viewModel.drinkQunatities["juice", default: 0]) ml"
        teaLabel.text = "\(viewModel.drinkQunatities["tea", default: 0]) ml"
    }
    final func setupItems() {
        (waterItem, waterLabel) = createItems(labelImage: UIImage(named: "water2")!, labelText: "0 ml")
        (juiceItem, juiceLabel) = createItems(labelImage: UIImage(named: "juice1")!, labelText: "0 ml")
        (coffeeItem, coffeeLabel) = createItems(labelImage: UIImage(named: "coffee1")!, labelText: "0 ml")
        (teaItem, teaLabel) = createItems(labelImage: UIImage(named: "tea1")!, labelText: "0 ml")
    }
    @objc private func resetDrinkQuantities() {
        viewModel.resetDrinkQuantities()
        updateLabels()
        updateChartData()
        UserDefaults.standard.set(Date(), forKey: "lastResetDate")
    }
    @objc fileprivate func handlePlus() {
        let addWaterViewController = AddWaterViewController()
        addWaterViewController.modalPresentationStyle = .overFullScreen
        addWaterViewController.modalTransitionStyle = .crossDissolve
        addWaterViewController.delegate = self
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView!)
        
        present(addWaterViewController, animated: true)
    }
    @objc fileprivate func handleReminder() {
        let reminderViewController = WaterReminderViewController()
        reminderViewController.modalPresentationStyle = .overFullScreen
        reminderViewController.modalTransitionStyle = .crossDissolve
        reminderViewController.delegate = self
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = view.bounds
        blurEffectView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView!)
        
        present(reminderViewController, animated: true)
    }
    @objc private func handleBack() {
        dismiss(animated: true)
    }
}
extension WaterViewController: AddWaterViewControllerDelegate {
    
    func updateDrinkQuantity(type: String, quantity: Int) {
        loadDrinkQunatities()
        let previousQuntity = viewModel.drinkQunatities[type] ?? 0
        let newQunatity = previousQuntity + quantity
        viewModel.drinkQunatities[type] = newQunatity
        saveDrinkQuantities()
        updateLabels()
        updateChartData()
        
        let text = "\(newQunatity) ml"
        switch type {
        case "water":
            waterLabel.text = text
        case "coffee":
            coffeeLabel.text = text
        case "juice":
            juiceLabel.text = text
        case "tea":
            teaLabel.text = text
        default:
            print("Unexpected drink type")
            return
        }
        blurEffectView?.removeFromSuperview()
    }
    func handleCancel() {
        blurEffectView?.removeFromSuperview()
    }
    func switchStatusChanged(selected: Bool) {
        
        if selected {
            alertButton.setImage(UIImage(named: "reminder2"), for: .normal)
        }else{
            alertButton.setImage(UIImage(named: "reminder"), for: .normal)
        }
    }
    func updateAlertButton() {
        let switchStatus = UserDefaults.standard.bool(forKey: "switchButtonStatus")
        switchStatusChanged(selected: switchStatus)
    }
}
extension WaterViewController {
    private func createItems(labelImage: UIImage, labelText: String) -> (UIView, UILabel) {
        let imageView = UIImageView(image: labelImage)
        let label = UILabel()
        label.text = labelText
        label.textColor = .black
        label.font = FontHelper.customFont(size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false

        imageView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: imageView.centerXAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 2)
        ])
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return (imageView, label)
    }
    private func createCustomButton(buttonImage: UIImage, selector: Selector) -> UIButton {
        let button = UIButton()
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}
extension WaterViewController {
    private func setupLayout() {
        
        view.addSubview(backButton)
        view.addSubview(nameLabel)
        view.addSubview(dateLabel)
        view.addSubview(graphicContainerView)
        view.addSubview(containerView)
        
        containerView.addSubview(waterItem)
        containerView.addSubview(teaItem)
        containerView.addSubview(juiceItem)
        containerView.addSubview(coffeeItem)

        graphicContainerView.addSubview(pieChartView)
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(plusButton)
        view.addSubview(alertButton)
        
        
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 32),
            backButton.heightAnchor.constraint(equalToConstant: 32),
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 6),
            
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            nameLabel.heightAnchor.constraint(equalToConstant: 36),
            nameLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1/2),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 12),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            dateLabel.widthAnchor.constraint(equalTo: nameLabel.widthAnchor),
            dateLabel.heightAnchor.constraint(equalTo: nameLabel.heightAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            graphicContainerView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 48),
            graphicContainerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/3),
            graphicContainerView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.9),
            graphicContainerView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            pieChartView.centerXAnchor.constraint(equalTo: graphicContainerView.centerXAnchor),
            pieChartView.centerYAnchor.constraint(equalTo: graphicContainerView.centerYAnchor),
            pieChartView.heightAnchor.constraint(equalTo: graphicContainerView.heightAnchor),
            pieChartView.widthAnchor.constraint(equalTo: graphicContainerView.widthAnchor),
            
            containerView.topAnchor.constraint(equalTo: graphicContainerView.bottomAnchor, constant: 12),
            containerView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/5),
            containerView.widthAnchor.constraint(equalTo: graphicContainerView.widthAnchor),
            containerView.centerXAnchor.constraint(equalTo: graphicContainerView.centerXAnchor),
            
            waterItem.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            waterItem.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            waterItem.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 2/5),
            waterItem.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 1/3),

            teaItem.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            teaItem.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            teaItem.widthAnchor.constraint(equalTo: waterItem.widthAnchor),
            teaItem.heightAnchor.constraint(equalTo: waterItem.heightAnchor),
            
            juiceItem.topAnchor.constraint(equalTo: waterItem.bottomAnchor, constant: 12),
            juiceItem.leadingAnchor.constraint(equalTo: waterItem.leadingAnchor),
            juiceItem.widthAnchor.constraint(equalTo: waterItem.widthAnchor),
            juiceItem.heightAnchor.constraint(equalTo: waterItem.heightAnchor),
            
            coffeeItem.topAnchor.constraint(equalTo: teaItem.bottomAnchor, constant: 12),
            coffeeItem.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            coffeeItem.widthAnchor.constraint(equalTo: waterItem.widthAnchor),
            coffeeItem.heightAnchor.constraint(equalTo: waterItem.heightAnchor),
            
            plusButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            plusButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/6),
            plusButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            plusButton.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1/3),
            
            alertButton.topAnchor.constraint(equalTo: graphicContainerView.topAnchor),
            alertButton.heightAnchor.constraint(equalToConstant: 72),
            alertButton.widthAnchor.constraint(equalToConstant: 84),
            alertButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -18)
        ])
    }
}
