//
//  CustomTabBarView.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-26.
//

import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedTab: TabSelection
    
    var body: some View {
        HStack(alignment: .center) {
            Spacer()
            Button {
                selectedTab = .statistics
            } label: {
                VStack(spacing: 1) {
                    Image(systemName: selectedTab == .statistics ? "chart.bar.fill" : "chart.bar")
                    Text("Statistik")
                        .font(.custom("Roboto-Regular", size: 12))
                }
            }
            .frame(width: 80, height: 50)
            .background(
                Capsule()
                    .fill(selectedTab == .statistics ? .lightGreen.opacity(0.2) : .clear)
            )
            .foregroundColor(selectedTab == .statistics ? .darkGreen : .secondary)
            
            Spacer()
            Button {
                selectedTab = .home
            } label: {
                VStack(spacing: 1) {
                    Image(systemName: selectedTab == .home ? "house.fill" : "house")
                    Text("Hem")
                        .font(.custom("Roboto-Regular", size: 12))
                }
            }
            .frame(width: 80, height: 50)
            .background(
                Capsule()
                    .fill(selectedTab == .home ? .lightGreen.opacity(0.2) : .clear)
            )
            .foregroundColor(selectedTab == .home ? .darkGreen : .secondary)
            
            Spacer()
            Button {
                selectedTab = .profile
            } label: {
                VStack(spacing: 1) {
                    Image(systemName: selectedTab == .profile ? "person.fill" : "person")
                    Text("Profil")
                        .font(.custom("Roboto-Regular", size: 12))
                }
            }
            .frame(width: 80, height: 50)
            .background(
                Capsule()
                    .fill(selectedTab == .profile ? .lightGreen.opacity(0.2) : .clear)
            )
            .foregroundColor(selectedTab == .profile ? .darkGreen : .secondary)
            
            Spacer()
        }
        .frame(width: 300, height: 64)
        .background(
            Capsule()
                .fill(.lightGreen.opacity(0.1))
        )
        .overlay(
            Capsule()
                .stroke(.black.opacity(0.1), lineWidth: 0.3)
        )
        
    }
}

#Preview {
    CustomTabBarView(selectedTab: .constant(.home))
}
