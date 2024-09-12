//
//  VpnConnectionMonitor.swift
//  VpnClient
//
//  Created by Arthur Nsereko Kahwa on 9/12/24.
//

import NetworkExtension

/// Monitor the status of the vpn connection and
/// send updates to the notification center
class VpnConnectionMonitor: VpnStatusMonitorProtocol {
    private var vpnManager: NETunnelProviderManager?
    private var notificationCenter: NotificationCenter
    
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
