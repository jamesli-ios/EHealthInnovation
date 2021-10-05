//
//  EHealthInnovationTests.swift
//  EHealthInnovationTests
//
//  Created by James Li on 2021/10/4.
//

import XCTest
import SMART
@testable import EHealthInnovation

class EHealthInnovationTests: XCTestCase {

    func testFetchPatients() {
        
        /// Create an expectation
        let expectation = self.expectation(description: "Fetching")
        var errorResult: FHIRError?
        var patientsResult: [Patient]?
        
        AppApi.fetchPatients { (patients, error) in
            patientsResult = patients
            errorResult = error
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(errorResult, "There shouldn't be error")
        
        XCTAssertNotNil(patientsResult, "Must fetch patients successfully")
        
        patientsResult?.forEach({ (patient) in
            XCTAssertNotNil(patient.id, "Patient must have id")
        })
        
    }

}
