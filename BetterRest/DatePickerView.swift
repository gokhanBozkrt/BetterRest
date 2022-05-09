//
//  DatePicker.swift
//  BetterRest
//
//  Created by Gokhan Bozkurt on 22.04.2022.
//

import SwiftUI

struct DatePickerView: View {
    @State private var wakeUp = Date.now
    var body: some View {
       // DatePicker("Please enter time", selection: $wakeUp, in : Date.now...)
      //  DatePicker("Please enter time", selection: $wakeUp, displayedComponents: .hourAndMinute)
     //   DatePicker("Please enter time", selection: $wakeUp, displayedComponents: .date)
// .labelsHidden()
        Text(Date.now.formatted(date: .complete, time: .shortened))
        }
    func exampleDAte() {
      //  let now = Date.now
       //  let tommorrow = Date.now.addingTimeInterval(86400)
       // let range = now...tommorrow
        /*
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        let date = Calendar.current.date(from: components) ?? Date.now
        */
        let components = Calendar.current.dateComponents([.hour,.minute], from: Date.now)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        
        
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView()
    }
}
