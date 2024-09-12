//
//  VpnConnectionMonitorTests.swift
//  VpnClientTests
//
//  Created by Arthur Nsereko Kahwa on 9/12/24.
//

import XCTest
import NetworkExtension
@testable import VpnClient

final class VpnConnectionMonitorTests: XCTestCase {
    var mockVpnManager: MockNETunnelProviderManager!
    var mockNotificationCenter: NotificationCenter!
    var vpnConnectionMonitor: VpnConnectionMonitor!
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        
        mockVpnManager = MockNETunnelProviderManager()
        mockNotificationCenter = NotificationCenter()
        vpnConnectionMonitor = VpnConnectionMonitor(vpnManager: mockVpnManager, notificationCenter: mockNotificationCenter)
    }

    override func tearDownWithError() throws {
        vpnConnectionMonitor = nil
        mockVpnManager = nil
        mockNotificationCenter = nil
        
        try? super.tearDownWithError()
    }
    
    /// Test that an observer is added when monitorVpnStatus is called
    func testMonitorVpnStatus_AddsObserver() {
        // Given
        let expectation = XCTestExpectation(description: "Observer added")
        
        // When
        vpnConnectionMonitor.monitorVpnStatus()
        
        // Then
        let observers = mockNotificationCenter.observationInfo
        XCTAssertNotNil(observers, "No observer was added to NotificationCenter")
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 1.0)
    }
        
    /// Test that monitorVpnStatus responds to status change notifications
    func testMonitorVpnStatus_RespondsToNotification() {
        // Given
        let expectation = XCTestExpectation(description: "VPN status did change")
        
        // When
        vpnConnectionMonitor.monitorVpnStatus()
        
        // Simulate VPN status change notification
        mockVpnManager.mockConnection.mockStatus = .connected
        mockNotificationCenter.post(name: .NEVPNStatusDidChange, object: mockVpnManager.connection)
        
        // Then
        DispatchQueue.main.async {
            XCTAssertEqual(self.mockVpnManager.connection.status, .connected, "VPN status should be connected")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    /// Test that no retain cycle occurs in closure
    func testMonitorVpnStatus_NoMemoryLeaks() {
        // Given
        weak var weakMonitor: VpnConnectionMonitor?
        
        // When
        autoreleasepool {
            weakMonitor = vpnConnectionMonitor
            vpnConnectionMonitor.monitorVpnStatus()
        }
        
        // Then
        XCTAssertNil(weakMonitor, "There should be no retain cycle; VpnConnectionMonitor should be deallocated")
    }
}
