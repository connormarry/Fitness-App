import SwiftUI

struct CalendarView: View {
    @State private var selectedDate = Date()
    @StateObject private var viewModel = DailyItemsViewViewModel()
    
    var body: some View {
        VStack {
            DatePicker("Select a date", selection: $selectedDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            NavigationLink(destination: DailyItemsView(viewModel: viewModel, selectedDate: selectedDate)) {
                Text("Show Workouts")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Calendar")
        .onAppear {
            viewModel.loadWorkouts()
        }
    }
}

#Preview {
    CalendarView()
}
