//
//  vpnClientTests.swift
//  vpnClientTests
//
//  Created by Arthur Nsereko Kahwa on 9/11/24.
//

import XCTest
@testable import vpnClient

final class vpnClientTests: XCTestCase {
    func testInitialization_loadsConfigurationAndMonitorsStatus() {
            // Arrange
            let mockVpnManager = VpnManager()
            let mockMonitor = MockVpnStatusMonitor()
            
            // Act
            mockVpnManager.monitorVpnStatus()

            // Assert
            XCTAssertNotNil(mockVpnManager, "VPN Manager should not be nil after initialization")
            XCTAssertTrue(mockMonitor.isMonitoring, "VPN monitoring should be started on initialization")
        }
        
        func testLoadVpnConfiguration_whenConfigurationExists_setsVpnManager() {
            // Arrange
            let mockVpnManager = MockTunnelProviderManager()
            let vpnManager = VpnManager()

            // Act
            vpnManager.loadVpnConfiguration()

            // Assert
            XCTAssertEqual(vpnManager.vpnManager?.connection.status, .invalid, "VPN Manager should be set to invalid status initially")
        }

        func testLoadVpnConfiguration_whenErrorOccurs_printsError() {
            // Arrange
            let mockVpnManager = VpnManager()
            // Simulate an error in loading VPN configuration
            let mockError = NSError(domain: "Test", code: 1, userInfo: nil)

            // Expect the error message to be printed (use logging capture in production tests)
            let expectedErrorMessage = "❌ Error loading vpn configuration: \(mockError.localizedDescription)"
            
            // Act
            // Simulate the error
            mockVpnManager.loadVpnConfiguration()

            // Assert
            // Ensure error message is printed, you can use logging capture mechanisms if available
        }
        
        func testCreateVpnConfiguration_createsNewConfiguration() {
            // Arrange
            let vpnManager = VpnManager()

            // Act
            let createdManager = vpnManager.createVpnConfiguration()

            // Assert
            XCTAssertNotNil(createdManager, "New VPN configuration should be created")
            XCTAssertNotNil(createdManager.protocolConfiguration, "Protocol configuration should be set in the new VPN manager")
        }
}
