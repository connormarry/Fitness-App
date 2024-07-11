// DailyItemsView.swift

import SwiftUI

struct DailyItemsView: View {
    @StateObject var viewModel = DailyItemsViewModel()
    @State private var showingAddExercise = false
    @State private var newName = ""
    @State private var selectedSets = 1
    @State private var setReps: [String] = []
    @State private var setWeights: [String] = []

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.workoutItems) { item in
                        HStack {
                            Button(action: {
                                viewModel.toggleCompletion(for: item)
                            }) {
                                Image(systemName: item.isCompleted ? "checkmark.square" : "square")
                            }
                            Text(item.name)
                            Spacer()
                            Text("\(item.sets.count) sets")
                        }
                    }
                }
                .navigationTitle("Daily Workouts")
                
                Divider()
                
                // Add Exercise Button
                Button(action: {
                    showingAddExercise.toggle()
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                        Text("Add Exercise")
                            .foregroundColor(.blue)
                            .fontWeight(.semibold)
                    }
                }
                .padding()
                
            }
        }
        .sheet(isPresented: $showingAddExercise) {
            VStack(alignment: .leading) {
                Text("Add Exercise")
                    .font(.headline)
                    .padding(.bottom, 8)
                
                TextField("Exercise Name", text: $newName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 8)
                
                Stepper("Sets: \(selectedSets)", value: $selectedSets, in: 1...10)
                    .padding(.bottom, 8)
                
                ForEach(0..<selectedSets, id: \.self) { index in
                    HStack {
                        Text("Set \(index + 1):")
                        Spacer()
                        TextField("Reps", text: binding(for: index, array: $setReps)) // Bind as String
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                        TextField("Weight (lbs)", text: binding(for: index, array: $setWeights)) // Bind as String
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.decimalPad)
                    }
                    .padding(.bottom, 8)
                }
                
                Button("Add Exercise") {
                    var newSets: [ExerciseSet] = []
                    for index in 0..<selectedSets {
                        if let reps = Int(self.setReps[index]), let weight = Double(self.setWeights[index]) {
                            newSets.append(ExerciseSet(reps: reps, weight: weight))
                        }
                    }
                    viewModel.addWorkout(name: newName, sets: newSets)
                    newName = ""
                    setReps = Array(repeating: "", count: selectedSets) // Reset reps
                    setWeights = Array(repeating: "", count: selectedSets) // Reset weights
                    showingAddExercise.toggle()
                }
                .padding(.bottom, 8)
            }
            .padding()
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

struct DailyItemsView_Previews: PreviewProvider {
    static var previews: some View {
        DailyItemsView()
    }
}
