//
//  ImagesCollectionVC.swift
//  CustomCollectionViewWithLayouts
//
//  Created by Khrystyna Shevchuk on 6/23/17.
//  Copyright © 2017 Khrystyna Shevchuk. All rights reserved.
//

import UIKit
import AVFoundation


class ImagesCollectionVC: UICollectionViewController {
        
    var images: [UIImage] = [#imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "11"), #imageLiteral(resourceName: "10"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "8"), #imageLiteral(resourceName: "9"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "11"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "10"), #imageLiteral(resourceName: "13"), #imageLiteral(resourceName: "12"), #imageLiteral(resourceName: "6")]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    
    //MARK: vc life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionViewInsets()
        setupLayout()
    }
    
    
    //MARK: private
    
    private func setupCollectionViewInsets() {
        collectionView!.backgroundColor = .clear
        collectionView!.contentInset = UIEdgeInsets(top: 15, left: 5, bottom: 5, right: 5)
    }
    
    private func setupLayout() {
        let layout = collectionViewLayout as! CollectionViewLayout
        layout.delegate = self
        layout.cellPadding = 5
        layout.numberOfColumns = 2
    }
}


//MARK: UICollectionViewDataSource

extension ImagesCollectionVC {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as! CollectionCell
        cell.image = images[indexPath.item]
        
        // bad way of setting text, but just for a test
        if indexPath.item % 2 == 0 {
            cell.descriptLabel.text = "Very short description"
        } else {
            cell.descriptLabel.text = "Tonight, there are no lovers walking down the park alleys. There are no kings in the castles, and the princesses die alone – they have no frogs or peas. Tonight, the inkpots are empty, and the words are uncountable. Tonight, all shouts are muffled by unbearable silence."
        }
        
        return cell
    }
}


//MARK: CollectionViewLayoutDelegate

extension ImagesCollectionVC: CollectionViewLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: NSIndexPath, withWidth: CGFloat) -> CGFloat {
        
        let image = images[indexPath.item]
        let boundingRect = CGRect(x: 0, y: 0, width: withWidth, height: CGFloat(MAXFLOAT))
        let rect = AVMakeRect(aspectRatio: image.size, insideRect: boundingRect)
        return rect.height
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth: CGFloat) -> CGFloat {
        if indexPath.item % 2 == 0 {
            return 40
        }
        return 80
    }
}
