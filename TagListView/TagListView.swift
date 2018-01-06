//
//  TagListView.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit

public protocol TagListViewDelegate: class {
    
    func tagListView(_ sender: TagListView, didAdd title: String)
    func tagListView(_ sender: TagListView, didRemove title: String)
}

@IBDesignable
open class TagListView: UIView, UITextFieldDelegate {
    
    @IBInspectable open dynamic var textColor: UIColor = UIColor.white {
        didSet {
            for tagView in tagViews {
                tagView.textColor = textColor
            }
        }
    }
    
    @IBInspectable open dynamic var tagLineBreakMode: NSLineBreakMode = .byTruncatingMiddle {
        didSet {
            for tagView in tagViews {
                tagView.titleLineBreakMode = tagLineBreakMode
            }
        }
    }
    
    @IBInspectable open dynamic var tagBackgroundColor: UIColor = UIColor.gray {
        didSet {
            for tagView in tagViews {
                tagView.tagBackgroundColor = tagBackgroundColor
            }
        }
    }
    
    @IBInspectable open dynamic var cornerRadius: CGFloat = 0 {
        didSet {
            for tagView in tagViews {
                tagView.cornerRadius = cornerRadius
            }
        }
    }
    @IBInspectable open dynamic var borderWidth: CGFloat = 0 {
        didSet {
            for tagView in tagViews {
                tagView.borderWidth = borderWidth
            }
        }
    }
    
    @IBInspectable open dynamic var borderColor: UIColor? {
        didSet {
            for tagView in tagViews {
                tagView.borderColor = borderColor
            }
        }
    }
    
    @IBInspectable open dynamic var paddingY: CGFloat = 2 {
        didSet {
            for tagView in tagViews {
                tagView.paddingY = paddingY
            }
            rearrangeViews()
        }
    }
    @IBInspectable open dynamic var paddingX: CGFloat = 5 {
        didSet {
            for tagView in tagViews {
                tagView.paddingX = paddingX
            }
            rearrangeViews()
        }
    }
    @IBInspectable open dynamic var marginY: CGFloat = 2 {
        didSet {
            rearrangeViews()
        }
    }
    @IBInspectable open dynamic var marginX: CGFloat = 5 {
        didSet {
            rearrangeViews()
        }
    }
    
    @IBInspectable open dynamic var removeButtonIconSize: CGFloat = 12 {
        didSet {
            for tagView in tagViews {
                tagView.removeButtonIconSize = removeButtonIconSize
            }
            rearrangeViews()
        }
    }
    @IBInspectable open dynamic var removeIconLineWidth: CGFloat = 1 {
        didSet {
            for tagView in tagViews {
                tagView.removeIconLineWidth = removeIconLineWidth
            }
            rearrangeViews()
        }
    }
    
    @IBInspectable open dynamic var removeIconLineColor: UIColor = UIColor.white.withAlphaComponent(0.54) {
        didSet {
            for tagView in tagViews {
                tagView.removeIconLineColor = removeIconLineColor
            }
            rearrangeViews()
        }
    }
    
    @objc open dynamic var textFont: UIFont = UIFont.systemFont(ofSize: 18) {
        didSet {
            for tagView in tagViews {
                tagView.textFont = textFont
            }
            rearrangeViews()
        }
    }
    
    /// Placeholder while tag list is empty
    @IBInspectable open dynamic var emptyPlaceholder: String = "Start typing..." {
        didSet {
            rearrangeViews()
        }
    }
    
    /// Placeholder while tag list is not empty
    @IBInspectable open dynamic var morePlaceholder: String = "Add another" {
        didSet {
            rearrangeViews()
        }
    }
    
    open weak var delegate: TagListViewDelegate?
    
    private let textField = UITextField()
    private(set) var tagViews: [TagView] = []
    private(set) var rowViews: [UIView] = []
    private(set) var tagViewHeight: CGFloat = 0
    private(set) var rows = 0
    
    // MARK: Init
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.borderColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10
        layer.borderWidth = 2
        
        textField.backgroundColor = UIColor.yellow
        textField.delegate = self
    }
    
    
    // MARK: Interface Builder
    
    open override func prepareForInterfaceBuilder() {
        addTag("Welcome")
        addTag("to")
        addTag("TagListView").isSelected = true
    }
    
    // MARK: Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        rearrangeViews()
    }
    
    override open var intrinsicContentSize: CGSize {
        var height = CGFloat(0)
        if rows > 0 {
            height =  CGFloat(rows) * (tagViewHeight + marginY) + marginY
        }
        return CGSize(width: frame.width, height: height)
    }
    
    
    // MARK: Private
    
    private func rearrangeViews() {
        
        let views = tagViews as [UIView] + rowViews
        for view in views {
            view.removeFromSuperview()
        }
        rowViews.removeAll(keepingCapacity: true)
        
        var currentRow = 0
        var currentRowView: UIView!
        var currentRowTagCount = 0
        var currentRowWidth: CGFloat = 0
        
        var childViews: [UIView] = []
        for tagView in tagViews {
            childViews.append(tagView)
        }
        childViews.append(textField)
        
        for view in childViews {
            
            var size = CGSize()
            if let tagView = view as? TagView {
                size = tagView.intrinsicContentSize
                tagViewHeight = view.frame.height
            } else if let fieldView = view as? UITextField {
                let width = max(120, frame.width - 2 * marginX - currentRowWidth)
                size = CGSize(width: width, height: tagViewHeight)
                fieldView.placeholder = tagViews.count == 0 ? emptyPlaceholder : morePlaceholder
            }
            
            view.frame.size = size
            
            if currentRowTagCount == 0 || (currentRowWidth + view.frame.width + 2 * marginX) > frame.width {
                currentRow += 1
                currentRowWidth = 0
                currentRowTagCount = 0
                currentRowView = UIView()
                
                currentRowView.frame.origin = CGPoint(x: marginX, y: marginY + CGFloat(currentRow - 1) * (tagViewHeight + marginY))
                
                rowViews.append(currentRowView)
                addSubview(currentRowView)
                
                view.frame.size.width = min(view.frame.size.width, frame.width - 2 * marginX)
            }
            
            view.frame.origin = CGPoint(x: currentRowWidth, y: 0)
            currentRowView.addSubview(view)
            
            currentRowTagCount += 1
            currentRowWidth += view.frame.width + marginX
            
            currentRowView.frame.size.width = currentRowWidth
            currentRowView.frame.size.height = max(tagViewHeight, currentRowView.frame.height)
        }
        rows = currentRow
        
        invalidateIntrinsicContentSize()
    }
    
    private func createNewTagView(_ title: String) -> TagView {
        let tagView = TagView(title: title)
        
        tagView.textColor = textColor
        tagView.tagBackgroundColor = tagBackgroundColor
        tagView.titleLineBreakMode = tagLineBreakMode
        tagView.cornerRadius = cornerRadius
        tagView.borderWidth = borderWidth
        tagView.borderColor = borderColor
        tagView.paddingX = paddingX
        tagView.paddingY = paddingY
        tagView.textFont = textFont
        tagView.removeIconLineWidth = removeIconLineWidth
        tagView.removeButtonIconSize = removeButtonIconSize
        tagView.removeIconLineColor = removeIconLineColor
        tagView.removeButton.addTarget(self, action: #selector(removeButtonPressed(_:)), for: .touchUpInside)
        
        return tagView
    }
    
    @discardableResult
    open func addTag(_ title: String) -> TagView {
        return addTagView(createNewTagView(title))
    }
    
    @discardableResult
    open func addTags(_ titles: [String]) -> [TagView] {
        var tagViews: [TagView] = []
        for title in titles {
            tagViews.append(createNewTagView(title))
        }
        return addTagViews(tagViews)
    }
    
    @discardableResult
    open func addTagViews(_ tagViews: [TagView]) -> [TagView] {
        for tagView in tagViews {
            self.tagViews.append(tagView)
        }
        rearrangeViews()
        return tagViews
    }
    
    @discardableResult
    open func insertTag(_ title: String, at index: Int) -> TagView {
        return insertTagView(createNewTagView(title), at: index)
    }
    
    @discardableResult
    open func addTagView(_ tagView: TagView) -> TagView {
        tagViews.append(tagView)
        rearrangeViews()
        
        return tagView
    }
    
    @discardableResult
    open func insertTagView(_ tagView: TagView, at index: Int) -> TagView {
        tagViews.insert(tagView, at: index)
        rearrangeViews()
        
        return tagView
    }
    
    open func removeAllTags() {
        for view in tagViews {
            view.removeFromSuperview()
        }
        tagViews = []
        rearrangeViews()
    }
    
    private func removeTagView(_ tagView: TagView) {
        tagView.removeFromSuperview()
        if let index = tagViews.index(of: tagView) {
            tagViews.remove(at: index)
        }
        
        rearrangeViews()
    }
    
    // MARK: - Events
    
    @objc func removeButtonPressed(_ closeButton: CloseButton!) {
        if let tagView = closeButton.tagView {
            self.removeTagView(tagView)
            delegate?.tagListView(self, didRemove: tagView.currentTitle ?? "")
        }
    }
    
    // MARK: UITextFieldDelegate
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text {
            self.addTag(text)
            delegate?.tagListView(self, didAdd: text)
            textField.text = ""
        }
        return false
    }
}
