//
//  HomeView.swift
//  RedditClient
//
//  Created by Vladimir on 03.02.2021.
//

import UIKit

class HomeView: UIView {

    // MARK: -
    // MARK: Private Properties
    
    @IBOutlet private var commonCollection: UICollectionView?
    
    // MARK: -
    // MARK: Public Methods
    
    public func setCollectionDelegates(delegate: UICollectionViewDelegate, datasource: UICollectionViewDataSource, cellName: String) {
        self.commonCollection?.delegate = delegate
        self.commonCollection?.dataSource = datasource
//        self.commonCollection?.register(UINib(nibName: "HomeCollectionViewCell", bundle: Bundle(for: Self.self)), forCellWithReuseIdentifier: cellName)
        self.commonCollection?.register(HomeCollectionCell.self, forCellWithReuseIdentifier: cellName)
        self.commonCollection?.allowsMultipleSelection = false
    }
    
    public func prepareUI() {
//        self.commonCollection?.backgroundColor = .yellow
    }
    
    public func refreshState(){
        self.commonCollection?.reloadData()
    }
}
