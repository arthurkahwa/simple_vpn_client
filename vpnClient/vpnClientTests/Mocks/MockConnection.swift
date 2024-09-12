//
//  MockConnection.swift
//  VpnClientTests
//
//  Created by Arthur Nsereko Kahwa on 9/12/24.
//

import NetworkExtension

/// Mock class for NEVPNConnection to simulate VPN status
class MockConnection: NEVPNConnection {
    var mockStatus: NEVPNStatus = .invalid
    var startVPNTunnelCalled = false
    var stopVPNTunnelCalled = false
    
    override var status: NEVPNStatus {
        return mockStatus
    }
    
    override func startVPNTunnel() throws {
       startVPNTunnelCalled = true
   }
   
   override func stopVPNTunnel() {
       stopVPNTunnelCalled = true
   }
}
