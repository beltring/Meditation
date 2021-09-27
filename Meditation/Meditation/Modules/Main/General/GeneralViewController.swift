//
//  GeneralViewController.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 23.09.21.
//

import Firebase
import UIKit

class GeneralViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var calmButton: UIButton!
    @IBOutlet weak var relaxButton: UIButton!
    @IBOutlet weak var focusButton: UIButton!
    @IBOutlet weak var anxiousButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var dataSource = [Program]()
    private var user: User!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        prepareDataSource()
        getUser()
        setupWelcomeLabel()
    }
    
    // MARK: - Setup
    private func setupTableView() {
        ProgramTableViewCell.registerCellNib(in: tableView)
    }
    
    private func prepareDataSource() {
        dataSource.append(Program(title: "Meditation 101", description: "Techniques, Benefits, and a Beginner’s How-To", image: UIImage(named: "imgMeditation101")))
        dataSource.append(Program(title: "Cardio Meditation", description: "Basics of Yoga for Beginners or Experienced Professionals", image: UIImage(named: "imgCardioMeditation")))
    }
    
    private func setupWelcomeLabel() {
        if let name = user.displayName {
            welcomeLabel.text = "Welcome back, \(name)!"
        } else {
            welcomeLabel.text = "Welcome back!"
        }
        
    }
    
    // MARK: - API calls
    private func getUser() {
        user = Auth.auth().currentUser
    }
}

// MARK: - Extensions
// MARK: - UITableViewDataSource
extension GeneralViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ProgramTableViewCell.dequeueReusableCell(in: tableView, for: indexPath)
        let program = dataSource[indexPath.section]
        cell.configure(name: program.title, description: program.description, image: program.image)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension GeneralViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor(named: "BackgroundColor")
        return headerView
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //Top Left Right Corners
        let maskPathTop = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 10, height: 10))
        let shapeLayerTop = CAShapeLayer()
        shapeLayerTop.frame = cell.bounds
        shapeLayerTop.path = maskPathTop.cgPath

        //Bottom Left Right Corners
        let maskPathBottom = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: 10, height: 10))
        let shapeLayerBottom = CAShapeLayer()
        shapeLayerBottom.frame = cell.bounds
        shapeLayerBottom.path = maskPathBottom.cgPath

        //All Corners
        let maskPathAll = UIBezierPath(roundedRect: cell.bounds, byRoundingCorners: [.topLeft, .topRight, .bottomRight, .bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
        let shapeLayerAll = CAShapeLayer()
        shapeLayerAll.frame = cell.bounds
        shapeLayerAll.path = maskPathAll.cgPath

        if (indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1)
        {
            cell.layer.mask = shapeLayerAll
        }
     else if (indexPath.row == 0)
        {
        cell.layer.mask = shapeLayerTop
        }
        else if (indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1)
        {
            cell.layer.mask = shapeLayerBottom
        }
    }
}
