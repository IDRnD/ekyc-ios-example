//
//  MainViewControllerTests.swift
//  eKYCExampleTests
//
//  Copyright © 2025 ID R&D. All rights reserved.
//

import XCTest
@testable import eKYCExample

class MainViewControllerTests: XCTestCase {
    
    var sut: MainViewController!  // System Under Test
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = MainViewController()
        // Load the view hierarchy so outlets and subviews are instantiated
        sut.loadViewIfNeeded()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testEnrollButtonIsDisabledOnInitialLoad() {
        // A newly created MainViewController
        // The enroll button should be disabled initially
        XCTAssertFalse(sut.enrollButton.isEnabled, "Enroll button should be disabled at launch")
    }
    
    func testEnrollButtonBecomesEnabledWhenFaceAndDocDataAreSet() {
        // The controller is loaded, enroll button is initially disabled
        XCTAssertFalse(sut.enrollButton.isEnabled, "Enroll button should be disabled at start")
        
        // We set both faceData and documentData in enrollmentData
        sut.enrollmentData.faceData = Data([0x00, 0x01])      // Mock some data
        sut.enrollmentData.documentData = Data([0x02, 0x03])  // Mock some data
        
        // TThe enroll button should be enabled
        XCTAssertTrue(sut.enrollButton.isEnabled, "Enroll button should be enabled after setting face + doc data")
    }
    
    func testResetButtonDisabledIfNoData() {
        // At first load, there's no faceData or docData
        // Check if resetBarButton is disabled
        XCTAssertFalse(sut.resetBarButton?.isEnabled ?? true, "Reset button should be disabled if no data")
    }
    
    func testResetEnrollmentClearsDataAndImages() {
        // We have some faceData and docData
        sut.enrollmentData.faceData = Data([0x00, 0x01])
        sut.enrollmentData.documentData = Data([0x02, 0x03])
        // And we set images (mock)
        sut.selfieImageView.image = UIImage(systemName: "person")
        sut.documentImageView.image = UIImage(systemName: "doc")
        
        // Ensure they're enabled/visible
        XCTAssertTrue(sut.resetBarButton?.isEnabled ?? false, "Reset button should be enabled once data is present")
        XCTAssertNotNil(sut.selfieImageView.image)
        XCTAssertNotNil(sut.documentImageView.image)
        
        // We call resetEnrollment()
        sut.resetEnrollment()
        
        // Data should be cleared, images nil, and reset button disabled
        XCTAssertNil(sut.enrollmentData.faceData)
        XCTAssertNil(sut.enrollmentData.documentData)
        XCTAssertNil(sut.selfieImageView.image)
        XCTAssertNil(sut.documentImageView.image)
        XCTAssertFalse(sut.resetBarButton?.isEnabled ?? true)
    }
}
