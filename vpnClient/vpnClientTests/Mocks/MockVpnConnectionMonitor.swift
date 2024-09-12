//
//  MockVpnConnectionMonitor.swift
//  VpnClientTests
//
//  Created by Arthur Nsereko Kahwa on 9/12/24.
//

import Foundation

class MockVpnConnectionMonitor {
    var monitorVpnStatusCalled = false
    
    func monitorVpnStatus() {
        monitorVpnStatusCalled = true
    }
}
