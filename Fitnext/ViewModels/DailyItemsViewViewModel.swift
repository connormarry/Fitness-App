// DailyItemsViewModel.swift

import Foundation

struct ExerciseSet {
    var reps: Int
    var weight: Double
}

struct WorkoutItem: Identifiable {
    let id = UUID()
    var name: String
    var sets: [ExerciseSet]
    var isCompleted: Bool = false
}

class DailyItemsViewModel: ObservableObject {
    @Published var workoutItems = [WorkoutItem]()

    func addWorkout(name: String, sets: [ExerciseSet]) {
        var newItem = WorkoutItem(name: name, sets: [])
        for set in sets {
            newItem.sets.append(set)
        }
        workoutItems.append(newItem)
    }

    func toggleCompletion(for item: WorkoutItem) {
        if let index = workoutItems.firstIndex(where: { $0.id == item.id }) {
            workoutItems[index].isCompleted.toggle()
        }
    }
}
