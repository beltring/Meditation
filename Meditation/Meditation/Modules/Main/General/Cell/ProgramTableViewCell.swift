//
//  ProgramTableViewCell.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 24.09.21.
//

import Kingfisher
import UIKit

class ProgramTableViewCell: UITableViewCell {

    @IBOutlet private weak var programNameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var programImage: UIImageView!
    @IBOutlet weak var watchButton: UIButton!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        programImage.kf.indicatorType = .activity
    }
    
    // MARK: - Setup
    func configure(name: String, description: String, imageUrl: String) {
        programNameLabel.text = name
        descriptionLabel.text = description
        guard let url = URL(string: imageUrl) else { return }
        programImage.kf.setImage(with: url)
    }
}
