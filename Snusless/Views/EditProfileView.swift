//
//  EditProfileView.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-26.
//

import SwiftUI
import SwiftData

struct EditProfileView: View {
    @Environment(OnboardingViewModel.self) private var onboardingViewModel
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Environment(\.presentationMode) var presentationMode
    
    @State private var editName: String = ""
    @State private var editDosor: Int = 0
    @State private var editPrice: Double = 0.0
    @State private var editPortioner: Int = 24
    @State private var editStartDate: Date = Date()
    
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
                    
                    VStack(alignment: .leading, spacing: 8)  {
                        Text("Pris per snusdosa (kr)")
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
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Startdatum")
                            .font(.custom("Roboto-Bold", size: 16))
                            .foregroundColor(.white)
                        
                        DatePicker("", selection: $editStartDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                    
                }
                .padding(.vertical, 10)
            }
            
            Spacer()
            
            HStack(spacing: 20) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Avbryt")
                        .font(.custom("Roboto-Bold", size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red.opacity(0.8))
                        .cornerRadius(10)
                }
                
                Button(action: {
                    onboardingViewModel.updateUser(
                        context: modelContext,
                        updatedName: editName,
                        updatedDosor: editDosor,
                        updatedPrice: editPrice
                    )
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Uppdatera")
                        .font(.custom("Roboto-Bold", size: 18))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.lightGreen))
        .onAppear {
            let descriptor = FetchDescriptor<User>()
            if let existingUser = try? modelContext.fetch(descriptor).first {
                editName = existingUser.name
                editDosor = existingUser.numberOfDosor
                editPrice = existingUser.pricePerDosa
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    SettingsView()
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditProfileView()
            .environment(OnboardingViewModel())
    }
}
