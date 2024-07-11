import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewViewModel()
    @State private var action: Int? = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                // HeaderView placed first
                
                    HeaderView(title: "FITNEXT",
                               subtitle: "No more excuses...",
                               rotation: -10,
                               background: .blue)
                
                .offset(y: -185)
                VStack {
                    
                    NavigationLink(destination: CalorieCalculatorView()) {
                        Text("Calorie Calculator")}
                    
                    .padding()
                    NavigationLink(destination: DailyItemsView()) {
                        Text("Daily Items")}
                    .padding()
                    NavigationLink(destination: CalendarView()) {
                        Text("My Calendar")}
                    .padding()
                    
                }
                    .padding()
                } // Adjust the top padding if needed
            }
        }
    }


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
