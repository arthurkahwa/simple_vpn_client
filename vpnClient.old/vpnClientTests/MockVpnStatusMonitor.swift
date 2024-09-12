//
//  MockVpnStatusMonitor.swift
//  vpnClientTests
//
//  Created by Arthur Nsereko Kahwa on 9/11/24.
//

import NetworkExtension
@testable import vpnClient

/// Mock class for VpnStatusMonitor
class MockVpnStatusMonitor: VpnStatusMonitor {
    var isMonitoring = false
    
    override func monitorVpnStatus() {
        isMonitoring = true
    }
}
