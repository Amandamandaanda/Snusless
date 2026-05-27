//
//  ProfileView.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-26.
//

import SwiftUI
import SwiftData

struct ProfileView: View {
    @Environment(OnboardingViewModel.self) private var onboardingViewModel
        @Environment(\.modelContext) private var modelContext
        @Environment(\.dismiss) private var dismiss
        
        @State private var editName: String = ""
        @State private var editDosor: Int = 0
        @State private var editPrice: Double = 0.0
    var body: some View {

            VStack(spacing: 20) {
                Text("Ändra profil")
                    .font(.custom("Roboto-Bold", size: 24))
                    .foregroundColor(.white)
                    .padding(.top, 10)
                        
    ScrollView {
            VStack(spacing: 20) {
                               
            VStack(alignment: .leading, spacing: 8) {
            Text("Namn")
           .font(.custom("Roboto-Bold", size: 16))
           .foregroundColor(.white)
                                    
    TextField("", text: $editName)
    .font(.custom("Roboto-Light", size: 18))
    .padding()
    .background(Color.white)
    .foregroundColor(.black)
    .cornerRadius(10)
        }
    .padding(.horizontal, 20)
                                
                               
   VStack(alignment: .leading, spacing: 8) {
       Text("Antal snusdosor per dag")
        .font(.custom("Roboto-Bold", size: 16))
        .foregroundColor(.white)
                                    
    TextField("", value: $editDosor, format: .number)
    .keyboardType(.numberPad)
    .font(.custom("Roboto-Light", size: 18))
    .padding()
    .background(Color.white)
    .foregroundColor(.black)
    .cornerRadius(10)
        }
    .padding(.horizontal, 20)
                                
                                
        VStack(alignment: .leading, spacing: 8)  {                      Text("Pris per snusdosa (kr)")
       .font(.custom("Roboto-Bold", size: 16))
       .foregroundColor(.white)
                                    
       TextField("", value: $editPrice, format: .number)
       .keyboardType(.decimalPad)
       .font(.custom("Roboto-Light", size: 18))
       .padding()
    .background(Color.white)
    .foregroundColor(.black)
    .cornerRadius(10)
            }
    .padding(.horizontal, 20)
                            }
    .padding(.vertical, 10)
                        }
                        
    Spacer()
                   }
            }
        }
  

#Preview {
    NavigationStack {
        ProfileView()
            .environment(OnboardingViewModel())

    }
    
}
