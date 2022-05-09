//
//  CreateMLView.swift
//  BetterRest
//
//  Created by Gokhan Bozkurt on 22.04.2022.
//
import CoreML
import SwiftUI

struct CreateMLView: View {
    @State private var wakeUp = defaultWakeUpTime
    @State private var sleepAmount = 8.0
    @State private var coffeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
  static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Your recomended bed time \(alertMessage) ")
                    .font(.title3)
              
                Form {
                    Section(header: Text("When do you want to wake up ?") ) {
                      // .
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    }
                    Section(header: Text("Desired amount of sleep") ){
                         //   .font(.headline)
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in : 4...12, step:0.25)
                    }
                    Section(header:Text("Daily coffe intake") ) {
                    
                        Picker("Cups of Coffe",selection: $coffeAmount) {
                            ForEach(1...20, id:\.self) {
                                Text(String($0))
                            }
                        }
                        Text("You drink \(coffeAmount == 1 ? "1 cup" : "\(coffeAmount) cups") of coffe ")
                            .font(.callout)
                        //  .font(.headline)
                  //  Stepper(coffeAmount == 1 ? "1 cup" : "\(coffeAmount) cups", value: $coffeAmount, in : 1...20)
                    }
                    
                } .navigationTitle("Better Rest")
           
                Button("Calculate") {
                    calculateBedTime()
                }
                
            }.padding()
            /*
           .toolbar {
                    Button("Calculate", action : calculateBedTime)
                }
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("OK") { }
                } message: {
                    Text(alertMessage)
                }
             */
        }
        
    }
     func calculateBedTime() {
         do {
             let config = MLModelConfiguration()
             let model = try SleepCalc_1(configuration: config)
             // more code here
             let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
             let hour = (components.hour ?? 0) * 60 * 60
             let minute = (components.minute ?? 0) * 60
             
             let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeAmount))
        
           
             let sleepTime = wakeUp - prediction.actualSleep
             alertTitle = "Your ideal bed time.."
             alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
         } catch {
             alertTitle = "Error"
             alertMessage = "Problem Occured calculating yout bed time"
         }
         showingAlert = true
    }
}

struct CreateMLView_Previews: PreviewProvider {
    static var previews: some View {
        CreateMLView()
    }
}
