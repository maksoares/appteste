//
//  ButtonTableViewCell.swift
//  AppTeste
//
//  Created by marcel.soares on 29/10/20.
//

import Foundation
import UIKit
import RxSwift

class ButtonTableViewCell: UITableViewCell {

    // MARK: Rx
    private(set) var disposeBag = DisposeBag()
    
    // MARK: Subviews
    public var button: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.titleLabel?.font = Consts.DETAIL_BOLD_FONT
        button.setTitleColor(.link, for: .normal)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.link.cgColor
        button.layer.cornerRadius = 4
        button.layer.borderWidth = 1.0
        return button
    }()
    
    // MARK: Properties
    public var string : String! {
        didSet {
            button.setTitle(string, for: .normal)
        }
    }
    static let REUSE_IDENTIFIER = "ButtonTableViewCell"

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
        
        button.setTitle("", for: .normal)
        disposeBag = DisposeBag()
    }

    // MARK: Private methods
    func configureCell(){
        addSubViews()
        createConstraints()
        binds()
    }
    
    func binds() {
        // Book
//        button
//            .rx.tap
//            .subscribe(onNext: { _ in
//                self.coordinator?.book(movieId: self.movieId)
//            }).disposed(by: disposeBag)
    }
    
    func addSubViews() {
        contentView.addSubview(button)
    }
    
    private func createConstraints() {
        
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewConstraints.LEADING_SPACE),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: ViewConstraints.TRAILING_SPACE),
            button.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            button.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewConstraints.TABLE_VIEW_MARGIN)
        ])
    }

}
