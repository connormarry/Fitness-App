import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = HomeViewViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                HeaderView(title: "HOME",
                           subtitle: "",
                           rotation: -10,
                           background: .blue)
                    .offset(y: -185)

                VStack(spacing: 20) {
                    // Calorie Calculator Button
    
                        VStack {
                            NavigationLink(destination: DailyItemsView(selectedDate: Date())) {
                                Image(systemName: "list.bullet")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                                Text("Daily Workouts")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                            
                            }
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                            .frame(width: 350, height: 120)
                            
                            NavigationLink(destination: CalorieCalculatorView()) {
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
        
                                Text("Calorie Calculator")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                            .frame(width: 350, height: 120)

                            
                            NavigationLink(destination: CalendarView()) {
                                Image(systemName: "calendar")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                                Text("My Calendar")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                            .frame(width: 350, height: 120)

                            }
                            
                                
                            }
                            
                            
                            
                            

                .padding(.top, 200) // Adjust padding as needed
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
