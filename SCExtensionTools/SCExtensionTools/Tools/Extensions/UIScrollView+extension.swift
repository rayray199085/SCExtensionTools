//
//  UIScrollView+extension.swift
//  MyFishInfo
//
//  Created by Stephen Cao on 26/7/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

extension UIScrollView{
    func currentIndex(collectionView: UICollectionView)->Int{
        var center = self.center
        center.x += self.contentOffset.x
        let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        var targetIndexPath: IndexPath?
        for indexPath in visibleIndexPaths{
            let cell = collectionView.cellForItem(at: indexPath)
            if cell?.frame.contains(center) == true{
                targetIndexPath = indexPath
                break
            }
        }
        guard let indexPath = targetIndexPath else{
            return 0
        }
        return indexPath.item
    }
}
