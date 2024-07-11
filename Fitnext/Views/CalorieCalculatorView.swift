import SwiftUI

struct DismissingKeyboard: ViewModifier {
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
    }
}

extension View {
    func dismissKeyboardOnTap() -> some View {
        modifier(DismissingKeyboard())
    }
}

struct CalorieCalculatorView: View {
    @StateObject var viewModel = CalorieCalculatorViewModel()

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    // Gender Selection
                    HStack {
        
                        Text("Gender")
                        Spacer()
                        Picker("Gender", selection: $viewModel.gender) {
                            Text("Male").tag("m")
                            Text("Female").tag("f")
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 120)
                    }
                    .padding()
                    

                    // Age Input
                    HStack {
                        Text("Age:")
                        Spacer()
                        TextField("Age (years)", text: $viewModel.age)
                            .keyboardType(.numberPad)
                            .frame(width: 130)
                    }
                    .padding()
                        

                    // Weight Input
                    HStack {
                        Text("Weight:")
                        Spacer()
                        TextField("Weight (lbs)", text: $viewModel.weight)
                            .keyboardType(.numberPad)
                            .frame(width: 135)
                    }
                    .padding()

                    // Height Selection
                    HStack {
                        Text("Height:")
                        Spacer()
                        Picker("Feet", selection: $viewModel.feet) {
                            ForEach(4..<9) { feet in
                                Text("\(feet) ft").tag(feet)
                            }
                        }
                        Picker("Inches", selection: $viewModel.inches) {
                            ForEach(0..<12) { inches in
                                Text("\(inches) in").tag(inches)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 115)
                    }
                    .padding()

                    // Activity Level Input
                    HStack {
                        Text("Activity Level:")
                        Spacer()
                        Picker("Activity Level", selection: $viewModel.activity) {
                            Text("Sedentary").tag("1")
                            Text("Slightly Active").tag("2")
                            Text("Active").tag("3")
                            Text("Very Active").tag("4")
                            Text("Extremely Active").tag("5")
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 170)
                    }
                    .padding()

                    // Goal Selection
                    HStack {
                        Text("Goal:")
                        Spacer()
                        Picker("", selection: $viewModel.goal) {
                            Text("Lose Weight").tag("l")
                            Text("Maintain Weight").tag("m")
                            Text("Gain Weight").tag("g")
                        }
                        .pickerStyle(MenuPickerStyle())
                        .frame(width: 190)
                    }
                    .padding()

                    // Error Message
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }

                    // Calculate Button
                    FNButton(title: "Calculate", background: .blue){
                        viewModel.calculateCalories()
                    }
                    .frame(width: 150, height: 75)
                    .padding()

                    // Result Message
                    if !viewModel.resultMessage.isEmpty {
                        Text(viewModel.resultMessage)
                            .padding()
                    }
                }
            }
            .dismissKeyboardOnTap()
            .navigationBarTitle("Calorie Calculator", displayMode: .inline)
            .padding(.top, 50)
        }
    }
}

// Preview
struct CalorieCalculatorView_Previews: PreviewProvider {
    static var previews: some View {
        CalorieCalculatorView()
    }
}
