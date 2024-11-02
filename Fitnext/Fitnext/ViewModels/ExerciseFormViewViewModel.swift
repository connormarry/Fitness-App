import Foundation

class ExerciseFormViewViewModel: ObservableObject {
    @Published var newName: String = ""
    @Published var selectedSets: Int = 1
    @Published var setReps: [String] = [""]
    @Published var setWeights: [String] = [""]
    @Published var errorMessage: String?

    func adjustSets() {
        if selectedSets > setReps.count {
            setReps.append("")
            setWeights.append("")
        } else if selectedSets < setReps.count {
            setReps.removeLast()
            setWeights.removeLast()
        }
    }

    func resetFields() {
        newName = ""
        selectedSets = 1
        setReps = [""]
        setWeights = [""]
        errorMessage = nil
    }
}
