//
//  WaterFallViewLayout.swift
//  Hana
//
//  Created by kimgwanghwa on 2018/06/03.
//

import UIKit

protocol WaterFallViewLayoutDelegate: class {
    
    func waterFallViewLayout(layout: WaterFallViewLayout, heightForItemAt item: Int) -> CGFloat
    
    func columnCountInWaterFallViewLayout(layout: WaterFallViewLayout) -> Int
    
    func columMarginInWaterFallViewLayout(layout: WaterFallViewLayout) -> CGFloat
    
    func rowMarginInWaterFallLayout(layout: WaterFallViewLayout) -> CGFloat

    func edgeInsetdInWaterFallLayout(layout: WaterFallViewLayout) -> UIEdgeInsets

}

class WaterFallViewLayout: UICollectionViewLayout {

    weak var delegate: WaterFallViewLayoutDelegate?
    
    var colunmCount: Int {
        if delegate != nil {
            return delegate!.columnCountInWaterFallViewLayout(layout: self)
        }
        return 3
    }
    
    var colunmMargin: CGFloat {
        if delegate != nil {
            return delegate!.columMarginInWaterFallViewLayout(layout: self)
        }
        return 10
    }
    
    var rowMargin: CGFloat {
        if delegate != nil {
            return delegate!.rowMarginInWaterFallLayout(layout: self)
        }
        return 10
    }

    var edgeInsets: UIEdgeInsets {
        if delegate != nil {
            return delegate!.edgeInsetdInWaterFallLayout(layout: self)
        }
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    //attribute
    var attributes = [UICollectionViewLayoutAttributes]()
    var columnHeights = [CGFloat]()
    var contentHeight: CGFloat = 0
    

    
    
    override func prepare() {
        columnHeights.removeAll()
        attributes.removeAll()
        
        for _ in 0..<colunmCount {
            columnHeights.append(edgeInsets.top)
        }
        
        let itemCount = collectionView?.numberOfItems(inSection: 0) ?? 0
        for i in 0..<itemCount {
            let indexPath = IndexPath.init(item: i, section: 0)
            if let attributesForItem = self.layoutAttributesForItem(at: indexPath) {
                attributes.append(attributesForItem)
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let collectionWidth = collectionView?.width ?? 0.0
        
        let cellWidth = (collectionWidth - edgeInsets.left - edgeInsets.right - CGFloat(colunmCount - 1) * colunmMargin) / CGFloat(colunmCount)
        let cellHeight = delegate!.waterFallViewLayout(layout: self, heightForItemAt: indexPath.row)

        
        
        let x = attributes.frame.maxX
        let currentcolumn = indexPath.row % colunmCount
        let y = columnHeights[currentcolumn]
        columnHeights[currentcolumn] += cellHeight + rowMargin + edgeInsets.top
        
        attributes.frame = CGRect(x: x, y: y, width: cellWidth, height: cellHeight)
        
        return attributes
        
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: contentHeight)
    }
    
    
}
