//
//  CircularCollectionViewLayout.swift
//
//  Created by Philippe Asselbergh on 13/09/2017.
//  Copyright © 2017 Philippe Asselbergh. All rights reserved.
//

import UIKit

public class CircularCollectionViewLayout: UICollectionViewLayout {
    
    public var itemSize : CGSize {
        if let collectionView = collectionView{
            let numOfItems = CGFloat(collectionView.numberOfItems(inSection: 0))
            let w = numOfItems * 150 < collectionView.bounds.width ? ((collectionView.bounds.width+15)/numOfItems) : 150
            return CGSize(width: w, height: 150)
        }
        
        return CGSize(width: 150, height: 150)
    }
    
    public var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItems(inSection: 0) > 0 ? -CGFloat(collectionView!.numberOfItems(inSection: 0)-1)*anglePerItem : 0
    }
    
    public var angle: CGFloat {
        let collAngle = angleAtExtreme*collectionView!.contentOffset.x/(collectionViewContentSize.width - ((collectionView?.bounds.width)!))
        //print(collAngle)
        return collAngle
    }
    
    public var radius: CGFloat = 500 {
        didSet {
            invalidateLayout()
        }
    }
    
    public var anglePerItem: CGFloat {
        return atan(itemSize.width/(radius))
    }
    
    public var attributesList = [CircularCollectionViewLayoutAttributes]()
    
    override public var collectionViewContentSize: CGSize{
        return CGSize(width: CGFloat(collectionView!.numberOfItems(inSection: 0))*itemSize.width,
                      height: collectionView!.bounds.height)
    }
    
    override public class var layoutAttributesClass: AnyClass {
        return CircularCollectionViewLayoutAttributes.self
    }
    
    override public func prepare() {
        super.prepare()
        let centerX = collectionView!.contentOffset.x + (collectionView!.bounds.width/2.0)
        let anchorPointY = ((itemSize.height/2.0) + radius)/itemSize.height
        //1
        let theta = atan2(collectionViewContentSize.width/2.0, radius + (itemSize.height/2.0) - (collectionView!.bounds.height/2.0)) //1//collectionView!.bounds.width
        //2
        var startIndex = 0
        var endIndex = collectionView!.numberOfItems(inSection: 0) - 1
        //3
        if (angle < -theta) {
            startIndex = Int(floor((-theta - angle)/anglePerItem))
        }
        //4
        endIndex = min(endIndex, Int(ceil((theta - angle)/anglePerItem)))
        //5
        if (endIndex < startIndex) {
            endIndex = 0
            startIndex = 0
        }
        attributesList = (startIndex...endIndex).map { (i) -> CircularCollectionViewLayoutAttributes in
            let attributes = CircularCollectionViewLayoutAttributes(forCellWith: NSIndexPath(item: i, section: 0) as IndexPath)
            attributes.size = self.itemSize
            attributes.center = CGPoint(x: centerX, y: self.collectionView!.bounds.midY)
            attributes.angle = self.angle + (self.anglePerItem*CGFloat(i))
            attributes.anchorPoint = CGPoint(x: 0.5, y: anchorPointY)
            return attributes
        }
    }
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesList
    }
    
    override public func layoutAttributesForItem(at indexPath: IndexPath) -> (UICollectionViewLayoutAttributes!) {
        return attributesList[indexPath.row]
    }
    
    override public func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
    override public func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var finalContentOffset = proposedContentOffset
        let factor = -angleAtExtreme/((collectionView?.contentSize.width)! - (collectionView?.bounds.width)!) //(collectionView?.bounds.width)!)
         let proposedAngle = proposedContentOffset.x*factor
         let ratio = proposedAngle/anglePerItem
         var multiplier: CGFloat
         if (velocity.x > 0) {
         multiplier = ceil(ratio)
         } else if (velocity.x < 0) {
         multiplier = floor(ratio)
         } else {
         multiplier = round(ratio)
         }
         finalContentOffset.x = multiplier*anglePerItem/factor
         return finalContentOffset
     }
    
}

