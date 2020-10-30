//
//  CustomViews.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import Foundation
import UIKit

public class CustomLabel: UILabel {
   
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config() {
        backgroundColor = .clear
        clipsToBounds = true
        textAlignment = .left
        textColor = .black
        font = Consts.DETAIL_FONT
        numberOfLines = 0
    }
}

public class CustomTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        config()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config() {
        isSelectable = true
        isEditable = true
        isScrollEnabled = false
        autocorrectionType = .no
        textContainer.maximumNumberOfLines = 1
        textContainer.lineBreakMode = .byTruncatingTail
        font = Consts.DETAIL_FONT
        textAlignment = .left
        textColor = .black
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 4
        layer.borderWidth = 1.0
    }
}
