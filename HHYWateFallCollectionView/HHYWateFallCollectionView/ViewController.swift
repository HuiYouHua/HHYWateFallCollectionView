//
//  ViewController.swift
//  HHYWateFallCollectionView
//
//  Created by 华惠友 on 2020/3/19.
//  Copyright © 2020 huayoyu. All rights reserved.
//

import UIKit

private let kCollectionID = "kCollectionID"

class ViewController: UIViewController {

    fileprivate lazy var collectionView: UICollectionView = {

        let layout = HHYWaterFallLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.dataSouce = self
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCollectionID)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
    }
}

extension UIViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCollectionID, for: indexPath)
        cell.contentView.backgroundColor = UIColor.randomColor()
        return cell
    }
}

extension UIViewController: HHYWaterFallLayoutDataSouce {
    func numberOfCols(_ waterFall: HHYWaterFallLayout) -> Int {
        return 2
    }
    
    func waterFall(_ WaterFall: HHYWaterFallLayout, indexPath: IndexPath) -> CGFloat {
        return CGFloat(arc4random_uniform(100) + 100)
    }
}
