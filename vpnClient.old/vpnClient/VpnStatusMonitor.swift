//
//  VpnStatusMonitor.swift
//  vpnClient
//
//  Created by Arthur Nsereko Kahwa on 9/11/24.
//

import NetworkExtension

/// Monitor the status of the VPN connection
/// Added for unit-testing purposes
class VpnStatusMonitor : VpnStatusMonitorProtocol {
    var vpnManager: NETunnelProviderManager?
    var notificationCenter: NotificationCenter
    
    init(vpnManager: NETunnelProviderManager? = nil, notificationCenter: NotificationCenter = .default) {
        self.vpnManager = vpnManager
        self.notificationCenter = notificationCenter
    }
    
    func monitorVpnStatus() {
        notificationCenter.addObserver(forName: .NEVPNStatusDidChange, object: vpnManager?.connection.status, queue: nil) { _ in
            let status = self.vpnManager?.connection.status
            print("❗️ Current VPN is connected: \(String(describing: status))")
        }
        
    }
}
