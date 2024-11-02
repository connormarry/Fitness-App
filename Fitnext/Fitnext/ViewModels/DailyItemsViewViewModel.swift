import Foundation

struct ExerciseSet: Codable {
    var reps: Int
    var weight: Int
}

struct WorkoutItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var sets: [ExerciseSet]
    var isCompleted: Bool = false
    var isExpanded: Bool = false
    var date: Date
}

class DailyItemsViewViewModel: ObservableObject {
    @Published var workoutItems = [WorkoutItem]() {
        didSet {
            saveWorkouts()
        }
    }

    @Published var newName = ""
    @Published var selectedSets = 1
    @Published var setReps: [String] = [""]
    @Published var setWeights: [String] = [""]
    @Published var errorMessage: String?
    @Published var editingItem: WorkoutItem?

    init() {
        loadWorkouts()
    }
    
    func filteredItems(for date: Date) -> [WorkoutItem] {
        return workoutItems.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }

    func addWorkout(for date: Date) {
        guard !newName.isEmpty else {
            errorMessage = "Exercise name cannot be empty."
            return
        }
        var newSets: [ExerciseSet] = []
        for index in 0..<selectedSets {
            if let reps = Int(setReps[index]), let weight = Int(setWeights[index]) {
                newSets.append(ExerciseSet(reps: reps, weight: weight))
            } else {
                newSets.append(ExerciseSet(reps: 0, weight: 0))
            }
        }
        let newItem = WorkoutItem(name: newName, sets: newSets, date: date)
        workoutItems.append(newItem)
        resetAddFields()
    }
    
    func updateWorkout(_ item: WorkoutItem, for date: Date) {
        guard let index = workoutItems.firstIndex(where: { $0.id == item.id }) else { return }
        workoutItems[index].name = newName
        var updatedSets: [ExerciseSet] = []
        for index in 0..<selectedSets {
            if let reps = Int(setReps[index]), let weight = Int(setWeights[index]) {
                updatedSets.append(ExerciseSet(reps: reps, weight: weight))
            } else {
                updatedSets.append(ExerciseSet(reps: 0, weight: 0))
            }
        }
        workoutItems[index].sets = updatedSets
        workoutItems[index].date = date
        resetEditFields()
    }

    func toggleCompletion(for item: WorkoutItem) {
        if let index = workoutItems.firstIndex(where: { $0.id == item.id }) {
            workoutItems[index].isCompleted.toggle()
        }
    }
    
    func toggleExpanded(for itemId: UUID) {
        if let index = workoutItems.firstIndex(where: { $0.id == itemId }) {
            workoutItems[index].isExpanded.toggle()
        }
    }
    
    func deleteWorkout(at offsets: IndexSet) {
        workoutItems.remove(atOffsets: offsets)
    }
    
    func prepareForEditing(item: WorkoutItem) {
        self.editingItem = item
        self.newName = item.name
        self.selectedSets = item.sets.count
        self.setReps = item.sets.map { String($0.reps) }
        self.setWeights = item.sets.map { String($0.weight) }
    }

    func resetAddFields() {
        newName = ""
        selectedSets = 1
        setReps = [""]
        setWeights = [""]
        errorMessage = nil
    }

    func resetEditFields() {
        newName = ""
        selectedSets = 1
        setReps = [""]
        setWeights = [""]
        editingItem = nil
        errorMessage = nil
    }

    func saveWorkouts() {
        if let encoded = try? JSONEncoder().encode(workoutItems) {
            UserDefaults.standard.set(encoded, forKey: "workoutItems")
        }
    }

    func loadWorkouts() {
        if let data = UserDefaults.standard.data(forKey: "workoutItems"),
           let decoded = try? JSONDecoder().decode([WorkoutItem].self, from: data) {
            workoutItems = decoded
        }
    }
    
    func dateHeader(for date: Date) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MM/dd/yy"
            
            let currentDate = Date()
            if Calendar.current.isDate(date, inSameDayAs: currentDate) {
                return "Today - \(formatter.string(from: date)):"
            } else {
                let dayFormatter = DateFormatter()
                dayFormatter.dateFormat = "EEEE" // Day of the week
                let dayOfWeek = dayFormatter.string(from: date)
                return "\(dayOfWeek) - \(formatter.string(from: date)):"
            }
        }
}
