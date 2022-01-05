//
//  ViewController.swift
//  Fasts
//
//  Created by evpes on 26.12.2021.
//

import UIKit
import HealthKit
import SnapKit

class MainViewController: UIViewController {
    
    var releaseDate: Date?
    var startCycleDate: Date?
    
    var countdownTimer = Timer()
    
    let healthStore = HKHealthStore()
    
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    var mainView = MainView()
    
    //variables
    var stepCount = 0
    var waterDrunk = 0
    var countDown = "00:00:00"
    
    var currentFastingInterval = 0
    
    var stepsGoal: Int = 10000
    var waterGoal: Int = 3000
    var fastingGoal: Int = 16
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        loadReleaseDate()
        let screensize: CGRect = UIScreen.main.bounds
        screenWidth = screensize.width
        screenHeight = screensize.height
        
        mainView.startFastButton.addTarget(self, action: #selector(startFastButtonTapped), for: .touchUpInside)
        mainView.addLiquidButton.addTarget(self, action: #selector(addLiquidButtonPressed), for: .touchUpInside)
        mainView.addFoodButton.addTarget(self, action: #selector(startEatButtonTapped), for: .touchUpInside)
        
        // Access Step Count
        let healthKitTypes: Set = [ HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)! ]
        // Check for Authorization
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { (bool, error) in
            if (bool) {
                // Authorization Successful
                self.getSteps { (result) in
                    DispatchQueue.main.async {
                        self.stepCount = Int(result)
                        self.mainView.stepsLabel.text = "\(self.stepsGoal - self.stepCount)"
                        self.fillCircleAnimation(type: .steps)
                        //self.stepsLabel.text = String(stepCount)
                    }
                }
            } // end if
        } // end of checking authorization
        
    }
    
    private func fillCircleAnimation(type: ActivityType) {
        
        var currentValue = 0.0
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        switch type {
        case .fasting:
            currentValue = (Double(currentFastingInterval) / Double(fastingGoal * 60 * 60)) / 2
            basicAnimation.toValue = currentValue
            basicAnimation.duration = 3
            mainView.fastingShapeLayer.add(basicAnimation, forKey: "fillFasting")
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { timer in
                self.mainView.fastingShapeLayer.strokeEnd = currentValue
            }
        case .steps:
            currentValue = (Double(stepCount) / Double(stepsGoal) ) / 2
            basicAnimation.toValue = currentValue
            basicAnimation.duration = 1
            mainView.stepsShapeLayer.add(basicAnimation, forKey: "fillSteps")
            Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
                self.mainView.stepsShapeLayer.strokeEnd = currentValue
            }
        case .water:
            currentValue = (Double(waterDrunk) / Double(waterGoal)) / 2
            basicAnimation.toValue = currentValue
            basicAnimation.duration = 2
            mainView.waterShapeLayer.add(basicAnimation, forKey: "fillWater")
            Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { timer in
                self.mainView.waterShapeLayer.strokeEnd = currentValue
            }
            
        }
        
    }
    
    enum ActivityType {
        case fasting
        case steps
        case water
    }
        
    @objc func startFastButtonTapped() {
        mainView.startFastButton.isEnabled = false
        mainView.nextFastLabel.text = "until your mext eat time:"
        mainView.canEatLabel.text = "you can't eat now"
        releaseDate = Date.init(timeIntervalSinceNow: 60 * 60 * Double(fastingGoal))
        saveReleaseDate()
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func startEatButtonTapped() {
        currentFastingInterval = 0
        mainView.startFastButton.isEnabled = true
        mainView.nextFastLabel.text = "until your next fast:"
        mainView.canEatLabel.text = "you can eat now"
        releaseDate = Date.init(timeIntervalSinceNow: 60 * 60 * Double(24 - fastingGoal))
        saveReleaseDate()
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        let currentDate = Date()
        let calendar = Calendar.current
        var sign = ""
        let diffDateComponents = calendar.dateComponents([.hour,.minute,.second], from: currentDate, to: releaseDate!)
        let hour = abs(diffDateComponents.hour ?? 0), minute = abs(diffDateComponents.minute ?? 0), seconds = abs(diffDateComponents.second ?? 0)
        if (diffDateComponents.hour ?? 0) < 0 || (diffDateComponents.minute ?? 0) < 0 || (diffDateComponents.second ?? 0) < 0 {
            sign = "-"
        } else {
            sign = ""
        }
        currentFastingInterval += 1
        fillCircleAnimation(type: .fasting)
        mainView.timeNextFastLabel.text = "\(sign) \(hour):\(minute):\(seconds)"
    }
    
    func loadCurrentCycleDuration() {
        
        if let startCycleDate = startCycleDate {
            let currentDate = Date()
            let calendar = Calendar.current
            let diffDateComponents = calendar.dateComponents([.second], from: startCycleDate, to: currentDate)
            currentFastingInterval = diffDateComponents.second ?? 0
        }
        
    }
    
    @objc func addLiquidButtonPressed() {
        setWhiteBacgroundView()
        mainView.waterAlertView = WaterAlertView()
        mainView.waterAlertView?.layer.cornerRadius = 8
        mainView.waterAlertView?.layer.shadowColor = UIColor.black.cgColor
        mainView.waterAlertView?.layer.shadowOpacity = 0.5
        mainView.waterAlertView?.layer.shadowOffset = .zero
        mainView.waterAlertView?.layer.shadowRadius = 10
        mainView.addSubview(mainView.waterAlertView!)
        mainView.waterAlertView?.delegate = self
        
        mainView.waterAlertView!.snp.makeConstraints { make in
            make.center.equalTo(view.snp.center)
            make.height.equalTo(168)
            make.width.equalTo(screenWidth - 56)
        }
        //waterAlertView?.layer.shadowPath = UIBezierPath(rect: waterAlertView!.bounds).cgPath
        
    }
    
    func setWhiteBacgroundView() {
        mainView.blankView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        mainView.addSubview(mainView.blankView)
        mainView.blankView.snp.makeConstraints { make in
            make.left.top.right.bottom.equalTo(view)
        }
    }
    
    func saveReleaseDate() {
        let defaults = UserDefaults.standard
        defaults.set(releaseDate, forKey: "releaseDate")
    }
    
    func loadReleaseDate() {
        print("loading releaseDate")
        let defaults = UserDefaults.standard
        guard let storedDate = defaults.object(forKey: "releaseDate") as? Date else {
            return
        }
        print("releaseDate is \(storedDate)")
        releaseDate = storedDate
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        
    }
    
    func getSteps(completion: @escaping (Double) -> Void) {
        guard let type = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }
        
        let now = Date()
        let startOfDay = Calendar.current.startOfDay(for: now)
        var interval = DateComponents()
        interval.day = 1
        
        let query = HKStatisticsCollectionQuery(quantityType: type, quantitySamplePredicate: nil, options: [.cumulativeSum], anchorDate: startOfDay, intervalComponents: interval)
        query.initialResultsHandler = { _, result, error in
            var resultCount = 0.0
            result!.enumerateStatistics(from: startOfDay, to: now) { statistics, _ in
                if let sum = statistics.sumQuantity() {
                    resultCount = sum.doubleValue(for: HKUnit.count())
                }
                
                DispatchQueue.main.async {
                    completion(resultCount)
                }
            }
            
        }
        
        query.statisticsUpdateHandler = { query, statistics, statisticsCollection, error in
            
            if let sum = statistics?.sumQuantity() {
                let resultCount = sum.doubleValue(for: HKUnit.count())
                
                DispatchQueue.main.async {
                    completion(resultCount)
                }
            }
            
        }
        
        healthStore.execute(query)
        
    }
    
    
}

extension MainViewController: WaterAlertDelegate {
    func addWater(ml: Int) {
        waterDrunk += ml
        mainView.leftToDrinkLabel.text = "\(waterGoal - waterDrunk) ml"
        fillCircleAnimation(type: .water)
    }
    
    func closeButtonTapped() {
        mainView.waterAlertView!.removeFromSuperview()
        mainView.blankView.removeFromSuperview()
    }
    
    
}




