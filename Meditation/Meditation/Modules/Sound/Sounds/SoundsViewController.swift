//
//  SoundsViewController.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 22.09.21.
//

import UIKit

class SoundsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SoundTableViewCell.registerCellNib(in: tableView)
    }

}

// MARK: - Extensions
// MARK: - UITableViewDataSource
extension SoundsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SoundTableViewCell.dequeueReusableCell(in: tableView, for: indexPath)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SoundsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "BackgroundColor")
        return headerView
    }
}
