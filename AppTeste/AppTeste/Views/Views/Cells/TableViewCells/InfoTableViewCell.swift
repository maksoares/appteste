//
//  InfoTableViewCell.swift
//  AppTeste
//
//  Created by marcel.soares on 28/10/20.
//

import Foundation
import UIKit

class InfoTableViewCell: UITableViewCell {

    // MARK: Subviews
    public var infoContentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        view.layer.cornerRadius = 4
        view.layer.borderWidth = 1.0
        return view
    }()
    
    let dateLabel: CustomLabel = {
        let label = CustomLabel()
        label.text = NSLocalizedString("Release date: ", comment: "")
        label.font = Consts.DETAIL_BOLD_FONT
        return label
    }()
    
    let dateValueLabel: CustomLabel = {
        let label = CustomLabel()
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = CustomLabel()
        label.text = NSLocalizedString("Time: ", comment: "")
        label.font = Consts.DETAIL_BOLD_FONT
        return label
    }()
    
    let timeValueLabel: UILabel = {
        let label = CustomLabel()
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = CustomLabel()
        label.text = NSLocalizedString("Price: ", comment: "")
        label.font = Consts.DETAIL_BOLD_FONT
        return label
    }()
    
    let priceValueLabel: UILabel = {
        let label = CustomLabel()
        return label
    }()

    
    // MARK: Properties
    public var movie : Movie! {
        didSet {
            dateValueLabel.text = movie.date?.epochToDateStr()
            timeValueLabel.text = movie.time?.epochToTimeStr()
            priceValueLabel.text = movie.price?.moneyToStr()
        }
    }
    static let REUSE_IDENTIFIER = "InfoTableViewCell"

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
        
        dateValueLabel.text = ""
        timeValueLabel.text = ""
        priceValueLabel.text = ""
    }

    // MARK: Private methods
    func configureCell(){
        addSubViews()
        createConstraints()
    }
    
    func addSubViews() {
        contentView.addSubview(infoView)
        infoView.addSubview(dateLabel)
        infoView.addSubview(dateValueLabel)
        infoView.addSubview(timeLabel)
        infoView.addSubview(timeValueLabel)
        infoView.addSubview(priceLabel)
        infoView.addSubview(priceValueLabel)
    }
    
    private func createConstraints() {
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: ViewConstraints.LEADING_SPACE),
            infoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: ViewConstraints.TRAILING_SPACE),
            infoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewConstraints.TABLE_VIEW_MARGIN),
            infoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        infoViewConstraints()
        
    }
    
    private func infoViewConstraints(){
        
        var lastView = UIView()
        
        //Date
        lastView = addInfoSubView(infoView: infoView, titleView: dateLabel, valueView: dateValueLabel, topAnchor: infoView.topAnchor)
        
        //Time
        lastView = addInfoSubView(infoView: infoView, titleView: timeLabel, valueView: timeValueLabel, topAnchor: lastView.bottomAnchor)
        
        //Price
        lastView = addInfoSubView(infoView: infoView, titleView: priceLabel, valueView: priceValueLabel, topAnchor: lastView.bottomAnchor)
        
        //BottomView
        lastView.bottomAnchor.constraint(equalTo: infoView.bottomAnchor, constant: Spacing.BOTTOM).isActive = true
    }
    
    private func addInfoSubView(infoView: UIView, titleView: UIView, valueView: UIView, topAnchor: NSLayoutYAxisAnchor) -> UIView{

        titleView.translatesAutoresizingMaskIntoConstraints = false
        valueView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: ViewConstraints.TOP_SPACE),
            titleView.heightAnchor.constraint(equalToConstant: ViewConstraints.TITLE_LABEL_HEIGHT),
            titleView.leadingAnchor.constraint(equalTo: infoView.leadingAnchor, constant: Spacing.LEFT),
            titleView.widthAnchor.constraint(equalToConstant: ViewConstraints.INFO_WIDTH),
            titleView.trailingAnchor.constraint(equalTo: valueView.leadingAnchor),
            
            valueView.topAnchor.constraint(equalTo: topAnchor, constant: ViewConstraints.TOP_SPACE),
            valueView.trailingAnchor.constraint(equalTo: infoView.trailingAnchor, constant: Spacing.RIGHT),
            valueView.heightAnchor.constraint(greaterThanOrEqualToConstant: ViewConstraints.TITLE_LABEL_HEIGHT)
        ])

        return valueView
    }

}
