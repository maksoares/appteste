//
//  CollectionTableViewCell.swift
//  AppTeste
//
//  Created by marcel.soares on 28/10/20.
//

import Foundation
import UIKit
import RxSwift

class CollectionTableViewCell: UITableViewCell, UICollectionViewDelegateFlowLayout {

    // MARK: Rx
    //let people = PublishSubject<[Movie.Person]>()
    let disposeBag = DisposeBag()
    
    // MARK: Subviews
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let frame = CGRect(x: 0, y: 0, width: ViewConstraints.COLLECTION_VIEW_ITEM_HEIGHT
                           , height: ViewConstraints.COLLECTION_VIEW_ITEM_HEIGHT)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.register(PersonCollectionViewCell.self, forCellWithReuseIdentifier: PersonCollectionViewCell.REUSE_IDENTIFIER)
        return collectionView
    }()
    
    
    // MARK: Properties
    public var people : [Movie.Person]? {
        didSet {
            collectionView.reloadData()
        }
    }
    static let REUSE_IDENTIFIER = "CollectionTableViewCell"

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
    }

    // MARK: Private methods
    func configureCell(){
        addSubViews()
        createConstraints()
        configureCollectionView()
        //binds()
    }
    
    /*
    func binds() { //Dont work inside UITableViewCell

        people.bind(to: collectionView.rx.items){ (collectionView, row, item) -> UICollectionViewCell in
            
            let indexPath = IndexPath(row: row, section: 0)
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionViewCell.REUSE_IDENTIFIER, for: indexPath) as! PersonCollectionViewCell
            
            cell.person = item
            return cell
        }.disposed(by: disposeBag)
        
    }
    */
    
    func configureCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        flowLayout.itemSize = CGSize(width: ViewConstraints.COLLECTION_VIEW_ITEM_WIDTH, height: ViewConstraints.COLLECTION_VIEW_ITEM_HEIGHT)
        
        flowLayout.minimumInteritemSpacing = ViewConstraints.SCROLL_VIEW_MARGIN
        flowLayout.minimumLineSpacing = ViewConstraints.SCROLL_VIEW_MARGIN
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: ViewConstraints.COLLECTION_VIEW_MARGIN, bottom: 0, right: ViewConstraints.COLLECTION_VIEW_MARGIN)
        
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func addSubViews() {
        contentView.addSubview(collectionView)
    }
    
    private func createConstraints() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([

            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: ViewConstraints.TOP_SPACE),
            collectionView.heightAnchor.constraint(equalToConstant: ViewConstraints.COLLECTION_VIEW_ITEM_HEIGHT),
        ])
    }
    
}

extension CollectionTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PersonCollectionViewCell.REUSE_IDENTIFIER, for: indexPath) as! PersonCollectionViewCell
        
        cell.person = people?[indexPath.row]
        return cell
    }
    
    
}
