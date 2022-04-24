//
//  MWDetailViewController.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import UIKit
import Kingfisher

class MWDetailViewController: BaseViewController, MWDetailViewControllerProtocol {

    // MARK: - Outlets
    @IBOutlet weak var viewContentStackView: UIStackView! {
        didSet {
            viewContentStackView.alpha = 0
        }
    }
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    @IBOutlet weak var characterTitleLabel: CommonLabel!
    @IBOutlet weak var characterDescriptionLabel: CommonLabel!
    
    @IBOutlet weak var comicTitleLabel: CommonLabel!
    @IBOutlet weak var comicCollectionView: UICollectionView! {
        didSet {
            comicCollectionView.delegate = self
            comicCollectionView.dataSource = self
            
            comicCollectionView.register(UINib(nibName: CommonCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: CommonCollectionViewCell.reuseIdentifier)
        }
    }
    @IBOutlet weak var comicStackView: UIStackView!
    
    
    @IBOutlet weak var serieTitleLabel: CommonLabel!
    @IBOutlet weak var serieCollectionView: UICollectionView! {
        didSet {
            serieCollectionView.delegate = self
            serieCollectionView.dataSource = self
            
            serieCollectionView.register(UINib(nibName: CommonCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: CommonCollectionViewCell.reuseIdentifier)
        }
    }
    @IBOutlet weak var serieStackView: UIStackView!
    
    // MARK: - Properties
    var viewModel: MWDetailViewModelProtocol!
    var coordinator: MWDetailCoordinatorProtocol!
    
    let defaultWidth: CGFloat = 150
    var model: MWDetailViewControllerModel? {
        didSet {
            guard let localModel = model else { return }
            characterImageView.kf.setImage(with: localModel.imageURL, placeholder: nil, options: nil, completionHandler: nil)
            characterTitleLabel.text = localModel.title
            characterDescriptionLabel.text = localModel.description
            if localModel.series.isEmpty {
                serieStackView.isHidden = true
            }
            if localModel.comics.isEmpty {
                comicStackView.isHidden = true
            }
            comicCollectionView.reloadData()
            serieCollectionView.reloadData()
            title = model?.title
            viewContentStackView.isHidden = false
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.viewContentStackView.alpha = 1.0
            }
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.getMarvelCharacterDetail(completionTest: nil)
    }

    // MARK: - Functions

}
