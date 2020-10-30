//
//  TextTableViewCell.swift
//  AppTeste
//
//  Created by marcel.soares on 28/10/20.
//

import Foundation
import UIKit

class TextTableViewCell: UITableViewCell {

    // MARK: Subviews
    let titleLabel: CustomLabel = {
        let label = CustomLabel()
        return label
    }()
    
    // MARK: Properties
    public var string : String! {
        didSet {
            titleLabel.text = string
        }
    }
    static let REUSE_IDENTIFIER = "TextTableViewCell"

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
        
        titleLabel.text = ""
    }

    // MARK: Private methods
    func configureCell(){
        addSubViews()
        createConstraints()
    }
    
    func addSubViews() {
        contentView.addSubview(titleLabel)
    }
    
    private func createConstraints() {
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewConstraints.LEADING_SPACE),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: ViewConstraints.TRAILING_SPACE),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewConstraints.TABLE_VIEW_MARGIN)
        ])
    }

}

