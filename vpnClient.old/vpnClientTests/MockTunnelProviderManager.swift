//
//  MockTunnelProviderManager.swift
//  vpnClientTests
//
//  Created by Arthur Nsereko Kahwa on 9/11/24.
//

import NetworkExtension
@testable import vpnClient

/// Mock class for NETunnelProviderManager
class MockTunnelProviderManager: NETunnelProviderManager {
    var mockStatus: NEVPNStatus = .invalid

    override var connection: NEVPNConnection {
        let mockConnection = MockVPNConnection(status: mockStatus)
        return mockConnection
    }
}
