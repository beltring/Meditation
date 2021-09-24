//
//  ProgramTableViewCell.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 24.09.21.
//

import UIKit

class ProgramTableViewCell: UITableViewCell {

    @IBOutlet weak var programNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var programImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.masksToBounds = true
        self.contentView.layer.cornerRadius = 13
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
