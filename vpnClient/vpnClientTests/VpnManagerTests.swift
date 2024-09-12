//
//  VpnManagerTests.swift
//  VpnClientTests
//
//  Created by Arthur Nsereko Kahwa on 9/12/24.
//

import XCTest
import NetworkExtension
@testable import VpnClient

final class VpnManagerTests: XCTestCase {
    var sut: VpnManager!  // System Under Test
    var mockVpnManager: MockNETunnelProviderManager!
    
    override func setUpWithError() throws {
        try? super.setUpWithError()
        
        sut = VpnManager()
        mockVpnManager = MockNETunnelProviderManager() 
        sut.vpnManager = mockVpnManager
    }

    override func tearDownWithError() throws {
        sut = nil
        mockVpnManager = nil
        
        try? super.tearDownWithError()
    }
    
    // MARK: - Test: Monitor VPN Status
    func testMonitorVpnStatus_callsVpnMonitor() {
        // Create a mock of the VpnConnectionMonitor
        let mockVpnConnectionMonitor = MockVpnConnectionMonitor()
        
        // Inject the mock monitor into VpnManager (you might need dependency injection)
        sut.monitorVpnStatus()
        
        XCTAssertTrue(mockVpnConnectionMonitor.monitorVpnStatusCalled, "monitorVpnStatus should be called")
    }
    
    // MARK: - Test: Load VPN Configuration
    func testLoadVpnConfiguration_withError_shouldNotAssignVpnManager() {
        // Simulate error response from loadAllFromPreferences
        MockNETunnelProviderManager.stubLoadAllFromPreferencesError()
        
        sut.loadVpnConfiguration()
        
        XCTAssertNil(sut.vpnManager, "vpnManager should remain nil if error occurs during loading")
    }
    
    func testLoadVpnConfiguration_withManager_shouldAssignVpnManagerAndConnectionStatus() {
        let mockManager = MockNETunnelProviderManager()
        mockManager.connectionStatus = .connected // simulate connected status
        
        // Simulate valid response from loadAllFromPreferences
        MockNETunnelProviderManager.stubLoadAllFromPreferences(managers: [mockManager])
        
        sut.loadVpnConfiguration()
        
        XCTAssertEqual(sut.vpnManager, mockManager, "vpnManager should be assigned when loading a valid manager")
        XCTAssertEqual(sut.connectionStatus, .connected, "connectionStatus should match the manager's connection status")
    }
    
    // MARK: - Test: Create VPN Configuration
    func testCreateVpnConfiguration_createsNewVpnConfiguration() {
        let newManager = sut.createVpnConfiguration()
        
        XCTAssertNotNil(newManager, "createVpnConfiguration should return a new manager instance")
        XCTAssertEqual((newManager.protocolConfiguration as? NEVPNProtocolIKEv2)?.serverAddress, "vpn.provider.local", "Server address should match the expected value")
    }
    
    // MARK: - Test: Connect VPN
    func testConnectVpn_startsVpnTunnel() {
        sut.vpnManager = mockVpnManager
        
        sut.connectVpn()
        
        XCTAssertTrue(mockVpnManager.connection.status == .connected, "connectVpn should call startVPNTunnel on vpnManager")
    }
    
    func testConnectVpn_withError_shouldNotChangeConnectionStatus() {
        mockVpnManager.stubLoadFromPreferencesError()
        
        sut.connectVpn()
        
        XCTAssertNotEqual(sut.connectionStatus, .connected, "Connection status should not be updated if an error occurs during connection attempt")
    }
    
    // MARK: - Test: Disconnect VPN
    func testDisconnectVpn_stopsVpnTunnel() {
        sut.vpnManager = mockVpnManager
        sut.disconnectVpn()
        
        XCTAssertTrue(mockVpnManager.connection.status != .connected, "disconnectVpn should call stopVPNTunnel on vpnManager")
        XCTAssertEqual(sut.connectionStatus, .invalid, "Connection status should be set to invalid after disconnect")
    }
}
