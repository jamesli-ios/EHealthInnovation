//
//  ViewController.swift
//  EHealthInnovation
//
//  Created by James Li on 2021/10/4.
//

import UIKit
import SMART

/**
 User can select DisplayMode
 - shortInfo : user will see names only
 - fullInfo: user will see all info including gender and birthdate
 */
enum DisplayMode: Int {
    case shortInfo
    case fullInfo
    
    var title: String {
        switch self {
        case .shortInfo:
            return AppConstants.Strings.shortInfo
        case .fullInfo:
            return AppConstants.Strings.fullInfo
        }
    }
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var displayModeControl: UISegmentedControl!
    
    @IBOutlet weak var patientsTableView: UITableView!
    
    fileprivate var displayMode: DisplayMode = .shortInfo
    
    fileprivate var patients: [Patient] = []
    
    fileprivate var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        AppApi.fetchPatients { (patients, error) in
            if let error = error {
                self.presentAlert(title: AppConstants.Strings.error, message: error.description)
                return
            }
            
            self.patients = patients!
            self.patientsTableView.reloadData()
        }
        
    }
    
    @IBAction func displayModeControlChanged(_ sender: Any) {
        let control = sender as! UISegmentedControl
        displayMode = DisplayMode(rawValue: control.selectedSegmentIndex)!
        
        DispatchQueue.main.async {
            self.patientsTableView.reloadData()
        }
    }
}

extension HomeViewController {
    
    fileprivate func setupTableView() {
        patientsTableView.tableFooterView = UIView()
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = String(describing: PatientTableViewCell.self)
        let cell = tableView.dequeueReusableCell(withIdentifier: id, for: indexPath) as! PatientTableViewCell
        let patient = patients[indexPath.row]
        let needsFullInfo = displayMode == .fullInfo || indexPath.row == selectedIndex
        cell.updateUI(with: patient, needsFullInfo: needsFullInfo)
        return cell
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard displayMode == .shortInfo else {
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
        selectedIndex = indexPath.row
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
