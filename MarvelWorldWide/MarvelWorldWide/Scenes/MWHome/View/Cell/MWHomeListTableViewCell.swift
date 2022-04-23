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
    @IBOutlet weak var viewContent: UIView! {
        didSet {
            viewContent.layer.cornerRadius = 14
            viewContent.layer.shadowColor = UIColor.black.cgColor
            viewContent.layer.shadowOpacity = 0.3
            viewContent.layer.shadowOffset = .zero
            viewContent.layer.shadowRadius = 10
        }
    }
    
    @IBOutlet weak var characterImageView: CommonImageView!
    
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
            guard let localModel = model else { return }
            characterImageView.kf.setImage(with: localModel.urlImageCell, placeholder: nil, options: nil, completionHandler: nil)
            characterNameLabel.text = localModel.title
            descriptionLabel.text = localModel.description.isEmpty ? "Home_home_list_description_empty_title_label".localized() : localModel.description
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Functions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
}
