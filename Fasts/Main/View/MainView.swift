//
//  MainView.swift
//  Fasts
//
//  Created by evpes on 03.01.2022.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    let blankView = UIView()
    
    let fastingShapeLayer = CAShapeLayer()
    let waterShapeLayer = CAShapeLayer()
    let stepsShapeLayer = CAShapeLayer()
    
    
    //fasting block labels
    var nextFastLabel: UILabel!
    var timeNextFastLabel: UILabel!
    var canEatLabel: UILabel!
    
    //water block labels
    var leftToDrinkTxtLabel: UILabel!
    var leftToDrinkLabel: UILabel!
    var drinkGoalLabel: UILabel!
    
    //steps block labels
    var leftToGoTxtLabel: UILabel!
    var stepsLabel: UILabel!
    var stepsGoalLabel: UILabel!
    
    //edit button labels
    var editButton: UIButton!
    
    //action buttons
    var startFastButton: UIButton!
    var addLiquidButton: UIButton!
    var addFoodButton: UIButton!
    var addMoodButton: UIButton!
    
    //alert views
    var waterAlertView: WaterAlertView?
    
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createSubViews()
    }
    
    func createSubViews() {
                
        let screensize: CGRect = UIScreen.main.bounds
        screenWidth = screensize.width
        screenHeight = screensize.height
        
        self.backgroundColor = .white
        //print("screenWidth = \(screenWidth) screenHeight = \(screenHeight)")
        
        var scrollView: UIScrollView!
        //scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        scrollView = UIScrollView()
        if screenHeight < 850 && screenHeight > 800 {
            scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + 1)
        } else if screenHeight < 800 && screenHeight > 570 {
            scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + 50)
        } else if screenHeight < 570 {
            scrollView.contentSize = CGSize(width: screenWidth, height: screenHeight + 90)
        }
        
        
        self.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(self)
        }
        
        let fastingRadius = screenHeight * 0.25//self.frame.height * 0.25
        let waterRadius = fastingRadius - 48
        let stepRadius = waterRadius - 48
        let yCircleCenter = screenHeight/3 //self.frame.height/3 + 35
        let sectionHeight = fastingRadius * 2 / 3
        
        //add track layer
        let fastingTrackLayer = CAShapeLayer()
        let fastingCircularPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: yCircleCenter ), radius: fastingRadius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        fastingTrackLayer.path = fastingCircularPath.cgPath
        fastingTrackLayer.strokeColor = K.colors.lightGreenColor.cgColor
        fastingTrackLayer.lineWidth = 48
        fastingTrackLayer.fillColor = UIColor.clear.cgColor
        fastingTrackLayer.lineCap = .round
        
        //shapeLayer
        fastingShapeLayer.path = fastingCircularPath.cgPath
        fastingShapeLayer.strokeColor = K.colors.greenColor.cgColor //UIColor.red.cgColor
        fastingShapeLayer.lineWidth = 32
        fastingShapeLayer.fillColor = UIColor.clear.cgColor
        fastingShapeLayer.lineCap = .round
        fastingShapeLayer.strokeEnd = 0
        
        //add water track layer
        let waterTrackLayer = CAShapeLayer()
        let waterCircularPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: yCircleCenter ), radius: waterRadius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        waterTrackLayer.path = waterCircularPath.cgPath
        waterTrackLayer.strokeColor = K.colors.lightBlueColor.cgColor
        waterTrackLayer.lineWidth = 48
        waterTrackLayer.fillColor = UIColor.clear.cgColor
        waterTrackLayer.lineCap = .round
        
        //add water shapeLayer
        waterShapeLayer.path = waterCircularPath.cgPath
        waterShapeLayer.strokeColor = K.colors.blueColor.cgColor
        waterShapeLayer.lineWidth = 32
        waterShapeLayer.fillColor = UIColor.clear.cgColor
        waterShapeLayer.lineCap = .round
        waterShapeLayer.strokeEnd = 0
        
        //add step track layer
        let stepsTrackLayer = CAShapeLayer()
        let stepsCircularPath = UIBezierPath(arcCenter: CGPoint(x: 0, y: yCircleCenter ), radius: stepRadius, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        stepsTrackLayer.path = stepsCircularPath.cgPath
        stepsTrackLayer.strokeColor = K.colors.lightYellowColor.cgColor
        stepsTrackLayer.lineWidth = 48
        stepsTrackLayer.fillColor = UIColor.clear.cgColor
        stepsTrackLayer.lineCap = .round
        
        //add step shapeLayer
        stepsShapeLayer.path = stepsCircularPath.cgPath
        stepsShapeLayer.strokeColor = K.colors.yellowColor.cgColor //UIColor.red.cgColor
        stepsShapeLayer.lineWidth = 32
        stepsShapeLayer.fillColor = UIColor.clear.cgColor
        stepsShapeLayer.lineCap = .round
        stepsShapeLayer.strokeEnd = 0
        
        scrollView.layer.addSublayer(fastingTrackLayer)
        scrollView.layer.addSublayer(fastingShapeLayer)
        
        scrollView.layer.addSublayer(waterTrackLayer)
        scrollView.layer.addSublayer(waterShapeLayer)
        
        scrollView.layer.addSublayer(stepsTrackLayer)
        scrollView.layer.addSublayer(stepsShapeLayer)
        
        //scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        
        
        //labels setup
        //fasting labels
        nextFastLabel = UILabel()
        nextFastLabel.text = "until your next fast:"
        nextFastLabel.font = UIFont.systemFont(ofSize: 14)
        nextFastLabel.textColor = .gray
        scrollView.addSubview(nextFastLabel)
        nextFastLabel.snp.makeConstraints { make in
            make.top.equalTo(scrollView).offset(30)
            make.right.equalTo(self).offset(-24)
        }
        print("1")
        
        timeNextFastLabel = UILabel()
        timeNextFastLabel.text = "00:00:00"
        timeNextFastLabel.font = UIFont.systemFont(ofSize: 32)
        timeNextFastLabel.textColor = K.colors.greenColor
        scrollView.addSubview(timeNextFastLabel)
        timeNextFastLabel.snp.makeConstraints { make in
            make.top.equalTo(nextFastLabel.snp_bottomMargin).offset(12)
            make.right.equalTo(self).offset(-24)
        }
        
        canEatLabel = UILabel()
        canEatLabel.text = "you can eat now"
        canEatLabel.font = UIFont.systemFont(ofSize: 14)
        canEatLabel.textColor = .lightGray
        scrollView.addSubview(canEatLabel)
        canEatLabel.snp.makeConstraints { make in
            make.top.equalTo(timeNextFastLabel.snp_bottomMargin).offset(10)
            make.right.equalTo(self).offset(-24)
        }
        
        //water labels
        leftToDrinkTxtLabel = UILabel()
        leftToDrinkTxtLabel.text = "left to drink:"
        leftToDrinkTxtLabel.font = UIFont.systemFont(ofSize: 14)
        leftToDrinkTxtLabel.textColor = .gray
        scrollView.addSubview(leftToDrinkTxtLabel)
        leftToDrinkTxtLabel.snp.makeConstraints { make in
            make.top.equalTo(nextFastLabel.snp_bottomMargin).offset(sectionHeight)
            make.right.equalTo(self).offset(-24)
        }
        
        leftToDrinkLabel = UILabel()
        leftToDrinkLabel.text = "3000 ml"
        leftToDrinkLabel.font = UIFont.systemFont(ofSize: 32)
        leftToDrinkLabel.textColor = K.colors.blueColor
        scrollView.addSubview(leftToDrinkLabel)
        leftToDrinkLabel.snp.makeConstraints { make in
            make.top.equalTo(leftToDrinkTxtLabel.snp_bottomMargin).offset(12)
            make.right.equalTo(self).offset(-24)
        }
        
        drinkGoalLabel = UILabel()
        drinkGoalLabel.text = "of 3 000 ml"
        drinkGoalLabel.font = UIFont.systemFont(ofSize: 14)
        drinkGoalLabel.textColor = .lightGray
        scrollView.addSubview(drinkGoalLabel)
        drinkGoalLabel.snp.makeConstraints { make in
            make.top.equalTo(leftToDrinkLabel.snp_bottomMargin).offset(10)
            make.right.equalTo(self).offset(-24)
        }
        
        //steps label
        leftToGoTxtLabel = UILabel()
        leftToGoTxtLabel.text = "left to go:"
        leftToGoTxtLabel.font = UIFont.systemFont(ofSize: 14)
        leftToGoTxtLabel.textColor = .gray
        scrollView.addSubview(leftToGoTxtLabel)
        leftToGoTxtLabel.snp.makeConstraints { make in
            make.top.equalTo(leftToDrinkTxtLabel.snp_bottomMargin).offset(sectionHeight)
            make.right.equalTo(self).offset(-24)
        }
        
        stepsLabel = UILabel()
        stepsLabel.text = "10000"
        stepsLabel.font = UIFont.systemFont(ofSize: 32)
        stepsLabel.textColor = K.colors.yellowColor
        scrollView.addSubview(stepsLabel)
        stepsLabel.snp.makeConstraints { make in
            make.top.equalTo(leftToGoTxtLabel.snp_bottomMargin).offset(12)
            make.right.equalTo(self).offset(-24)
        }
        
        stepsGoalLabel = UILabel()
        stepsGoalLabel.text = "of 10 000 steps"
        stepsGoalLabel.font = UIFont.systemFont(ofSize: 14)
        stepsGoalLabel.textColor = .lightGray
        scrollView.addSubview(stepsGoalLabel)
        stepsGoalLabel.snp.makeConstraints { make in
            make.top.equalTo(stepsLabel.snp_bottomMargin).offset(10)
            make.right.equalTo(self).offset(-24)
        }
        
        //button
        editButton = UIButton()
        editButton.setTitle("edit goals ", for: .normal)
        editButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        editButton.setTitleColor(.gray, for: .normal)
        editButton.setImage(UIImage(named: "pencil"), for: .normal)
        editButton.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        editButton.titleLabel?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        editButton.imageView?.transform = CGAffineTransform(scaleX: -1.0, y: 1.0)
        editButton.imageView?.contentMode = .scaleAspectFit
        editButton.imageEdgeInsets = UIEdgeInsets.init(top: 10, left: 0, bottom: 10, right: 0)
        scrollView.addSubview(editButton)
        editButton.snp.makeConstraints { make in
            make.top.equalTo(leftToGoTxtLabel.snp_bottomMargin).offset(sectionHeight - 15)
            make.right.equalTo(self).offset(-24)
            make.height.equalTo(40)
        }
        
        let buttonsWidth = (screenWidth - 56 - 129) / 2
        //buttons
        startFastButton = UIButton()
        startFastButton.setImage(UIImage(named: "fastIcon"), for: .normal)
        startFastButton.backgroundColor = K.colors.orangeColor
        startFastButton.setTitle("start 16h fast\nat 9:00 pm", for: .normal)
        startFastButton.titleLabel?.numberOfLines = 0
        startFastButton.titleLabel?.lineBreakMode = .byWordWrapping
        startFastButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        startFastButton.layer.cornerRadius = 8
        startFastButton.alignVertical(spacing: 88)
        startFastButton.contentHorizontalAlignment = .left
        scrollView.addSubview(startFastButton)
        startFastButton.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp_bottomMargin).offset(52)
            make.right.equalTo(self).offset(-24)
            make.height.equalTo(164)
            make.width.equalTo(129)
        }
        
        addLiquidButton = UIButton()
        addLiquidButton.setImage(UIImage(named: "waterIcon"), for: .normal)
        addLiquidButton.backgroundColor = K.colors.blueColor
        addLiquidButton.setTitle("add liquid", for: .normal)
        addLiquidButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        addLiquidButton.layer.cornerRadius = 8
        addLiquidButton.alignVertical(spacing: 20)
        addLiquidButton.contentHorizontalAlignment = .left
        scrollView.addSubview(addLiquidButton)
        addLiquidButton.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(buttonsWidth)
            make.right.equalTo(startFastButton.snp.left).offset(-4)
            make.top.equalTo(startFastButton)
        }
        
        addFoodButton = UIButton()
        addFoodButton.setImage(UIImage(named: "foodIcon"), for: .normal)
        addFoodButton.backgroundColor = K.colors.greenColor
        addFoodButton.setTitle("add food", for: .normal)
        addFoodButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        addFoodButton.layer.cornerRadius = 8
        addFoodButton.alignVertical(spacing: 20)
        //addFoodButton.titleEdgeInsets = UIEdgeInsets(top: 58, left: 12, bottom: 12, right: 12)
        addFoodButton.contentHorizontalAlignment = .left
        scrollView.addSubview(addFoodButton)
        addFoodButton.snp.makeConstraints { make in
            make.height.equalTo(addLiquidButton)
            make.width.equalTo(buttonsWidth)
            make.right.equalTo(addLiquidButton.snp.left).offset(-4)
            make.top.equalTo(addLiquidButton)
        }
        
        addMoodButton = UIButton()
        addMoodButton.setImage(UIImage(named: "moodIcon"), for: .normal)
        addMoodButton.backgroundColor = K.colors.purpleColor
        addMoodButton.setTitle("add mood", for: .normal)
        addMoodButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        addMoodButton.layer.cornerRadius = 8
        addMoodButton.alignVertical(spacing: 20)
        addMoodButton.contentHorizontalAlignment = .left
        
        scrollView.addSubview(addMoodButton)
        addMoodButton.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.width.equalTo(buttonsWidth * 2 + 4)
            make.top.equalTo(addLiquidButton.snp.bottom).offset(4)
            make.left.equalTo(self).offset(24)
            print("coord: \(self.addMoodButton.frame)")
        }
    }
    
}
