//
//  WaterFallLayout.swift
//  waterFallLayout
//
//  Created by MAC on 07/11/20.
//

import UIKit

protocol WaterFallLayoutDelegate: class {
  func collectionView(_ collectionView: UICollectionView, sizeOfPhotoAtIndexPath indexPath: IndexPath) -> CGSize
}

class WaterFallLayout: UICollectionViewLayout {

    weak var delegate: WaterFallLayoutDelegate!
    
    var numberOfColumns:CGFloat = 2
    var cellPadding:CGFloat = 5.0
    
    private var contentHeight:CGFloat = 0.0 //cellHeight
    private var contentWidth:CGFloat{ // cellWidth
        let insets = collectionView!.contentInset
        return (collectionView!.bounds.width - (insets.left + insets.right))//left to right insets are divided
    }
    
    private var attributesCache = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {  //collectionView Layout calculate attribute
        if attributesCache.isEmpty{
            //collectionView all attribute are empty
            let columnWidth = contentWidth / numberOfColumns
            var xOffSet = [CGFloat]() // xSide is zero(0)
            for column in 0..<Int(numberOfColumns){
                xOffSet.append(CGFloat(column) * columnWidth)
            }
            
            var column = 0
            var yOffSet = [CGFloat](repeating: 0, count: Int(numberOfColumns))   //Top is zero(0)
            for  item in 0..<collectionView!.numberOfItems(inSection: 0){
                let indexPath = IndexPath(item: item, section: 0)
                //calculate the fram
                
                let photoHeight:CGFloat = 0.0
                let captionHeight:CGFloat = 0.0
                
                _ = columnWidth - cellPadding * 2
                let height:CGFloat = cellPadding + photoHeight + captionHeight + cellPadding
                let frame = CGRect(x: xOffSet[column], y: yOffSet[column], width: columnWidth, height: height)
                
                let insetsFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                
                attributes.frame = insetsFrame
                attributesCache.append(attributes)
                
                //upadate column xoffset, yoffset
                contentHeight = max(contentHeight,frame.maxY)
                yOffSet[column] = yOffSet[column] + height
                if column >= (Int(numberOfColumns) - 1){
                    column = 0
                }else{
                    column += 1
                }
            
            }
        }
    }
    override var collectionViewContentSize: CGSize{
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttribute = [UICollectionViewLayoutAttributes]()
        for attributes in attributesCache{
            if attributes.frame.intersects(rect){
                layoutAttribute.append(attributes)
            }
        }
        return layoutAttribute
    }
    
}
