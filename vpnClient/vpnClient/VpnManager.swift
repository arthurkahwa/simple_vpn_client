//
//  VpnManager.swift
//  vpnClient
//
//  Created by Arthur Nsereko Kahwa on 9/11/24.
//

import Foundation
import NetworkExtension

@Observable
/// Class used to manage the VPNconnections
class VpnManager: VpnManagerProtocol {
    private var vpnManager: NETunnelProviderManager?
    var isConnected = false
    
    init() {
        loadVpnConfiguration()
        
        monitorVpnStatus()
    }
    
    func monitorVpnStatus() {
        NotificationCenter.default.addObserver(forName: .NEVPNStatusDidChange,
                                               object: vpnManager?.connection,
                                               queue: nil) { _ in
            let status = self.vpnManager?.connection.status
            print("❗️ Current VPN status: \(String(describing: status))")
        }
    }
    
    /// Load VPN configuration from preferences
    func loadVpnConfiguration() {
        NETunnelProviderManager.loadAllFromPreferences { managers, error in
            if let error = error {
                print("❌ Error loading vpn configuration: \(error.localizedDescription)")
                
                return
            }
            
            if let firstZManager = managers?.first {
                self.vpnManager = firstZManager
                self.isConnected = firstZManager.connection.status == .connected
            }
            else {
                self.vpnManager = self.createVpnConfiguration()
            }
        }
    }
    
    /// Create the connection manager for the connection
    /// - Returns: configured connection manager
    private func createVpnConfiguration() -> NETunnelProviderManager {
        let manager = NETunnelProviderManager()
        let config = NETunnelProviderProtocol()
        
        config.serverAddress = "vpn.provider.local" // Replace with vpn provider address
        config.username = "my_optional_user_name"
        config.passwordReference = getPasswordPreference() // optional password
        
        
        manager.protocolConfiguration = config
        
        manager.saveToPreferences { error in
            if let error = error {
                print("❌ Error saving vpn configuration to preferences: \(error.localizedDescription)")
            }
        }
        
        return manager
    }
    
    /// Get password preference from the preferences/keychain
    /// - Returns: a data structure with the password from the preferences
    private func getPasswordPreference() -> Data? {
        // Pass back nil
        // as a placeholder
        
        return nil
    }
    
    /// Establish the vpn connection
    func connectVpn() {
        vpnManager?.loadFromPreferences { error in
            if let error = error {
                print("❌ Error loading vpn preferences during connection attempt: \(error.localizedDescription)")
            }
            
            do {
                try self.vpnManager?.connection.startVPNTunnel()
                
                DispatchQueue.main.async {
                    self.isConnected = true
                }
            }
            catch {
                print("❌ Error starting VPN Tunnel: \(error.localizedDescription)")
            }
        }
    }
    
    /// Disconnect/close the vpn tunnel
    func disconnectVpn() {
        vpnManager?.connection.stopVPNTunnel()
        DispatchQueue.main.async {
            self.isConnected = false
        }
    }
}
