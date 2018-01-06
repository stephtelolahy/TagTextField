//
//  TagTextField.swift
//  TagListViewDemo
//
//  Created by Hugues Stéphano TELOLAHY on 1/6/18.
//  Copyright © 2018 Ela. All rights reserved.
//

import UIKit

open class TagTextField: UITextField {
    
    open var paddingY: CGFloat = 0
    
    open var paddingX: CGFloat = 0
    
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

