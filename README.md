# CustomCollectionViewWithLayouts
Custom collection view layout with different images sizes

|             Demo                |
|---------------------------------|
|![Demo](https://github.com/KhrystynaShevchuk/CustomCollectionViewWithLayouts/blob/master/CustomCollectionViewWithLayouts/Demo.gif)|

## Contents
- [Requirements](#requirements)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)


## Requirements

- iOS 8.0+
- Swift 3.0+

## Installation

All logic is in [CollectionViewLayout.swift](https://github.com/KhrystynaShevchuk/CustomCollectionViewWithLayouts/blob/master/CustomCollectionViewWithLayouts/CollectionViewLayout.swift) file.
Just copy this [file](https://github.com/KhrystynaShevchuk/CustomCollectionViewWithLayouts/blob/master/CustomCollectionViewWithLayouts/CollectionViewLayout.swift) to your project.


# Usage

1 - In storyboard set layout of collection view as custom and set class to CollectionViewLayout.

2 - Setup layout of collection view.
```swift 
guard let layout = collectionViewLayout as? CollectionViewLayout else { return }
layout.delegate = self
layout.cellPadding = 5
layout.numberOfColumns = 2
```

3 - Implement methods of CollectionViewLayoutDelegate
```swift 
protocol CollectionViewLayoutDelegate {
    
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: NSIndexPath, withWidth: CGFloat) -> CGFloat
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: NSIndexPath, withWidth: CGFloat) -> CGFloat
}
```
For instance it can be:
```swift
extension ImagesCollectionVC: CollectionViewLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForImageAtIndexPath indexPath: NSIndexPath, withWidth: CGFloat) -> CGFloat {
        //calculate the best height for image depended on available width
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
```

## License

Reusable is released under the MIT license. See [LICENSE](https://github.com/KhrystynaShevchuk/CustomCollectionViewWithLayouts/blob/master/LICENSE) for details.

