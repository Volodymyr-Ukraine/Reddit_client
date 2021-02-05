//
//  HomeViewController.swift
//  RedditClient
//
//  Created by Vladimir on 03.02.2021.
//

import UIKit

enum HomeEvent{
    case showLargeImage(String)
}

class HomeViewController: UIViewController, StoryboardLoadable {

    // MARK: -
    // MARK: Private Constants
    
    private let cellName = "cell"
    
    // MARK: -
    // MARK: Properties
    
    public var model: HomeModel = HomeModel()
    public var eventHandler: ((HomeEvent)->())?
    private var mainView: HomeView? {
        return self.view as? HomeView
    }
        
    // MARK: -
    // MARK: Init and Deinit
    
    public static func startVC() -> Self {
        let controller = self.loadFromNib()
        return controller
    }
    
    deinit {
        print("Deinit: \(Self.self)")
    }
    
    // MARK: -
    // MARK: Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView?.prepareUI()
        self.mainView?.setCollectionDelegates(delegate: self, datasource: self, cellName: cellName)
        self.refreshModel()
    }
    
    public func refreshModel(){
        self.model.refreshCurrentData(onSuccess: {[weak self] in
            DispatchQueue.main.async {
                self?.mainView?.refreshState()
            }
        }, onError: { [weak self] message in
            DispatchQueue.main.async {
                self?.showStandardError(message)
            }
        })
    }
}

// MARK: -
// MARK: Extensions

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellName, for: indexPath) as? HomeCollectionViewCell,
              let data = self.model.data.dropFirst(indexPath.row).first else {
            return UICollectionViewCell()
        }
        cell.setData(data)
        NetworkManager.get.loadImageAndDo(
            data.thumbnail ?? "",
            toDo: { [weak cell] data in
                
                cell?.setImage(data)
            },
            onError: { [weak self] message in
                self?.showStandardError(message)
            })
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.model.data.count - 10 {
            DispatchQueue.global(qos: .background).async {
                self.model.refreshCurrentData(onSuccess: {[weak self] in
                    self?.mainView?.refreshState()
                }, onError: {[weak self] message in
                    self?.showStandardError(message)
                })
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let data = self.model.data.dropFirst(indexPath.row).first,
              let urlString = data.bigImageUrl,
              urlString.hasSuffix(".png") || urlString.hasSuffix(".jpg")
            else { return }
        self.eventHandler?(.showLargeImage(urlString))
    }
}
