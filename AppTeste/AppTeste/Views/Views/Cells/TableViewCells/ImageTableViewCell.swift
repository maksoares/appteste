//
//  MovieTableViewCell.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import Foundation
import UIKit
import RxSwift

class ImageTableViewCell: UITableViewCell {

    // MARK: Rx
    let disposeBag = DisposeBag()
    
    // MARK: Subviews
    let contentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
    public var imageUrl : String? {
        didSet {
            contentImageView.loadImageFromString(url: imageUrl)
        }
    }
    static let REUSE_IDENTIFIER = "ImageTableViewCell"

    // MARK: Initializers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.white
        selectionStyle = .none
        configureCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contentImageView.image = nil
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }

    // MARK: Private methods
    func configureCell(){
        addSubViews()
        createConstraints()
        binds()
    }
    
    func binds() {
        contentImageView.rx.isEmpty.subscribe(onNext: { isEmpty in
            self.activityIndicatorView.isHidden = !isEmpty
            isEmpty ? self.activityIndicatorView.startAnimating() : self.activityIndicatorView.stopAnimating()
        }).disposed(by: self.disposeBag)
    }
    
    func addSubViews() {
        contentView.addSubview(contentImageView)
        contentView.addSubview(activityIndicatorView)
    }
    
    private func createConstraints() {
        
        contentImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewConstraints.LEADING_SPACE),
            contentImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: ViewConstraints.TRAILING_SPACE),
            contentImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewConstraints.TABLE_VIEW_MARGIN),
            contentImageView.heightAnchor.constraint(equalToConstant: ViewConstraints.IMAGE_HEIGHT),
            contentImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.leadingAnchor.constraint(equalTo: contentImageView.leadingAnchor),
            activityIndicatorView.trailingAnchor.constraint(equalTo: contentImageView.trailingAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: contentImageView.bottomAnchor),
            activityIndicatorView.topAnchor.constraint(equalTo: contentImageView.topAnchor)
        ])

    }

}
