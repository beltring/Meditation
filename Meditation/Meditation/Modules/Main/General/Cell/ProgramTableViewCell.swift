//
//  ProgramTableViewCell.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 24.09.21.
//

import AMPopTip
import UIKit

class ProgramTableViewCell: UITableViewCell {

    @IBOutlet weak var programNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var programImage: UIImageView!
    @IBOutlet weak var watchButton: UIButton!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Setup
    func configure(name: String, description: String, image: UIImage?) {
        programNameLabel.text = name
        descriptionLabel.text = description
        programImage.image = image
    }
}
