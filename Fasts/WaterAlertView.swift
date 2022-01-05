//
//  WaterAlertView.swift
//  Fasts
//
//  Created by evpes on 28.12.2021.
//

import UIKit

protocol WaterAlertDelegate {
    func addWater(ml: Int)
    func closeButtonTapped()
}

class WaterAlertView: UIView {

    var titleLabel: UILabel!
    var waterLabel: UILabel!
    var closeButton: UIButton!
    var plusButton: UIButton!
    var minusButton: UIButton!
    
    var delegate: WaterAlertDelegate?
    
    var water = 250 {
        didSet {
            waterLabel.text = "\(water) ml"
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
            titleLabel.text = "Add water"
            titleLabel.textColor = K.colors.blueColor
            titleLabel.font = UIFont.systemFont(ofSize: 20)
            titleLabel.snp.makeConstraints { make in
                make.left.equalTo(self.snp.left).offset(32)
                make.top.equalTo(self.snp.top).offset(32)
            }
            
            waterLabel = UILabel()
            self.addSubview(waterLabel)
            waterLabel.text = "\(water) ml"
            waterLabel.textColor = .gray
            waterLabel.textAlignment = .center
            waterLabel.font = UIFont.systemFont(ofSize: 24)
            waterLabel.snp.makeConstraints { make in
                make.height.equalTo(48)
                make.width.equalTo(120)
                make.centerX.equalTo(self.snp.centerX)
                make.top.equalTo(titleLabel).offset(44)
            }
            waterLabel.layer.borderWidth = 2
            waterLabel.layer.borderColor = UIColor.lightGray.cgColor
            waterLabel.layer.cornerRadius = 8
            
            closeButton = UIButton()
            self.addSubview(closeButton)
            closeButton.setImage(UIImage(named: "crossIcon"), for: .normal)
            closeButton.snp.makeConstraints { make in
                make.top.equalTo(self.snp.top).offset(32)
                make.right.equalTo(self.snp.right).offset(-32)
                make.height.equalTo(18)
                make.width.equalTo(18)
            }
            closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
            
            plusButton = UIButton()
            self.addSubview(plusButton)
            plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
            plusButton.backgroundColor = K.colors.blueColor
            plusButton.tintColor = .white
            plusButton.layer.cornerRadius = 8
            plusButton.snp.makeConstraints { make in
                make.right.equalTo(closeButton.snp.right)
                make.top.equalTo(waterLabel.snp.top)
                make.height.equalTo(48)
                make.width.equalTo(48)
            }
            plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
            
            minusButton = UIButton()
            self.addSubview(minusButton)
            minusButton.setImage(UIImage(systemName: "minus"), for: .normal)
            minusButton.backgroundColor = K.colors.blueColor
            minusButton.tintColor = .white
            minusButton.layer.cornerRadius = 8
            minusButton.snp.makeConstraints { make in
                make.left.equalTo(titleLabel.snp.left)
                make.top.equalTo(waterLabel.snp.top)
                make.height.equalTo(48)
                make.width.equalTo(48)
            }
            minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        }
    
    @objc func plusButtonTapped() {
        water += 50
    }
    
    @objc func minusButtonTapped() {
        water -= 50
    }
    
    @objc func closeButtonTapped() {
        delegate?.addWater(ml: water)
        delegate?.closeButtonTapped()
    }

}
