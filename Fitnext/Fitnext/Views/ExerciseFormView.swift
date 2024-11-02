import SwiftUI

struct ExerciseFormView: View {
    @Binding var newName: String
    @Binding var selectedSets: Int
    @Binding var setReps: [String]
    @Binding var setWeights: [String]
    @Binding var errorMessage: String?
    var onSave: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text("Exercise Details")
                .font(.headline)
                .padding(.bottom, 8)
                .padding(.horizontal, 20)

            TextField("Exercise Name", text: $newName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 8)
                .padding(.horizontal, 20)

            Stepper("Set(s): \(selectedSets)", value: $selectedSets, in: 1...10) { _ in
                adjustSets()
            }
            .padding(.bottom, 8)
            .padding(.horizontal, 20)

            ForEach(0..<selectedSets, id: \.self) { index in
                HStack {
                    Text("Set \(index + 1):")
                    Spacer()
                    TextField("Weight", text: binding(for: index, array: $setWeights))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .frame(width: 80)
                    Text("lbs")
                    Spacer()
                    Text("x")
                    Spacer()
                    TextField("Reps", text: binding(for: index, array: $setReps))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                        .frame(width: 80)
                }
                .padding(.bottom, 8)
                .padding(.horizontal, 20)
            }

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 8)
            }
            
            FNButton(
                title: "Save",
                background: .blue)
            {
                onSave()
            }
            .padding()
            .frame(width: 350, height: 75)
            
        }
        .padding()
        .onAppear {
            // Ensure that the text fields are filled if the arrays are empty
            if setReps.count != selectedSets {
                setReps = Array(repeating: "", count: selectedSets)
            }
            if setWeights.count != selectedSets {
                setWeights = Array(repeating: "", count: selectedSets)
            }
            print("ExerciseFormView appeared")
            print("newName: \(newName), setReps: \(setReps), setWeights: \(setWeights)")
        }

    }

    private func adjustSets() {
        if selectedSets > setReps.count {
            setReps.append("")
            setWeights.append("")
        } else if selectedSets < setReps.count {
            setReps.removeLast()
            setWeights.removeLast()
        }
    }

    private func binding(for index: Int, array: Binding<[String]>) -> Binding<String> {
        guard index >= 0 && index < array.wrappedValue.count else {
            return Binding<String>(
                get: { return "" },
                set: { _ in }
            )
        }
        return array[index]
    }
}
