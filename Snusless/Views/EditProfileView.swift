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

    @State private var editName: String = ""
    @State private var editStartDate: Date = Date()
    @State private var editDosor: Int = 0
    @State private var editPrice: Double = 0.0
    @State private var editPortioner: Int = 0
    @State private var editSavingsGoal: Int = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {

            Text("Namn")
                .font(.custom("Roboto-Medium", size: 16))

            TextField("", text: $editName)
                .padding()
                .font(.custom("Roboto-Light", size: 18))
                .background(.lightGreen.opacity(0.2))
                .foregroundColor(.black)
                .cornerRadius(10)
                .padding(.bottom, 20)

            Text("Startdatum")
                .font(.custom("Roboto-Medium", size: 16))

            DatePicker(
                "",
                selection: $editStartDate,
                in: ...Date(),
                displayedComponents: .date
            )
            .datePickerStyle(.compact)
            .labelsHidden()
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .environment(\.locale, .current)
            .background(.lightGreen.opacity(0.2))
            .tint(.darkGreen)
            .cornerRadius(10)
            .padding(.bottom, 20)

            Text("Antal snusdosor per dag")
                .font(.custom("Roboto-Medium", size: 16))

            TextField("", value: $editDosor, format: .number)
                .keyboardType(.numberPad)
                .font(.custom("Roboto-Light", size: 18))
                .padding()
                .background(.lightGreen.opacity(0.2))
                .foregroundColor(.black)
                .cornerRadius(10)
                .padding(.bottom, 20)

            Text("Portioner per snusdosa")
                .font(.custom("Roboto-Medium", size: 16))

            TextField("", value: $editPortioner, format: .number)
                .keyboardType(.numberPad)
                .font(.custom("Roboto-Light", size: 18))
                .padding()
                .background(.lightGreen.opacity(0.2))
                .foregroundColor(.black)
                .cornerRadius(10)
                .padding(.bottom, 20)

            Text("Pris per snusdosa (kr)")
                .font(.custom("Roboto-Medium", size: 16))

            TextField("", value: $editPrice, format: .number)
                .keyboardType(.decimalPad)
                .font(.custom("Roboto-Light", size: 18))
                .padding()
                .background(.lightGreen.opacity(0.2))
                .foregroundColor(.black)
                .cornerRadius(10)
                .padding(.bottom, 20)

            Text("Sparmål (kr)")
                .font(.custom("Roboto-Medium", size: 16))

            TextField("", value: $editSavingsGoal, format: .number)
                .keyboardType(.decimalPad)
                .font(.custom("Roboto-Light", size: 18))
                .padding()
                .background(.lightGreen.opacity(0.2))
                .foregroundColor(.black)
                .cornerRadius(10)
                .padding(.bottom, 20)

            Spacer()

            Button(action: {
                onboardingViewModel.updateUser(
                    context: modelContext,
                    updatedName: editName,
                    updatedDate: editStartDate,
                    updatedDosor: editDosor,
                    updatedPortions: editPortioner,
                    updatedPrice: editPrice,
                    updatedSavingsGoal: editSavingsGoal
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
            if let existingUser = try? modelContext.fetch(descriptor).first {
                editName = existingUser.name
                editStartDate = existingUser.startDate
                editDosor = existingUser.numberOfDosor
                editPortioner = existingUser.portionsPerDosa
                editPrice = existingUser.pricePerDosa
                editSavingsGoal = existingUser.savingsGoal
            }
        }
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
        .padding(.bottom, 50)
    }
}

#Preview {
    NavigationStack {
        EditProfileView()
            .environment(OnboardingViewModel())
    }
}
