//
//  PersonCollectionViewCell.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import Foundation
import UIKit
import RxSwift


class PersonCollectionViewCell: UICollectionViewCell {
    
    // MARK: Subviews
    var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = CustomLabel()
        label.font = Consts.TITLE_FONT
        label.textAlignment = .center
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "noImage")
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.transform = CGAffineTransform(scaleX: 1, y: 1)
        activityIndicator.tintColor = .gray
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.1)
        return activityIndicator
    }()
    
    // MARK: Properties
    let disposeBag = DisposeBag()
    static let REUSE_IDENTIFIER = "PersonCollectionViewCell"
    
    public var person : Movie.Person! {
        didSet {
            titleLabel.text = person.name
            imageView.loadImageFromString(url: person.picture)
        }
    }
    
    
    // MARK: Initializers
    override init(frame: CGRect) {
        let frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        super.init(frame: frame)
        backgroundColor = .clear
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
        imageView.image = nil
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }

    func configureCell(){
        addSubViews()
        createConstraints()
        binds()
    }
    
    func binds() {
        imageView.rx.isEmpty.subscribe(onNext: { isEmpty in
            self.activityIndicatorView.isHidden = !isEmpty
            isEmpty ? self.activityIndicatorView.startAnimating() : self.activityIndicatorView.stopAnimating()
        }).disposed(by: self.disposeBag)
    }
    
    // MARK: Setup Layout
    func addSubViews() {
        contentView.addSubview(backView)
        backView.addSubview(titleLabel)
        backView.addSubview(imageView)
        backView.addSubview(activityIndicatorView)
    }
    
    private func createConstraints() {
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backView.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: ViewConstraints.TOP_SPACE),
            titleLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: ViewConstraints.LEADING_SPACE),
            titleLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: ViewConstraints.TRAILING_SPACE),
            titleLabel.heightAnchor.constraint(equalToConstant: ViewConstraints.TITLE_CELL_LABEL_HEIGHT),
        ])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: ViewConstraints.TOP_SPACE),
            imageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: ViewConstraints.IMAGE_BOTTOM_SPACE),
            imageView.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: ViewConstraints.LEADING_SPACE),
            imageView.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: ViewConstraints.TRAILING_SPACE),
        ])
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            activityIndicatorView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            activityIndicatorView.topAnchor.constraint(equalTo: imageView.topAnchor)
        ])

    }
    
}
