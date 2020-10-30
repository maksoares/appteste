//
//  BookView.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import Foundation
import UIKit

class BookView: UIView {
    
    // MARK: Subviews
    var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        activityIndicator.tintColor = .gray
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.1)
        return activityIndicator
    }()
    
    let nameLabel: UILabel = {
        let label = CustomLabel()
        label.text = NSLocalizedString("Name:", comment: "")
        label.font = Consts.DETAIL_BOLD_FONT
        return label
    }()
  
    let nameTextView: UITextView = {
        let textView = CustomTextView()
        textView.autocapitalizationType = UITextAutocapitalizationType.words
        return textView
    }()
    
    
    let emailLabel: UILabel = {
        let label = CustomLabel()
        label.text = NSLocalizedString("E-mail:", comment: "")
        label.font = Consts.DETAIL_BOLD_FONT
        return label
    }()
    
    let emailTextView: UITextView = {
        let textView = CustomTextView()
        textView.autocapitalizationType = UITextAutocapitalizationType.none
        return textView
    }()
    
    public var bookButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Book", comment: ""), for: .normal)
        button.titleLabel?.font = Consts.DETAIL_BOLD_FONT
        button.setTitleColor(.link, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.link.cgColor
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1.0
        return button
    }()
    
    // MARK: Initializers
    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: Setup Layout
    func setupView() {
        addSubviews()
        setupConstraints()
        backgroundColor = .white
    }
    
    private func addSubviews() {
        addSubview(nameLabel)
        addSubview(nameTextView)
        addSubview(bookButton)
        addSubview(emailLabel)
        addSubview(emailTextView)
        addSubview(activityIndicatorView)
    }

    private func setupConstraints() {
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            activityIndicatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            activityIndicatorView.topAnchor.constraint(equalTo: topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        addSubViewConstraints(view: nameLabel, height: ViewConstraints.BOOK_TEXT_HEIGHT, topAnchor: layoutMarginsGuide.topAnchor, topSpace: ViewConstraints.TOP_SPACE)
        addSubViewConstraints(view: nameTextView, height: ViewConstraints.BOOK_TEXT_HEIGHT, topAnchor: nameLabel.bottomAnchor, topSpace: ViewConstraints.TOP_SPACE)
        addSubViewConstraints(view: emailLabel, height: ViewConstraints.BOOK_TEXT_HEIGHT, topAnchor: nameTextView.bottomAnchor, topSpace: ViewConstraints.TOP_SPACE)
        addSubViewConstraints(view: emailTextView, height: ViewConstraints.BOOK_TEXT_HEIGHT, topAnchor: emailLabel.bottomAnchor, topSpace: ViewConstraints.TOP_SPACE)
        addSubViewConstraints(view: bookButton, height: ViewConstraints.BUTTON_HEIGHT, topAnchor: emailTextView.bottomAnchor, topSpace: ViewConstraints.BUTTON_TOP_SPACE)
    }
    
    
    //MARK: Private Constraints
    private func addSubViewConstraints(view: UIView, height: CGFloat?, topAnchor: NSLayoutYAxisAnchor, topSpace: CGFloat){
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: topSpace),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ViewConstraints.LEADING_SPACE),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: ViewConstraints.TRAILING_SPACE)
        ])
        if let height = height {
            view.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
}
