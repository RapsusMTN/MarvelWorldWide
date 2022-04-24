//
//  MWHomeListViewController.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import Lottie
import UIKit

class MWHomeListViewController: BaseViewController, MWHomeListViewControllerProtocol {
    
    
    // MARK: - Outlets
    @IBOutlet weak var noContentView: UIView!
    
    @IBOutlet weak var noContentAnimationView: UIView! {
        didSet {
            noContentAnimationView.addPlaceholderAnimation("noContents", animationMode: .loop, completion: nil)
        }
    }
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.prefetchDataSource = self
            tableView.dataSource = self
            tableView.refreshControl = refreshControl
            
            tableView.register(UINib(nibName: MWHomeListTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: MWHomeListTableViewCell.reuseIdentifier)
            
            tableView.estimatedRowHeight = UITableView.automaticDimension
        }
    }
    
    @IBOutlet weak var scrollTopButton: UIButton! {
        didSet {
            scrollTopButton.alpha = 0
            scrollTopButton.layer.cornerRadius = scrollTopButton.frame.height / 2
            scrollTopButton.layer.shadowColor = MWColor.black.cgColor
            scrollTopButton.layer.shadowOpacity = 0.3
            scrollTopButton.layer.shadowOffset = .zero
            scrollTopButton.layer.shadowRadius = 10
        }
    }
    
    // MARK: - Properties
    var viewModel: MWHomeViewModelProtocol!
    var coordinator: MWHomeCoordinatorProtocol!
    
    
    /// Table View Refresh Control
    private lazy var refreshControl: UIRefreshControl = {
       let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        title = "Home_home_list_navbar_title_label".localized()
        self.viewModel.getMarvelCharacterList(isRefreshData: false, completionTest: nil)
    }
    
    // MARK: - Functions
    func reloadData(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload else {
          isLoading = false
          tableView.isHidden = false
          tableView.reloadData()
          return
        }
        // 2
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
    // MARK: - Animation
    public func showScrollToTopButton(_ isVisible: Bool) {
        let alpha = isVisible ? 1.0 : 0.0
        UIView.animate(withDuration: 0.5) {
            self.scrollTopButton.alpha = alpha
        }
    }
    
    public func showNoContentView() {
        UIView.animate(withDuration: 0.5) {
            self.noContentView.alpha = 1.0
        }
    }
    
    func hideNoContentView() {
        UIView.animate(withDuration: 0.5) {
            self.noContentView.alpha = 0.0
        }
    }
    
    public func endRefreshData() {
        refreshControl.endRefreshing()
    }
    
    // MARK: - Action/Selector
    @IBAction func buttonScrollToTopTapped(_ sender: Any) {
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    @objc func refreshData() {
        viewModel.resetOffsetPage()
        viewModel.currentFilteredName = nil
        searchBar.text = nil
        viewModel.getMarvelCharacterList(isRefreshData: true, completionTest: nil)
    }
}
