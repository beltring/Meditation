//
//  MeditationProgramsView.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 24.09.21.
//

import UIKit

class MeditationProgramsView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var programNameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "MeditationPrograms", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
}
