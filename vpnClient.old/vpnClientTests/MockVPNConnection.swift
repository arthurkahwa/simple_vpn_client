//
//  MockVPNConnection.swift
//  vpnClientTests
//
//  Created by Arthur Nsereko Kahwa on 9/11/24.
//

import NetworkExtension
@testable import vpnClient

/// Mock VPN connection class
class MockVPNConnection: NEVPNConnection {
    var mockStatus: NEVPNStatus
    
    init(status: NEVPNStatus) {
        self.mockStatus = status
        super.init()
    }

    override var status: NEVPNStatus {
        return mockStatus
    }
}
