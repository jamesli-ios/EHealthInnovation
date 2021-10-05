//
//  PatientTableViewCell.swift
//  EHealthInnovation
//
//  Created by James Li on 2021/10/4.
//

import UIKit
import SMART

class PatientTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    func updateUI(with patient: Patient, needsFullInfo: Bool) {
        
        /// Hide Gender and Birthday when only short Info is needed
        genderLabel.isHidden = !needsFullInfo
        birthdayLabel.isHidden = !needsFullInfo
        
        let name = patient.name?.first
        
        if needsFullInfo {
            nameLabel.text = patient.humanName ?? "Unknown"
            genderLabel.text = patient.gender?.rawValue.capitalized ?? "Unknown"
            birthdayLabel.text = patient.humanBirthDateMedium ?? "Unknown"
        } else {
            let givenNames = name?.given
            let givenName = givenNames?.compactMap({$0.string}).joined(separator: " ")
            nameLabel.text = givenName ?? name?.text?.string ?? "Unknown"
        }
    }
}
