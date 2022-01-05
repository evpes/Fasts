//
//  UIButton+allign.swift
//  Fasts
//
//  Created by evpes on 05.01.2022.
//

import Foundation
import UIKit

extension UIButton {
    func alignVertical(spacing: CGFloat = 6.0) {
        guard let imageSize = self.imageView?.image?.size,
              let text = self.titleLabel?.text,
              let font = self.titleLabel?.font
        else { return }
        self.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: -(imageSize.height + spacing), right: 0.0)
        let labelString = NSString(string: text)
        let titleSize = labelString.size(withAttributes: [kCTFontAttributeName as NSAttributedString.Key: font])
        print("image top offset: \(-(titleSize.height + spacing))")
        self.imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0.0, bottom: 0.0, right: -titleSize.width)
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0;
        print("edge offset: \(edgeOffset)")
        self.contentEdgeInsets = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 0.0)
    }
}
