//
//  TagTextField.swift
//  TagListViewDemo
//
//  Created by Hugues Stéphano TELOLAHY on 1/6/18.
//  Copyright © 2018 Ela. All rights reserved.
//

import UIKit

@IBDesignable
open class TagTextField: UITextField {
    
    @IBInspectable open dynamic var paddingY: CGFloat = 0
    
    @IBInspectable open dynamic var paddingX: CGFloat = 0
    
    // MARK: - layout
    
    override open var intrinsicContentSize: CGSize {
        var size = CGSize.zero
        if let textFont  = self.font,
            let placeholder = self.placeholder {
            size = placeholder.size(withAttributes: [NSAttributedStringKey.font: textFont])
            size.height = textFont.pointSize + paddingY * 2
            size.width += paddingX * 2
        }
        return size
    }
}

