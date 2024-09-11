//
//  MockVpnManager.swift
//  vpnClientTests
//
//  Created by Arthur Nsereko Kahwa on 9/11/24.
//

import NetworkExtension
@testable import vpnClient

/// Mock VPN Manager to simulate the manager holding the connection
class MockVpnManager: VpnManagerProtocol {
    var isConnected: Bool
    var vpnConnection: MockVPNConnection?
    
    init(isConnected: Bool = false, vpnConnection: MockVPNConnection? = nil) {
        self.isConnected = isConnected
        self.vpnConnection = vpnConnection
    }
    
    func connectVpn() {
        print("Call connection routines")
        isConnected = true
    }
    
    func disconnectVpn() {
        print("Call connection teardown routines")
        isConnected = false
    }
}
