//
//  MovieTableViewCell.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell {

    // MARK: Subviews
    let titleLabel: UILabel = {
        let label = CustomLabel()
        label.font = Consts.TITLE_FONT
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = CustomLabel()
        label.font = Consts.DETAIL_BOLD_FONT
        label.text = NSLocalizedString("Release date: ", comment: "")
        return label
    }()
    
    let dateValueLabel: UILabel = {
        let label = CustomLabel()
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = CustomLabel()
        label.font = Consts.DETAIL_BOLD_FONT
        label.text = NSLocalizedString("Time: ", comment: "")
        label.textAlignment = .right
        return label
    }()
    
    let timeValueLabel: UILabel = {
        let label = CustomLabel()
        label.textAlignment = .right
        return label
    }()
    
    var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    // MARK: Properties
    public var movie : Movie! {
        didSet {
            titleLabel.text = movie.title
            dateValueLabel.text = movie.date?.epochToDateStr()
            timeValueLabel.text = movie.time?.epochToTimeStr()
        }
    }
    static let REUSE_IDENTIFIER = "MovieTableViewCell"

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
        dateValueLabel.text = ""
        timeValueLabel.text = ""
    }

    // MARK: Private methods
    func configureCell(){
        addSubViews()
        createConstraints()
    }
    
    func addSubViews() {
        contentView.addSubview(backView)
        backView.addSubview(titleLabel)
        backView.addSubview(dateLabel)
        backView.addSubview(dateValueLabel)
        backView.addSubview(timeLabel)
        backView.addSubview(timeValueLabel)
    }
    
    private func createConstraints() {
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewConstraints.LEADING_SPACE),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: ViewConstraints.TRAILING_SPACE),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: ViewConstraints.BOTTOM_SPACE),
            backView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewConstraints.TOP_SPACE)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: ViewConstraints.LEADING_SPACE),
            titleLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: ViewConstraints.TRAILING_SPACE),
            titleLabel.heightAnchor.constraint(equalToConstant: ViewConstraints.TITLE_LABEL_HEIGHT),
            titleLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: ViewConstraints.TOP_SPACE)
        ])
        
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: backView.leadingAnchor, constant: ViewConstraints.LEADING_SPACE),
            dateLabel.heightAnchor.constraint(equalToConstant: ViewConstraints.SUB_TITLE_LABEL_HEIGHT),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: ViewConstraints.BOTTOM_SPACE),
            
            dateValueLabel.leadingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            dateValueLabel.heightAnchor.constraint(equalToConstant: ViewConstraints.SUB_TITLE_LABEL_HEIGHT),
            dateValueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            dateValueLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: ViewConstraints.BOTTOM_SPACE)
            
        ])

        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        timeValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            timeLabel.leadingAnchor.constraint(equalTo: dateValueLabel.trailingAnchor, constant: ViewConstraints.LEADING_SPACE),
            timeLabel.heightAnchor.constraint(equalToConstant: ViewConstraints.SUB_TITLE_LABEL_HEIGHT),
            timeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: ViewConstraints.BOTTOM_SPACE),
            
            timeValueLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor),
            timeValueLabel.trailingAnchor.constraint(equalTo: backView.trailingAnchor, constant: ViewConstraints.TRAILING_SPACE),
            timeValueLabel.heightAnchor.constraint(equalToConstant: ViewConstraints.SUB_TITLE_LABEL_HEIGHT),
            timeValueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            
            dateValueLabel.widthAnchor.constraint(equalToConstant: ViewConstraints.DATE_LABEL_WIDTH),
            timeValueLabel.widthAnchor.constraint(equalToConstant: ViewConstraints.TIME_LABEL_WIDTH),

        ])

    }

}
