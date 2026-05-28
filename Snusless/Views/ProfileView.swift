//
//  ProfileView.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-26.
//

import SwiftUI

struct ProfileView: View {
    @Binding var isPresented: Bool

    var body: some View {
        VStack {

        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    isPresented = false
                } label: {
                    Text("Avbryt")
                        .bold()
                        .foregroundStyle(.errorRed)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView(isPresented: .constant(true))

    }
}
