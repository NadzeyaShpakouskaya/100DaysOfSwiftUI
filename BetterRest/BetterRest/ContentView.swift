//
//  ContentView.swift
//  BetterRest
//
//  Created by Nadzeya Shpakouskaya on 31/05/2022.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var time = defaultTime
    @State private var sleepingTime = 8.0
    @State private var coffeeCupCounter = 1
    
    static var defaultTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var bedtime: Date {
        calculate()
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 50) {
                VStack {
                    Label("Desire time of sleep?", systemImage: "bed.double.fill")
                    
                    Stepper("\(sleepingTime.formatted()) hours", value: $sleepingTime, in: 4...12, step: 0.25)
                }.foregroundColor(.green)
                
                HStack {
                    Label("Time to wake up?", systemImage: "sunrise.fill")
                    Spacer()
                    DatePicker("Select time", selection: $time, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }.foregroundColor(.indigo)
                
               
                
                HStack {
                    Label("Cups of coffee per day", systemImage: "cup.and.saucer.fill")
                    Picker("Cups of coffee per day", selection: $coffeeCupCounter){
                        ForEach(0..<21) { counter in
                            Text(counter == 1 ? "1 cup" : "\(counter) cups")

                        }
                    }
                }.foregroundColor(.cyan)
                
                Spacer()
                HStack{
                    Text("Your ideal bedtime is")
                    Text("\(bedtime.formatted(date: .omitted, time: .shortened))")
                }.font(.headline.bold())
                    .foregroundColor(.orange)
                
    Spacer()
      
            }
            .font(.headline)
            .padding()

            .navigationTitle("Better Rest")
        }
    }
    
    
    func calculate() -> Date {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: time)
            let hours = components.hour ?? 0
            let minutes = components.minute ?? 0
            
            let timesInSeconds = Double(hours * 60 * 60 + minutes * 60)
            
            let prediction = try model.prediction(wake: timesInSeconds, estimatedSleep: sleepingTime, coffee: Double(coffeeCupCounter))
            
            let sleepTime = time - prediction.actualSleep
            return sleepTime
        } catch {
            print("ERROR: with MLCore")
            return Date.now
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

