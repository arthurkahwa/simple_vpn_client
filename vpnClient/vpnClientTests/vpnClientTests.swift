//
//  vpnClientTests.swift
//  vpnClientTests
//
//  Created by Arthur Nsereko Kahwa on 9/11/24.
//

import XCTest
@testable import vpnClient

final class vpnClientTests: XCTestCase {

    var vpnManager: MockVpnManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        vpnManager = MockVpnManager()
    }

    override func tearDownWithError() throws {
        vpnManager = nil
        
        try super.tearDownWithError()
    }

    func test_Initial_Vpn_State_Is_Disconnected() {
        XCTAssertFalse(vpnManager.isConnected, "VPN should not be connected at this stage.")
    }
    
    func test_simulated_connection_condition() {
        vpnManager.connectVpn()
        
        XCTAssertTrue(vpnManager.isConnected, "The connection flag is incorrect")
    }
    
    func test_vpn_disconnected_state() {
        vpnManager.disconnectVpn()
        
        XCTAssertFalse(vpnManager.isConnected, "The disconnected state cannor be determined")
    }
    

}
