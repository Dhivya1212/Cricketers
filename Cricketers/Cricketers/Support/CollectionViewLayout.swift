//
//  CollectionViewLayout.swift
//  Cricketers
//
//  Created by Adaikalraj on 12/03/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

protocol CollectionLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView,sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize
}

// MARK:- CollectionView cell custom layout.

class CollectionLayout: UICollectionViewLayout{
    
    weak var delegate: CollectionLayoutDelegate?
    
    private let numberOfColumns = 2
    private let cellPadding: CGFloat = 3
    
    fileprivate var cache = [UICollectionViewLayoutAttributes]()
    fileprivate var contentHeight: CGFloat = 0
    
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }
        return collectionView.bounds.width
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        guard cache.isEmpty, let collectionView = collectionView else {
            return
        }
        
        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        var xOffset: [CGFloat] = []
        for column in 0..<numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }
        
        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        
        for item in 0..<collectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(item: item, section: 0)
            
            let photoHeight = delegate!.collectionView(collectionView,sizeOfPhotoAtIndexPath: indexPath)
            
            let cellWidth = columnWidth
            var cellHeight = photoHeight.height * cellWidth / photoHeight.width
            
            cellHeight = cellPadding * 2 + cellHeight
            
            let frame = CGRect(x: xOffset[column],y: yOffset[column],width: cellWidth,height: cellHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffset[column] = yOffset[column] + cellHeight
            
            column = column < (numberOfColumns - 1) ? (column + 1) : 0
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }
}
