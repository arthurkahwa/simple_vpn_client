//
//  VpnManagerProtocol.swift
//  VpnClient
//
//  Created by Arthur Nsereko Kahwa on 9/12/24.
//

import NetworkExtension

protocol VpnManagerProtocol {
    var connectionStatus: NEVPNStatus { get }
    
    func connectVpn()
    func disconnectVpn()
}
