//
//  EditProfileView.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-26.
//

import SwiftData
import SwiftUI

struct EditProfileView: View {
    @Environment(OnboardingViewModel.self) private var onboardingViewModel
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var editProfileViewModel = EditProfileViewModel()

   

    var body: some View {
        @Bindable var editVM = editProfileViewModel
        VStack(alignment: .leading, spacing: 4) {

            Text("Namn")
                .font(.custom("Roboto-Medium", size: 16))

            TextField("\(editProfileViewModel.originalName)", text: $editVM.editName)
                .padding()
                .font(.custom("Roboto-Light", size: 18))
                .background(.lightGreen.opacity(0.1))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.darkGreen, lineWidth: 2))
                .foregroundColor(.black)
                .cornerRadius(10)
                .padding(.bottom, 16)

            Text("Startdatum")
                .font(.custom("Roboto-Medium", size: 16))

            DatePicker(
                "",
                selection: $editVM.editStartDate,
                in: ...Date(),
                displayedComponents: .date
            )
            .datePickerStyle(.compact)
            .labelsHidden()
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(.darkGreen, lineWidth: 2))
            .environment(\.locale, .current)
            .background(.lightGreen.opacity(0.1))
            .tint(.darkGreen)
            .cornerRadius(10)
            .padding(.bottom, 16)

            Text("Antal snusdosor per dag")
                .font(.custom("Roboto-Medium", size: 16))

            TextField("\(editProfileViewModel.editDosor) dosor", value: $editVM.editDosor, format: .number)
                .keyboardType(.numberPad)
                .font(.custom("Roboto-Light", size: 18))
                .padding()
                .background(.lightGreen.opacity(0.1))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.darkGreen, lineWidth: 2))
                .foregroundColor(.black)
                .cornerRadius(10)
                .padding(.bottom, 16)

            Text("Portioner per snusdosa")
                .font(.custom("Roboto-Medium", size: 16))

            TextField("\(editProfileViewModel.editPortioner) st", value: $editVM.editPortioner, format: .number)
                .keyboardType(.numberPad)
                .font(.custom("Roboto-Light", size: 18))
                .padding()
                .background(.lightGreen.opacity(0.1))
                .foregroundColor(.black)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.darkGreen, lineWidth: 2))
                .cornerRadius(10)
                .padding(.bottom, 16)

            Text("Pris per snusdosa (kr)")
                .font(.custom("Roboto-Medium", size: 16))

            TextField("\(String(format: "%.2f", editProfileViewModel.editPrice)) kr", value: $editVM.editPrice, format: .number)
                .keyboardType(.decimalPad)
                .font(.custom("Roboto-Light", size: 18))
                .padding()
                .background(.lightGreen.opacity(0.1))
                .foregroundColor(.black)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.darkGreen, lineWidth: 2))
                .cornerRadius(10)
                .padding(.bottom, 16)

            Text("Sparmål (kr)")
                .font(.custom("Roboto-Medium", size: 16))

            TextField("\(editProfileViewModel.editSavingsGoal) kr", value: $editVM.editSavingsGoal, format: .number)
                .keyboardType(.decimalPad)
                .font(.custom("Roboto-Light", size: 18))
                .padding()
                .background(.lightGreen.opacity(0.1))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.darkGreen, lineWidth: 2))
                .foregroundColor(.black)
                .cornerRadius(10)
                .padding(.bottom, 16)

            Spacer()

            Button(action: {
                editProfileViewModel.updateUser(
                    context: modelContext,
                    updatedName: editProfileViewModel.editName,
                    updatedDate: editProfileViewModel.editStartDate,
                    updatedDosor: editProfileViewModel.editDosor,
                    updatedPortions: editProfileViewModel.editPortioner,
                    updatedPrice: editProfileViewModel.editPrice,
                    updatedSavingsGoal: editProfileViewModel.editSavingsGoal
                )

                dismiss()
            }) {
                Text("Spara")
                    .font(.custom("Roboto-Bold", size: 18))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.darkGreen)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .onAppear {
            let descriptor = FetchDescriptor<User>()
            if let existingUser = try?
                
            
                modelContext.fetch(descriptor).first {
                editProfileViewModel.originalName = existingUser.name
                editProfileViewModel.editName = existingUser.name
                editProfileViewModel.editStartDate = existingUser.startDate
                editProfileViewModel.editDosor = existingUser.numberOfDosor
                editProfileViewModel.editPortioner = existingUser.portionsPerDosa
                editProfileViewModel.editPrice = existingUser.pricePerDosa
                editProfileViewModel.editSavingsGoal = existingUser.savingsGoal
            }        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    dismiss()
                } label: {
                    Text("Avbryt")
                        .font(.custom("Roboto-Bold", size: 18))
                        .foregroundStyle(.errorRed)
                }
            }

            ToolbarItem(placement: .title) {
                Text("Ändra Profil")
                    .font(.custom("Roboto-Bold", size: 20))
                    .foregroundColor(.black)
            }
        }
        .padding(.bottom, 80)
    }
}

#Preview {
    NavigationStack {
        EditProfileView()
            .environment(OnboardingViewModel())
    }
}
