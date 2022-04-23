//
//  CommonCollectionViewCell.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import UIKit
import Kingfisher

class CommonCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var elementImageView: UIImageView!
    
    @IBOutlet weak var elementTitleLabel: CommonLabel!
    @IBOutlet weak var elementDescriptionLabel: CommonLabel!
    
    // MARK: - Properties
    var model: CommonCollectionViewElementModel? {
        didSet {
            guard let localModel = model else { return }
            elementImageView.kf.setImage(with: localModel.element.imageURL, placeholder: nil, options: nil, completionHandler: nil)
            elementTitleLabel.text = localModel.element.title
            if let desc = localModel.element.description {
                elementDescriptionLabel.text = desc == "" ? "No description" : localModel.element.description
            } else {
                elementDescriptionLabel.text = "No description"
            }

        }
    }
    
    class var reuseIdentifier: String {
        "\(String(describing: CommonCollectionViewCell.self))Identifier"
    }
    
    class var nibName: String {
        String(describing: CommonCollectionViewCell.self)
    }
    
    override var isHighlighted: Bool {
        didSet {
            elementImageView.animateViewCellTap(isHighlighted: isHighlighted)
        }
    }
    
    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Functions
}
