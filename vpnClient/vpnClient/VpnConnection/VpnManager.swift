//
//  VpnManager.swift
//  VpnClient
//
//  Created by Arthur Nsereko Kahwa on 9/12/24.
//

import NetworkExtension

/// Hangle the vpn connection and settings
class VpnManager: VpnManagerProtocol {
    var vpnManager: NETunnelProviderManager?
    var connectionStatus: NEVPNStatus = .invalid
    
    /// Start monitor for connection status
    func monitorVpnStatus() {
       let vpnMonitor = VpnConnectionMonitor()
        vpnMonitor.monitorVpnStatus()
    }
    
    /// Load VPN configuration from preferences
    func loadVpnConfiguration() {
        NETunnelProviderManager.loadAllFromPreferences { managers, error in
            if let error = error {
                print("❌ Error loading vpn configuration: \(error.localizedDescription)")
                
                return
            }
            
            if let firstManager = managers?.first {
                self.vpnManager = firstManager
                self.connectionStatus = firstManager.connection.status
            }
            else {
                self.vpnManager = self.createVpnConfiguration()
            }
        }
    }
    
    /// Create the connection manager for the connection
    /// - Returns: configured connection manager
    func createVpnConfiguration() -> NETunnelProviderManager {
        let manager = NETunnelProviderManager()
        let config = NEVPNProtocolIKEv2()
        
        config.serverAddress = "vpn.provider.local" // Replace with vpn provider address
        config.username = "my_optional_user_name"
        config.passwordReference = getPasswordPreference() // optional password
        config.authenticationMethod = .none
        
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
                    self.connectionStatus = .connected
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
            self.connectionStatus = .invalid
        }
    }
}
