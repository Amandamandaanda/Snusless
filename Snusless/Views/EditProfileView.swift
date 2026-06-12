//
//  EditProfileView.swift
//  Snusless
//
//  Created by Aurelie Vaudan APP25 on 2026-05-26.
//

import SwiftData
import SwiftUI

struct EditProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var editProfileViewModel = EditProfileViewModel()

    @Query private var users: [User]

    var body: some View {
        @Bindable var editVM = editProfileViewModel
        VStack(alignment: .leading, spacing: 4) {

            Text("Namn")
                .font(.custom("Roboto-Bold", size: 16))

            TextField(
                "\(editProfileViewModel.originalName)",
                text: $editVM.editName
            )
            .modifier(TextFieldModifier(keyboardType: .default))
            .onChange(of: editVM.editName) { _, newValue in
                let filtered = newValue.filter {
                    $0.isLetter || $0.isWhitespace
                }

                let limited = String(filtered.prefix(20))
                editVM.editName = limited
            }

            Text("Startdatum")
                .font(.custom("Roboto-Bold", size: 16))

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
            .background(.white)
            .environment(\.locale, .current)
            .background(.lightGreen.opacity(0.1))
            .tint(.darkGreen)
            .cornerRadius(10)
            .padding(.bottom, 16)

            HStack {
                Text("Antal snusdosor per dag:")
                    .font(.custom("Roboto-Bold", size: 16))

                Spacer()

                Text(
                    "\(String(format: "%.1f", editProfileViewModel.editDosor))"
                )
                .font(.custom("Roboto-Bold", size: 18))
                .padding(.horizontal, 15)
                .environment(\.locale, .current)
                .background(.lightGreen.opacity(0.1))
                .cornerRadius(10)
            }

            Slider(value: $editVM.editDosor, in: 0...5, step: 0.5)
                .accentColor(.darkGreen)
                .padding(.bottom, 16)

            HStack {
                Text("Portioner per snusdosa:")
                    .font(.custom("Roboto-Bold", size: 16))

                Spacer()

                Text(
                    "\(editProfileViewModel.editPortioner)"
                )
                .font(.custom("Roboto-Bold", size: 18))
                .padding(.horizontal, 15)
                .environment(\.locale, .current)
                .background(.lightGreen.opacity(0.1))
                .cornerRadius(10)
            }

            Slider(
                value: Binding(
                    get: { Double(editVM.editPortioner) },
                    set: { editVM.editPortioner = Int($0) }
                ),
                in: 20...30,
                step: 1
            )
            .accentColor(.darkGreen)
            .padding(.bottom, 16)

            Text("Pris per snusdosa (kr)")
                .font(.custom("Roboto-Bold", size: 16))

            TextField(
                "\(String(format: "%.2f", editProfileViewModel.editPrice)) kr",
                value: $editVM.editPrice,
                format: .number
            )
            .modifier(TextFieldModifier())

            Text("Sparmål (kr)")
                .keyboardType(.numberPad)
                .font(.custom("Roboto-Bold", size: 16))

            TextField(
                "\(editProfileViewModel.editSavingsGoal) kr",
                value: $editVM.editSavingsGoal,
                format: .number
            )
            .modifier(TextFieldModifier())

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
                    .modifier(
                        ButtonModifier(
                            backgroundColor: editProfileViewModel
                                .isNameValid
                                ? .darkGreen : Color.white.opacity(0.4)
                        )
                    )
            }
            .disabled(!editProfileViewModel.isNameValid)

            Spacer()
        }
        .foregroundStyle(.white)
        .padding()
        .onAppear {

            if let existingUser = users.first {
                editProfileViewModel.originalName = existingUser.name
                editProfileViewModel.editName = existingUser.name
                editProfileViewModel.editStartDate = existingUser.startDate
                editProfileViewModel.editDosor = existingUser.numberOfDosor
                editProfileViewModel.editPortioner =
                    existingUser.portionsPerDosa
                editProfileViewModel.editPrice = existingUser.pricePerDosa
                editProfileViewModel.editSavingsGoal = existingUser.savingsGoal
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
                    .foregroundColor(.white)
            }
        }
        .padding(.bottom, 50)
        .background(.lightGreen)
    }
}

#Preview {
    NavigationStack {
        EditProfileView()
            .environment(EditProfileViewModel())
    }
}
