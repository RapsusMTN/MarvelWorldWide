//
//  MWHomeListViewController+UITableViewDelegate+DataSource.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import UIKit
/**
 Extension to manage DataSource and delegate table view.
 */

extension MWHomeListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MWHomeListTableViewCell.reuseIdentifier, for: indexPath) as? MWHomeListTableViewCell else { fatalError("Cell not found!!")
        }
        
        cell.model = viewModel.modelForCellAt(indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Show ScrollToTopButton Depends to the tableView item visible.(For example at 6 row show the up indicator)
        indexPath.row > 6 ? showScrollToTopButton(true) : showScrollToTopButton(false)
        
        // Pagination (fetch more pages from API)
        guard viewModel.getCharacterList().count >= Constant.limit else { return }
        if indexPath.row == viewModel.lastCell {
            // if there is no more content, no more calls are made to optimize resources
            if viewModel.hasMoreContentToFetch {
                viewModel.fetchMorePage()
                print("Fetch next Page Offset = \(viewModel.getCurrentOffset())")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = viewModel.modelForCellAt(indexPath.row)
        self.coordinator.navigateToCharacterDetail(characterId: selectedRow.characterId)
    }
}
