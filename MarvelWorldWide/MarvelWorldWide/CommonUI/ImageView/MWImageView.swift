//
//  MWImageView.swift
//  MarvelWorldWide
//
//  Created by akreyers on 23/4/22.
//

import UIKit

class CommonImageView: UIImageView {
    
    // MARK: - Properties
    public var cornerRadiusActive = true {
        didSet {
            if cornerRadiusActive {
                layer.cornerRadius = cornerRadiusValue
            }
        }
    }
    private let cornerRadiusValue: CGFloat = 14
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Functions
    private func setup() {}
}
