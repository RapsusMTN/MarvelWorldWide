//
//  MWHomeListViewController+UISearchBarDelegate.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import UIKit

/**
 Search Bar Delegate to filter all character list by query name.
 */

extension MWHomeListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        // if the query is empty or nil, I reset the offset and show the default characters from the first page
        guard let queryValue = searchBar.text, queryValue != "" else {
            viewModel.currentFilteredName = nil
            viewModel.resetOffsetPage()
            viewModel.getMarvelCharacterList(isRefreshData: false, completionTest: nil)
            return
        }
        
        viewModel.currentFilteredName = queryValue
        
        viewModel.getMarvelCharacterList(isRefreshData: false, completionTest: nil)
    }
}
