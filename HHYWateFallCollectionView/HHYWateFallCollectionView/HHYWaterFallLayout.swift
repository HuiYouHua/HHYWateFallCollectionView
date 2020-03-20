//
//  HHYWaterFallLayout.swift
//  HHYWateFallCollectionView
//
//  Created by 华惠友 on 2020/3/19.
//  Copyright © 2020 huayoyu. All rights reserved.
//

import UIKit

@objc protocol HHYWaterFallLayoutDataSouce: class {
    @objc optional func numberOfCols(_ waterFall: HHYWaterFallLayout) -> Int
    func waterFall(_ WaterFall: HHYWaterFallLayout, indexPath : IndexPath) -> CGFloat
}

class HHYWaterFallLayout: UICollectionViewFlowLayout {

    weak var dataSouce: HHYWaterFallLayoutDataSouce?
    
    fileprivate lazy var cellAttrs: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var cols: Int = {
        return self.dataSouce?.numberOfCols?(self) ?? 2
    }()
    fileprivate lazy var totalHeights: [CGFloat] = Array(repeating: sectionInset.top, count: self.cols)

}

// MARK: - 准备布局
extension HHYWaterFallLayout {
    override func prepare() {
        super.prepare()
        
        // 1.获取cell的个数
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        
        // 2.给每个cell创建一个UICollectionViewLayoutAttributes
        let cellW: CGFloat = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - CGFloat(cols - 1) * minimumInteritemSpacing) / CGFloat(cols)
        for i in 0..<itemCount {
            // 1.根据i创建indexPath
            let indexPath = IndexPath(item: i, section: 0)
            
            // 2.根据indexPath创建UICollectionViewLayoutAttributes
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 3.设置attr中的frame
            let minH = totalHeights.min()!
            let minIndex = totalHeights.firstIndex(of: minH)!
            
            guard let cellH: CGFloat = dataSouce?.waterFall(self, indexPath: indexPath) else {
                fatalError("请是吸纳对应的数据源方法,并返回cell高度")
            }
            let cellX: CGFloat = sectionInset.left + (minimumInteritemSpacing + cellW) * CGFloat(minIndex)
            let cellY: CGFloat = minH + minimumLineSpacing
            attr.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
            
            // 4.保存attr
            cellAttrs.append(attr)
            
            // 5.添加当前的高度
            totalHeights[minIndex] = minH + minimumLineSpacing + cellH
        }
    }
}

// MARK: - 返回准备好的所有布局
extension HHYWaterFallLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return cellAttrs
    }
}

// MARk: - 设置contentSize
extension HHYWaterFallLayout {
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView!.frame.size.width, height: totalHeights.max()! + sectionInset.bottom)
    }
}
