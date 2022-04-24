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

extension MWHomeListViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MWHomeListTableViewCell.reuseIdentifier, for: indexPath) as? MWHomeListTableViewCell else { fatalError("Cell not found!!")
        }
        
        if isLoadingCell(for: indexPath) {
            cell.model = .none
        } else {
            cell.model = viewModel.modelForCellAt(indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Show ScrollToTopButton Depends to the tableView item visible.(For example at 6 row show the up indicator)
        indexPath.row > 6 ? showScrollToTopButton(true) : showScrollToTopButton(false)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = viewModel.modelForCellAt(indexPath.row)
        self.coordinator.navigateToCharacterDetail(characterId: selectedRow.characterId)
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.getMarvelCharacterList(isRefreshData: false, completionTest: nil)
          }
    }
}

// MARK: - MWHomeListViewController
extension  MWHomeListViewController {
  func isLoadingCell(for indexPath: IndexPath) -> Bool {
      return indexPath.row >= viewModel.currentCount
  }

  func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
    let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows ?? []
    let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
    return Array(indexPathsIntersection)
  }
}

