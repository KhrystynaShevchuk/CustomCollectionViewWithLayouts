//
//  CollectionCell.swift
//  CustomCollectionViewWithLayouts
//
//  Created by Khrystyna Shevchuk on 6/27/17.
//  Copyright © 2017 Khrystyna Shevchuk. All rights reserved.
//

import UIKit


class CollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptLabel: UILabel!
    
    var isShortText: Bool = true
    
    var image: UIImage? {
        didSet {
            if let image = image {
                imageView.image = image
            }
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let attributes = layoutAttributes as! CollectionViewLayoutAttributes
        imageViewHeightLayoutConstraint.constant = attributes.imageHeight
    }
}
