//
//  SoundTableViewCell.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 27.09.21.
//

import UIKit
import FirebaseStorage

class SoundTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var soundImage: UIImageView!
    @IBOutlet weak var listeningLabel: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        soundImage.kf.indicatorType = .activity
        (soundImage.kf.indicator?.view as? UIActivityIndicatorView)?.color = .white
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        soundImage.image = nil
        title.text = ""
        listeningLabel.text = ""
        duration.text = ""
    }
    
    func configure(title: String, imageUrl: String, count: Int, duration: String) {
        self.title.text = title
        listeningLabel.text = "\(count) Listening"
        self.duration.text = "\(duration) min"
        guard let url = URL(string: imageUrl) else { return }
        soundImage.kf.setImage(with: url)
    }
}
