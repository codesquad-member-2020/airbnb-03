//
//  NSMutableAttributedString+append.swift
//  AirbnbApp
//
//  Created by Cory Kim on 2020/05/21.
//  Copyright © 2020 codesquad. All rights reserved.
//

import UIKit

extension NSMutableAttributedString {
    func append(text: String,
                fontColor: UIColor? = .black,
                fontSize: CGFloat,
                weight: UIFont.Weight = .medium) {
        self.append(NSAttributedString(string: text,
                                       attributes: [
                                        .foregroundColor: fontColor ?? UIColor.black,
                                        .font: UIFont.systemFont(ofSize: fontSize, weight: weight)
        ]))
    }
}
