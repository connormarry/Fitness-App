import SwiftUI

struct DailyItemsView: View {
    @StateObject var viewModel = DailyItemsViewViewModel()
    @State private var showingAddExercise = false
    @State private var showingEditExercise = false
    var selectedDate: Date

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.filteredItems(for: selectedDate)) { item in
                        VStack(alignment: .leading) {
                            HStack {
                                Button(action: {
                                    viewModel.toggleCompletion(for: item)
                                }) {
                                    Image(systemName: item.isCompleted ? "checkmark.square" : "square")
                                        .foregroundColor(.blue)
                                }
                                .buttonStyle(PlainButtonStyle())

                                Text(item.name)
                                Spacer()

                                Button(action: {
                                    viewModel.toggleExpanded(for: item.id)
                                }) {
                                    Image(systemName: item.isExpanded ? "chevron.down" : "chevron.right")
                                        .foregroundColor(.blue)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                            .contentShape(Rectangle())

                            if item.isExpanded {
                                ForEach(item.sets.indices, id: \.self) { index in
                                    Text("Set \(index + 1): \(item.sets[index].weight) lbs x \(item.sets[index].reps) reps")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .padding(.vertical, 5)
                        .onTapGesture {
                            viewModel.prepareForEditing(item: item)
                            showingEditExercise.toggle()
                        }
                    }
                    .onDelete(perform: viewModel.deleteWorkout)
                }
                .navigationTitle(viewModel.dateHeader(for: selectedDate))
                
                Button(action: {
                    viewModel.resetAddFields()
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
            ExerciseFormView(
                newName: $viewModel.newName,
                selectedSets: $viewModel.selectedSets,
                setReps: $viewModel.setReps,
                setWeights: $viewModel.setWeights,
                errorMessage: $viewModel.errorMessage,
                onSave: {
                    viewModel.addWorkout(for: selectedDate)
                    showingAddExercise.toggle()
                }
            )
        }
        .sheet(isPresented: $showingEditExercise) {
            ExerciseFormView(
                newName: $viewModel.newName,
                selectedSets: $viewModel.selectedSets,
                setReps: $viewModel.setReps,
                setWeights: $viewModel.setWeights,
                errorMessage: $viewModel.errorMessage,
                onSave: {
                    if let editingItem = viewModel.editingItem {
                        viewModel.updateWorkout(editingItem, for: selectedDate)
                        showingAddExercise.toggle()
                    }
                }
            )
        }
    }
}

struct DailyItemsView_Previews: PreviewProvider {
    static var previews: some View {
        DailyItemsView(viewModel: DailyItemsViewViewModel(), selectedDate: Date())
    }
}
