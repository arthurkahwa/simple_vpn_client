//
//  vpnClientTests.swift
//  vpnClientTests
//
//  Created by Arthur Nsereko Kahwa on 9/11/24.
//

import XCTest
@testable import vpnClient

final class vpnClientTests: XCTestCase {

    var vpnManager: VpnManager!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        vpnManager = VpnManager()
    }

    override func tearDownWithError() throws {
        vpnManager = nil
        
        try super.tearDownWithError()
    }

    func test_Initial_Vpn_State_Is_Disconnected() {
        XCTAssertFalse(vpnManager.isConnected, "VPN should not be connected at this stage.")
    }
    
    

}
