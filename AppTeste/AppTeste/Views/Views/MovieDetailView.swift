//
//  MovieDetailView.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import Foundation
import UIKit

class MovieDetailView: UIView {
    
    // MARK: Subviews
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsHorizontalScrollIndicator = false
        tableView.alwaysBounceHorizontal = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.bounces = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: ViewConstraints.TABLE_VIEW_MARGIN, right: 0)
        return tableView
    }()
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        activityIndicator.tintColor = .gray
        activityIndicator.backgroundColor = UIColor(white: 1, alpha: 1)
        return activityIndicator
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
    
    func addSubviews() {
        
        addSubview(tableView)
        addSubview(activityIndicatorView)
    }
    
    
    // MARK: Constraints
    func setupConstraints() {
  
        addViewConstraints(view: tableView)
        addViewConstraints(view: activityIndicatorView)
    }
    
    private func addViewConstraints(view: UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}



