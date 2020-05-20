//
//  LabelWithLeadingImage.swift
//  AirbnbApp
//
//  Created by Cory Kim on 2020/05/21.
//  Copyright © 2020 codesquad. All rights reserved.
//

import UIKit

protocol LabelWithLeadingImage: UILabel {
    var leadingImage: UIImage? { get set }
    var leadingImageTintColor: UIColor! { get }
    var imageAttachment: NSTextAttachment! { get set }
    var leadingImageYConstant: CGFloat { get }
    
    func configureImageAttachment()
}

extension LabelWithLeadingImage {
    var leadingImageTintColor: UIColor! {
        UIColor(named: "stay.tintcolor")
    }
    
    var leadingImageYConstant: CGFloat { 0 }
    
    func configureImageAttachment() {
        self.imageAttachment = NSTextAttachment()
        let height = self.bounds.height * 0.8
        imageAttachment.bounds = .init(x: 0, y: -(self.bounds.midY - height * 0.5) - leadingImageYConstant, width: height, height: height)
        imageAttachment.image = leadingImage?.withTintColor(leadingImageTintColor)
    }
}
