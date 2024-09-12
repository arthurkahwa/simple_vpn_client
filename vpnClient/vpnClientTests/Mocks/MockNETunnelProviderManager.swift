//
//  MockNETunnelProviderManager.swift
//  VpnClientTests
//
//  Created by Arthur Nsereko Kahwa on 9/12/24.
//

import NetworkExtension

/// Mock class for NETunnelProviderManager
class MockNETunnelProviderManager: NETunnelProviderManager {
    var connectionStatus: NEVPNStatus = .invalid
    var mockConnection: MockConnection = MockConnection()
    
    override var connection: NEVPNConnection {
        return mockConnection
    }
    
    static func stubLoadAllFromPreferences(managers: [NETunnelProviderManager]?) {
        // Simulate the behavior of loadAllFromPreferences with valid managers
    }
    
    static func stubLoadAllFromPreferencesError() {
        // Simulate the behavior of loadAllFromPreferences with an error
    }
    
    func stubLoadFromPreferencesError() {
        // Simulate error loading preferences during connection
    }
}
