//
//  vpnClientTests.swift
//  vpnClientTests
//
//  Created by Arthur Nsereko Kahwa on 9/11/24.
//

import XCTest
@testable import vpnClient

final class vpnClientTests: XCTestCase {

    var vpnManager: MockVpnManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        vpnManager = MockVpnManager()
    }

    override func tearDownWithError() throws {
        vpnManager = nil
        
        try super.tearDownWithError()
    }

    func test_Initial_Vpn_State_Is_Disconnected() {
        XCTAssertFalse(vpnManager.isConnected, "VPN should not be connected at this stage.")
    }
    
    func test_simulated_connection_condition() {
        vpnManager.connectVpn()
        
        XCTAssertTrue(vpnManager.isConnected, "The connection flag is incorrect")
    }
    
    func test_vpn_disconnected_state() {
        vpnManager.disconnectVpn()
        
        XCTAssertFalse(vpnManager.isConnected, "The disconnected state cannor be determined")
    }
    
    func testMonitorVpnStatus_whenNotificationPosted_updatesStatus() {
        // Arrange
        let mockConnection = MockVPNConnection()
        let mockManager = MockVpnManager(vpnConnection: mockConnection)
        let mockNotificationCenter = NotificationCenter()

        let vpnStatusMonitor = VpnStatusMonitor(notificationCenter: mockNotificationCenter)
        
        // To capture printed output
        let expectation = expectation(description: "VPN status updated")

        // Act
        vpnStatusMonitor.monitorVpnStatus()

        // Simulate a status change in the connection
        mockConnection.vpnConnectionStatus = .connected
        mockNotificationCenter.post(name: .NEVPNStatusDidChange, object: mockConnection)

        // Assert
        DispatchQueue.main.async {
            XCTAssertEqual(mockManager.isConnected, true)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func testMonitorVpnStatus_invalidStatusOnNotification() {
            // Arrange
            let mockConnection = MockVPNConnection()
            let mockManager = MockVpnManager(vpnConnection: mockConnection)
            let mockNotificationCenter = NotificationCenter()

            let vpnStatusMonitor = VpnStatusMonitor(notificationCenter: mockNotificationCenter)

            let expectation = expectation(description: "VPN status updated")

            // Act
            vpnStatusMonitor.monitorVpnStatus()

            // Simulate a status change to .invalid
            mockConnection.vpnConnectionStatus = .invalid
            mockNotificationCenter.post(name: .NEVPNStatusDidChange, object: mockConnection)

            // Assert
            DispatchQueue.main.async {
                XCTAssertEqual(mockManager.isConnected, false)
                expectation.fulfill()
            }

            wait(for: [expectation], timeout: 1.0)
        }
}
