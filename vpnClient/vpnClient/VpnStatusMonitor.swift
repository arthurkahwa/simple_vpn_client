//
//  VpnStatusMonitor.swift
//  vpnClient
//
//  Created by Arthur Nsereko Kahwa on 9/11/24.
//

import NetworkExtension

/// Monitor the status of the VPN connection
/// Added for unit-testing purposes
class VpnStatusMonitor {
    var vpnManager: VpnManager?
    var notificationCenter: NotificationCenter
    
    init(vpnManager: VpnManager? = nil, notificationCenter: NotificationCenter = .default) {
        self.vpnManager = vpnManager
        self.notificationCenter = notificationCenter
    }
    
    func monitorVpnStatus() {
        notificationCenter.addObserver(forName: .NEVPNStatusDidChange, object: vpnManager?.isConnected, queue: nil) { _ in
            let status = self.vpnManager?.isConnected
            print("❗️ Current VPN is connected: \(String(describing: status))")
        }
        
    }
}
