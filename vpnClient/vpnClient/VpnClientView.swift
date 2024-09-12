//
//  VpnClientView.swift
//  VpnClient
//
//  Created by Arthur Nsereko Kahwa on 9/12/24.
//

import SwiftUI

struct VpnClientView: View {
    @State private var vpnManager = VpnManager()
        
    var body: some View {
        VStack {
            Text("VPN Client")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding()
            
            Text(String(describing: vpnManager.connectionStatus))
                .font(.title)
                .foregroundStyle(vpnManager.connectionStatus == .connected ? .green : .red)
            
            Button(action: {
                vpnManager.connectionStatus == .connected ? vpnManager.disconnectVpn() : vpnManager.connectVpn()
            }, label: {
                Text(vpnManager.connectionStatus == .connected ? "Disconnect" : "Connect")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                    .background(vpnManager.connectionStatus == .connected ? .red : .green)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            })
            .padding()
        }
        .onAppear(perform: {
            vpnManager.loadVpnConfiguration()
        })
    }
}

#Preview {
    VpnClientView()
}
