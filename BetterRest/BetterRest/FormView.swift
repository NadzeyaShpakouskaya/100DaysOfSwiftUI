//
//  FormView.swift
//  BetterRest
//
//  Created by Nadzeya Shpakouskaya on 31/05/2022.
//
import CoreML
import SwiftUI


struct FormView: View {
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
            
            Form{
                Section {
                    HStack{
                        Spacer()
                        DatePicker("Select time", selection: $time, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                        Spacer()
                    }
                } header: {
                    Label("What time do you want to wake up?", systemImage: "sunrise.fill").foregroundColor(.indigo)
                }
                
                Section {
                    Stepper("\(sleepingTime.formatted()) hours", value: $sleepingTime, in: 4...12, step: 0.25)
                } header: {
                    Label("Desire time of sleep?", systemImage: "bed.double.fill")
                }.foregroundColor(.cyan)
                
                Section {
                    Picker("Cups of coffee per day", selection: $coffeeCupCounter){
                        ForEach(0..<21) { counter in
                            Text(counter == 1 ? "1 cup" : "\(counter) cups")
                        }
                    }
                } header: {
                    Label("Cups of coffee per day", systemImage: "cup.and.saucer.fill")
                }.foregroundColor(.orange)
                
                Section{
                    HStack{
                        Spacer()
                        Text("\(bedtime.formatted(date: .omitted, time: .shortened))").font(.largeTitle.bold())
                        Spacer()
                    }
                } header:{
                    Text("Your ideal bedtime is")
                }
                .foregroundColor(.green)
                
            }.font(.body)
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

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}

