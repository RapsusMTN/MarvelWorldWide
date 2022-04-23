//
//  MWDetailViewController+UICollectionViewDelegate+DataSource.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Foundation
import UIKit

extension MWDetailViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommonCollectionViewCell.reuseIdentifier, for: indexPath) as? CommonCollectionViewCell,
        let unWrapModel = model else { fatalError("Cell not found!") }
        if collectionView == comicCollectionView {
            cell.model = CommonCollectionViewElementModel(element: unWrapModel.comics[indexPath.row])
        } else if collectionView == serieCollectionView {
            cell.model = CommonCollectionViewElementModel(element: unWrapModel.series[indexPath.row])
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == comicCollectionView {
            return model?.comics.count ?? 0
        } else if collectionView == serieCollectionView {
            return model?.series.count ?? 0
        } else {
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: defaultWidth, height: self.serieCollectionView.frame.height)
    }
    
    
}
