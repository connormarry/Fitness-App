import Foundation
import Combine

class CalorieCalculatorViewModel: ObservableObject {
    @Published var sex: String = "m"
    @Published var age: String = ""
    @Published var weight: String = ""
    @Published var feet: Int = 5
    @Published var inches: Int = 7
    @Published var activity: String = "1"
    @Published var goal: String = "l"
    @Published var errorMessage: String = ""
    @Published var resultMessage: String = ""
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        // Initialize publishers for input validation
        $sex
            .sink { [weak self] value in
                self?.validateSex(value)
            }
            .store(in: &cancellableSet)
        
        $age
            .sink { [weak self] value in
                self?.validateAge(value)
            }
            .store(in: &cancellableSet)
        
        $weight
            .sink { [weak self] value in
                self?.validateWeight(value)
            }
            .store(in: &cancellableSet)
        
        $activity
            .sink { [weak self] value in
                self?.validateActivity(value)
            }
            .store(in: &cancellableSet)
        
        $goal
            .sink { [weak self] value in
                self?.validateGoal(value)
            }
            .store(in: &cancellableSet)
    }
    
    
    private func validateSex(_ value: String) {
        if (value.lowercased() != "m" && value.lowercased() != "f") {
            errorMessage = "Please select sex"
        } else {
            errorMessage = ""
        }
    }
    
    private func validateAge(_ value: String) {
        guard let age = Int(value) else {
            errorMessage = "Please enter a valid age"
            return
        }
        
        if age < 0 {
            errorMessage = "Age must be positive"
        } else if age < 10 {
            errorMessage = "\(age) years old is too young to workout"
        } else if age > 120 {
            errorMessage = "\(age) years old is too old to workout"
        }  else {
            errorMessage = ""
        }
    }
    
    private func validateWeight(_ value: String) {
        guard let weight = Int(value) else {
            errorMessage = "Please enter a valid weight"
            return
        }
        
        if weight < 0 || weight > 1500 {
            errorMessage = "Weight must be between 0 and 1500 lbs"
        } else {
            errorMessage = ""
        }
    }
    
    private func validateActivity(_ value: String) {
        guard let activity = Int(value) else {
            errorMessage = "Please enter a valid activity level"
            return
        }
        
        if activity < 1 || activity > 5 {
            errorMessage = "Activity level must be between 1 and 5"
        }else {
            errorMessage = ""
        }
    }
    
    private func validateGoal(_ value: String) {
        if value.lowercased() != "l" && value.lowercased() != "m" && value.lowercased() != "g" {
            errorMessage = "Please select a goal"
        } else {
            errorMessage = ""
        }
    }
    
    func calculateCalories() {
        guard errorMessage.isEmpty else { return }
        
        if age.isEmpty || weight.isEmpty {
            errorMessage = "Missing field(s) required"
            return
        }
        
        let heightInCm = Double(feet * 12 + inches) * 2.54
        let weightInKg = Double(weight)! * 0.453592
        
        var bmr: Double
        
        if sex.lowercased() == "m" {
            bmr = (13.397 * weightInKg) + (4.799 * heightInCm) - (5.677 * Double(age)!) + 88.362
        } else {
            bmr = (9.247 * weightInKg) + (3.098 * heightInCm) - (4.330 * Double(age)!) + 447.593
        }
        
        let activityMultiplier: Double
        
        switch Int(activity)! {
        case 1:
            activityMultiplier = 1.2
        case 2:
            activityMultiplier = 1.375
        case 3:
            activityMultiplier = 1.55
        case 4:
            activityMultiplier = 1.75
        case 5:
            activityMultiplier = 1.9
        default:
            activityMultiplier = 1.2
        }
        
        bmr *= activityMultiplier
        
        var low = 0
        var high = 0
        
        if goal.lowercased() == "l" {
            low = Int(bmr) - 1000
            high = Int(bmr) - 500
            resultMessage = "Recommended Daily Calories: \(low) to \(high)"
        } else if goal.lowercased() == "m" {
            resultMessage = "Recommended Daily Calories: ~\(Int(bmr))"
        } else if goal.lowercased() == "g" {
            low = Int(bmr) + 250
            high = Int(bmr) + 500
            resultMessage = "Recommended Daily Calories: \(low) to \(high)"
        }
    }
}
