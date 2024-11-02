import Foundation
import Combine

class CalendarViewModel: ObservableObject {
    @Published var selectedDate: Date = Date() // Default to today

    // Optionally, add functionality to get or set other date-related information
    func formattedSelectedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }

    // You can add more methods related to date manipulation as needed
    func moveToNextDay() {
        selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate) ?? selectedDate
    }

    func moveToPreviousDay() {
        selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate) ?? selectedDate
    }
}
