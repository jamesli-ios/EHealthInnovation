//
//  AppApi.swift
//  EHealthInnovation
//
//  Created by James Li on 2021/10/4.
//

import Foundation
import SMART

class AppApi {
    class func fetchPatients(completion: @escaping ([Patient]?, FHIRError?) -> Void) {
        let patient = Client(
            baseURL: URL(string: AppConstants.Url.base)!,
            settings: ["_pretty": true]
        )
        
        patient.getJSON(at: AppConstants.Path.patients) { (response) in
            guard let json = response.json else {
                print(response.error.debugDescription)
                completion(nil, response.error)
                return
            }
            
            let a = json["entry"] as! [FHIRJSON]
            let patients = a.map({try! Patient(json: $0["resource"] as! FHIRJSON)})
            
            DispatchQueue.main.async {
                completion(patients, nil)
            }
        }
    }
    
}
