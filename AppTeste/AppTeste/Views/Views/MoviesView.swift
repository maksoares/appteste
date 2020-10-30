//
//  MoviesView.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import UIKit

class MoviesView: UIView {
    
    // MARK: Subviews
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.showsHorizontalScrollIndicator = false
        tableView.alwaysBounceHorizontal = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 10
        tableView.bounces = false
        return tableView
    }()
    
    var activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.transform = CGAffineTransform(scaleX: 2, y: 2)
        activityIndicator.tintColor = .gray
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.1)
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
    
    private func addSubviews() {
        addSubview(tableView)
        addSubview(activityIndicatorView)
    }

    private func setupConstraints() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.leadingAnchor.constraint(equalTo: leadingAnchor),
            activityIndicatorView.trailingAnchor.constraint(equalTo: trailingAnchor),
            activityIndicatorView.topAnchor.constraint(equalTo: topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
}
