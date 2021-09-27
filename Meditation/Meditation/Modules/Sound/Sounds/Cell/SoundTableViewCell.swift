//
//  SoundTableViewCell.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 27.09.21.
//

import UIKit

class SoundTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var soundImage: UIImageView!
    @IBOutlet weak var listeningLabel: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(title: String, image: UIImage?, count: Int, duration: String) {
        self.title.text = title
        soundImage.image = image
        listeningLabel.text = "\(count) Listening"
        self.duration.text = "\(duration) min"
    }
}
