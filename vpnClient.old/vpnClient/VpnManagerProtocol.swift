//
//  VpnManagerProtocol.swift
//  vpnClient
//
//  Created by Arthur Nsereko Kahwa on 9/11/24.
//

import Foundation
import NetworkExtension

protocol VpnManagerProtocol {
    var isConnected: Bool { get set }
    func connectVpn()
    func disconnectVpn()
}
