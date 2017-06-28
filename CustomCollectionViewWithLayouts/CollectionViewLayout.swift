//
//  CollectionViewLayout.swift
//  CustomCollectionViewWithLayouts
//
//  Created by Khrystyna Shevchuk on 6/27/17.
//  Copyright © 2017 Khrystyna Shevchuk. All rights reserved.
//

import UIKit


//MARK: CollectionViewLayoutDelegate

protocol CollectionViewLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: NSIndexPath, withWidth: CGFloat) -> CGFloat
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth: CGFloat) -> CGFloat
}


//MARK: CollectionViewLayoutAttributes

class CollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    
    var imageHeight: CGFloat = 0
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! CollectionViewLayoutAttributes
        copy.imageHeight = imageHeight
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? CollectionViewLayoutAttributes {
            if attributes.imageHeight == imageHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
}


//MARK: CollectionViewLayout

class CollectionViewLayout: UICollectionViewLayout {
    
    var delegate: CollectionViewLayoutDelegate!
    var numberOfColumns: Int = 1
    var cellPadding: CGFloat = 0
    var insets = UIEdgeInsets.zero
    
    private var cache = [CollectionViewLayoutAttributes]()
    private var contentHeight: CGFloat = 0
    private var width: CGFloat {
        get {
            insets = collectionView!.contentInset
            let bounds = collectionView!.bounds
            return bounds.width - insets.left - insets.right
        }
    }
    
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: width, height: contentHeight)
        }
    }
    
    override class var layoutAttributesClass: AnyClass {
        return CollectionViewLayoutAttributes.self
    }
    
    override func prepare() {
        
        if cache.isEmpty {
            let collumnWidth = width / CGFloat(numberOfColumns)
            var xOffsets = [CGFloat]()
            
            for collumn in 0..<numberOfColumns {
                xOffsets.append(CGFloat(collumn) * collumnWidth)
            }
            
            var yOffsets = [CGFloat](repeating: 0, count: numberOfColumns)
            
            var column = 0
            for item in 0..<collectionView!.numberOfItems(inSection: 0) {
                
                let indexPath = IndexPath(item: item, section: 0)
                
                var oneColumn = Int(collectionView!.numberOfItems(inSection: 0)/numberOfColumns)
                if collectionView!.numberOfItems(inSection: 0)%numberOfColumns != 0 {
                    oneColumn += 1
                }
                column = Int(item/(oneColumn))

                let width = collumnWidth - (cellPadding * 2)
                let imageHeight = delegate.collectionView(collectionView: collectionView!, heightForImageAtIndexPath: indexPath as NSIndexPath, withWidth: width)
                let annotationHeight = delegate.collectionView(collectionView: collectionView!, heightForAnnotationAtIndexPath: indexPath as NSIndexPath, withWidth: width)
                let height = cellPadding + imageHeight + annotationHeight + cellPadding
                
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: collumnWidth, height: height)
                let insetFrame = UIEdgeInsetsInsetRect(frame, insets) //insets = cellpadding, cellpadding
                
                let attributes = CollectionViewLayoutAttributes(
                    forCellWith: indexPath
                )
                attributes.frame = insetFrame
                attributes.imageHeight = imageHeight
                cache.append(attributes)
                
                let cgrectFrame = frame
                contentHeight = max(contentHeight, cgrectFrame.maxY)
                yOffsets[column] = yOffsets[column] + height
            }
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        
        return layoutAttributes
    }
}
