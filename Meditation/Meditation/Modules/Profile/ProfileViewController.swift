//
//  ProfileViewController.swift
//  Meditation
//
//  Created by Pavel Boltromyuk on 23.09.21.
//

import Charts
import CodableFirebase
import FirebaseAuth
import FirebaseFirestore
import Kingfisher
import UIKit
import PKHUD

class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet weak var barChart: BarChartView!
    
    private var user: User!
    private var statistics = [TimeStatistic]()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        user = Auth.auth().currentUser
        getStatistics()
        setupInformation()
        setupBarChart()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupInformation()
    }
    
    // MARK: - Setup
    private func setupInformation() {
        profileImage.kf.setImage(with: user.photoURL)
        nameLabel.text = user.displayName
        emailLabel.text = user.email
    }
    
    private func setupBarChart() {
        barChart.noDataText = "No chart data available."
        let entries = statistics.map { $0.transformToBarChartDataEntry() }
        let set = BarChartDataSet(entries: entries)
        set.setColor(.stats)
        set.highlightAlpha = 0
        
        let data = BarChartData(dataSet: set)
        data.setDrawValues(true)
        data.setValueTextColor(.text)
        barChart.data = data
        
        // remove rightAxis
        barChart.rightAxis.enabled = false
        
        // disable zoom function
        barChart.pinchZoomEnabled = false
        barChart.setScaleEnabled(false)
        barChart.doubleTapToZoomEnabled = false
        
        // Bar, Grid Line, Background
        barChart.drawBarShadowEnabled = false
        barChart.drawGridBackgroundEnabled = false
        barChart.drawBordersEnabled = false
        
        // Legend
        barChart.legend.enabled = false
        
        // Chart Offset
        barChart.setExtraOffsets(left: 10, top: 0, right: 20, bottom: 40)
        
        // Setup X axis
        let xAxis = barChart.xAxis
        xAxis.valueFormatter = IndexAxisValueFormatter(values: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"])
        xAxis.labelPosition = .bottom
        xAxis.labelTextColor = .text
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = false
        xAxis.granularityEnabled = false
        
        // Setup left axis
        let leftAxis = barChart.leftAxis
        leftAxis.drawTopYLabelEntryEnabled = true
        leftAxis.drawAxisLineEnabled = true
        leftAxis.drawGridLinesEnabled = true
        leftAxis.granularityEnabled = false
        leftAxis.labelTextColor = .text
    }
    
    // MARK: - Actions
    @IBAction private func tappedSignOut(_ sender: UIButton) {
        do
        {
            AnalyticManager.shared.sendEvent(.signOut)
            try Auth.auth().signOut()
            guard let nav = navigationController as? RootNavigationViewController else { return }
            nav.setRootController()
        }
        catch let error as NSError
        {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - API calls
    private func getStatistics() {
        HUD.show(.progress)
        Firestore.firestore().collection("statistics").getDocuments { [weak self] query, error in
            if let querySnapshot = query {
                guard let self = self else { return }
                for document in querySnapshot.documents {
                    let timeStatistic = try! FirestoreDecoder().decode(TimeStatistic.self, from: document.data())
                    self.statistics.append(timeStatistic)
                    self.setupBarChart()
                    HUD.hide()
                }
            } else {
                print("Document does not exist")
            }
        }
    }
}
