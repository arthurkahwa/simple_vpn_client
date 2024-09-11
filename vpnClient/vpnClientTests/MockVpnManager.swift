//
//  MockVpnManager.swift
//  vpnClientTests
//
//  Created by Arthur Nsereko Kahwa on 9/11/24.
//

import Foundation
@testable import vpnClient

class MockVpnManager: VpnManagerProtocol {
    var isConnected: Bool = false
    
    func connectVpn() {
        print("Call connection routines")
        isConnected = true
    }
    
    func disconnectVpn() {
        print("Call connection teardown routines")
        isConnected = false
    }
}
