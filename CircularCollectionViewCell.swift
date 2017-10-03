//
//  CircularCollectionViewCell.swift
//
//  Created by Philippe Asselbergh on 13/09/2017.
//  Copyright © 2017 Philippe Asselbergh. All rights reserved.
//

import UIKit

class CircularCollectionViewCell: UICollectionViewCell {
    var imageName = "" {
        didSet {
            imageView!.image = UIImage(named: imageName)
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        contentView.layer.cornerRadius = 50
        contentView.layer.borderColor = UIColor.black.cgColor
        contentView.layer.borderWidth = 0
        contentView.layer.shouldRasterize = true
        contentView.layer.rasterizationScale = UIScreen.main.scale
        contentView.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //imageView!.contentMode = .scaleAspectFill
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let att = layoutAttributes as! CircularCollectionViewLayoutAttributes
            self.layer.anchorPoint = att.anchorPoint
            self.center.y += (att.anchorPoint.y - 0.5)*self.bounds.height
    }
    
}
