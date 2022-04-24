//
//  MWHomeListTableViewCell.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import UIKit
import Kingfisher

class MWHomeListTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var viewContent: UIView! {
        didSet {
            viewContent.layer.cornerRadius = 14
            viewContent.layer.shadowColor = MWColor.black.cgColor
            viewContent.layer.shadowOpacity = 0.3
            viewContent.layer.shadowOffset = .zero
            viewContent.layer.shadowRadius = 10
        }
    }
    
    @IBOutlet weak var characterImageView: CommonImageView! {
        didSet {
            characterImageView.cornerRadiusActive = true
        }
    }
    
    @IBOutlet weak var characterNameLabel: CommonLabel!
    
    @IBOutlet weak var descriptionLabel: CommonLabel!
    
    
    // MARK: - Properties
    class var nibName: String {
        String(describing: MWHomeListTableViewCell.self)
    }
    
    class var reuseIdentifier: String {
        "\(String(describing: MWHomeListTableViewCell.self))Identifier"
    }
    
    var model: MWHomeListCellModel? {
        didSet {
            guard let localModel = model else {
                characterImageView.alpha = 0
                characterNameLabel.alpha = 0
                descriptionLabel.alpha = 0
                activityIndicatorView.startAnimating()
                return
            }
            characterImageView.alpha = 1
            characterNameLabel.alpha = 1
            descriptionLabel.alpha = 1
            characterImageView.kf.setImage(with: localModel.urlImageCell, placeholder: nil, options: nil, completionHandler: nil)
            characterNameLabel.text = localModel.title
            descriptionLabel.text = localModel.description.isEmpty ? "Home_home_list_description_empty_title_label".localized() : localModel.description
            activityIndicatorView.stopAnimating()
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicatorView.hidesWhenStopped = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        model = .none
    }

    // MARK: - Functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
}
