//
//  CircularCollectionViewLayoutAttributes.swift
//
//  Created by Philippe Asselbergh on 26/09/2017.
//  Copyright © 2017 Philippe Asselbergh. All rights reserved.
//

import UIKit

public class CircularCollectionViewLayoutAttributes: UICollectionViewLayoutAttributes {
    public var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    
    public var angle: CGFloat = 50 {
        didSet {
            zIndex = Int(angle*100000)
            transform = CGAffineTransform.init(rotationAngle: angle)
        }
    }
    override public func copy(with zone: NSZone? = nil) -> Any {
        
        let copiedAttributes: CircularCollectionViewLayoutAttributes = super.copy(with: zone) as! CircularCollectionViewLayoutAttributes
        copiedAttributes.anchorPoint = self.anchorPoint
        copiedAttributes.angle = self.angle
        return copiedAttributes
    }
}

