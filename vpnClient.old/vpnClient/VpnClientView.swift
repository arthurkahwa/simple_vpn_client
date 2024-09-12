//
//  VpnClientView.swift
//  vpnClient
//
//  Created by Arthur Nsereko Kahwa on 9/11/24.
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
            
            if vpnManager.isConnected {
                Text("Connected")
                    .foregroundStyle(.green)
            }
            else {
                Text("Disconnected")
                    .foregroundStyle(.red)
            }
            
            Button(action: {
                vpnManager.isConnected ? vpnManager.disconnectVpn() : vpnManager.connectVpn()
            }, label: {
                Text(vpnManager.isConnected ? "Disconnect" : "Connect")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding()
                    .background(vpnManager.isConnected ? .red : .green)
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
