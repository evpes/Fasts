//
//  FoodAlertView.swift
//  Fasts
//
//  Created by evpes on 05.01.2022.
//

import UIKit

protocol FoodAlertDelegate {
    func addFood(g: Int)
    func closeFoodView()
}


class FoodAlertView: UIView {

    var titleLabel: UILabel!
    var foodLabel: UILabel!
    var closeButton: UIButton!
    var plusButton: UIButton!
    var minusButton: UIButton!
    
    var delegate: FoodAlertDelegate?
    
    var food = 250 {
        didSet {
            foodLabel.text = "\(food) g"
        }
    }
    
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            createSubviews()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            createSubviews()
            
        }

        func createSubviews() {
            
            self.backgroundColor = .white
            titleLabel = UILabel()
            self.addSubview(titleLabel)
            titleLabel.text = "Add food"
            titleLabel.textColor = K.colors.greenColor
            titleLabel.font = UIFont.systemFont(ofSize: 20)
            titleLabel.snp.makeConstraints { make in
                make.left.equalTo(self.snp.left).offset(32)
                make.top.equalTo(self.snp.top).offset(32)
            }
            
            foodLabel = UILabel()
            self.addSubview(foodLabel)
            foodLabel.text = "\(food) g"
            foodLabel.textColor = .gray
            foodLabel.textAlignment = .center
            foodLabel.font = UIFont.systemFont(ofSize: 24)
            foodLabel.snp.makeConstraints { make in
                make.height.equalTo(48)
                make.width.equalTo(120)
                make.centerX.equalTo(self.snp.centerX)
                make.top.equalTo(titleLabel).offset(44)
            }
            foodLabel.layer.borderWidth = 2
            foodLabel.layer.borderColor = UIColor.lightGray.cgColor
            foodLabel.layer.cornerRadius = 8
            
            closeButton = UIButton()
            self.addSubview(closeButton)
            closeButton.setImage(UIImage(named: "crossIcon"), for: .normal)
            closeButton.snp.makeConstraints { make in
                make.top.equalTo(self.snp.top).offset(32)
                make.right.equalTo(self.snp.right).offset(-32)
                make.height.equalTo(18)
                make.width.equalTo(18)
            }
            closeButton.addTarget(self, action: #selector(closeFoodView), for: .touchUpInside)
            
            plusButton = UIButton()
            self.addSubview(plusButton)
            plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
            plusButton.backgroundColor = K.colors.greenColor
            plusButton.tintColor = .white
            plusButton.layer.cornerRadius = 8
            plusButton.snp.makeConstraints { make in
                make.right.equalTo(closeButton.snp.right)
                make.top.equalTo(foodLabel.snp.top)
                make.height.equalTo(48)
                make.width.equalTo(48)
            }
            plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
            
            minusButton = UIButton()
            self.addSubview(minusButton)
            minusButton.setImage(UIImage(systemName: "minus"), for: .normal)
            minusButton.backgroundColor = K.colors.greenColor
            minusButton.tintColor = .white
            minusButton.layer.cornerRadius = 8
            minusButton.snp.makeConstraints { make in
                make.left.equalTo(titleLabel.snp.left)
                make.top.equalTo(foodLabel.snp.top)
                make.height.equalTo(48)
                make.width.equalTo(48)
            }
            minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        }
    
    @objc func plusButtonTapped() {
        food += 50
    }
    
    @objc func minusButtonTapped() {
        food -= 50
    }
    
    @objc func closeFoodView() {
        delegate?.addFood(g: food)
        delegate?.closeFoodView()
    }
}
