//
//  ContentView.swift
//  FlashCards
//
//  Created by Nadzeya Shpakouskaya on 25/07/2022.
//

import SwiftUI

// MARK: - Tap Gestures

struct BasicTapGestureView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Double tap")
                .padding()
            // Double tap
                .onTapGesture(count: 2) {
                    print("Double tapped!")
                }
            // long tap
            Text("Long tap")
                .padding()
            
                .onLongPressGesture {
                    print("Long pressed!")
                }
            // long tap duration 2+ sec
            Text("Long tap with duration 2 sec")
                .padding()
            
                .onLongPressGesture(minimumDuration: 2) {
                    print("Long pressed!")
                }
            /*
             You can even add a second closure that triggers whenever the state of the gesture has changed. This will be given a single Boolean parameter as input, and it will work like this:
             
             As soon as you press down the change closure will be called with its parameter set to true.
             If you release before the gesture has been recognized (so, if you release after 1 second when using a 2-second recognizer), the change closure will be called with its parameter set to false.
             If you hold down for the full length of the recognizer, then the change closure will be called with its parameter set to false (because the gesture is no longer in flight), and your completion closure will be called too.
             */
            Text("Long tap with specified pressing action")
                .padding()
            
                .onLongPressGesture(minimumDuration: 1) {
                    print("Long pressed!")
                } onPressingChanged: { inProgress in
                    print("In progress: \(inProgress)!")
                }
        }
    }
}

struct ScaleGestureView: View {
    @State private var currentAmount = 0.0
    @State private var finalAmount = 1.0
    
    var body: some View {
        Text("Hello, World!")
            .scaleEffect(finalAmount + currentAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged { amount in
                        currentAmount = amount - 1
                    }
                    .onEnded { amount in
                        finalAmount += currentAmount
                        currentAmount = 0
                    }
            )
    }
}

struct RotationGestureView: View {
    @State private var currentAmount = Angle.zero
    @State private var finalAmount = Angle.zero
    
    var body: some View {
        Text("Hello, World!")
            .rotationEffect(currentAmount + finalAmount)
            .gesture(
                RotationGesture()
                    .onChanged { angle in
                        currentAmount = angle
                    }
                    .onEnded { angle in
                        finalAmount += currentAmount
                        currentAmount = .zero
                    }
            )
    }
}

// child view has high priority for tap to the same gesture
struct OrderingGesture: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .onTapGesture {
                    print("Text tapped")
                }
        }
        .onTapGesture {
            print("VStack tapped")
        }
    }
}

// we can change priority for parents view (it will respond first)
struct HighPriorityGestureView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .onTapGesture {
                    print("Text tapped")
                }
        }
        .highPriorityGesture(
            TapGesture()
                .onEnded { _ in
                    print("VStack tapped")
                }
        )
    }
}
// both child and parent will respond to the gesture
struct SimultaneousGestureView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .onTapGesture {
                    print("Text tapped")
                }
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    print("VStack tapped")
                }
        )
    }
}

struct CombinedGestureView: View {
    // how far the circle has been dragged
    @State private var offset = CGSize.zero
    
    // whether it is currently being dragged or not
    @State private var isDragging = false
    
    var body: some View {
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
            .onChanged { value in offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }
        
        // a long press gesture that enables isDragging
        let pressGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                }
            }
        
        // a combined gesture that forces the user to long press then drag
        let combined = pressGesture.sequenced(before: dragGesture)
        
        // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
        Circle()
            .fill(.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
    }
}

// MARK: -  basic haptics
struct BasicHapticsView: View {
    var body: some View {
        Text("Basic haptics")
            .padding()
            .onTapGesture(perform: simpleSuccess)
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

// MARK: - Custom haptics
import CoreHaptics

struct CustomHapticView: View {
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Text("Custom haptics")
            .onAppear(perform: prepareHaptics)
            .onTapGesture(perform: complexSuccess)
        
    }
    
    func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func complexSuccess() {
        // make sure that the device supports haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        
        // increase intense on tap during 1 sec
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }
        
        // decrease intense on tap during 1 sec
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            
            // use 1 + i  because previous events length 1 sec.
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        // convert those events into a pattern and play it immediately
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error.localizedDescription).")
        }
    }
}

// MARK: - User Interactivity and Disabling
struct InteractiveView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }
            
            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Circle tapped!")
                }
            // disable reacting on tap gesture
                .allowsHitTesting(false)
            
            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
            // we can use content shape to expand the responsive area
                .contentShape(Rectangle())
                .onTapGesture {
                    print("Circle tapped!")
                }
            
            VStack {
                Text("Hello")
                Spacer().frame(height: 100)
                Text("World")
            }
            // without content shape spacer is invisible for taps, only words will respond to taps
            .contentShape(Rectangle())
            .onTapGesture {
                print("VStack tapped!")
            }
        }
    }
}

// MARK: - Triggered by timer

struct TimerTriggeredView: View {
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
    @State private var counter = 0
    
    var body: some View {
        Text("Hello world")
            .onReceive(timer) { time in
                if counter == 5 {
                    timer.upstream.connect().cancel()
                } else {
                    print("The time is now \(time)")
                }
                
                counter += 1
            }
    }
}

// MARK: - Scene phases

/// active - running, visible, user can interact
/// inactive - running, can be visible, no access to interact with app
/// background - running, not visible, and non-interactive, can be terminated by system

struct ScenePhasesView: View {
    @Environment(\.scenePhase) var scenePhase
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onChange(of: scenePhase) { newPhase in
                /*
                 Active scenes are running right now, which on iOS means they are
                 visible to the user. On macOS an app’s window might be wholly hidden
                 by another app’s window, but that’s okay – it’s still considered to be active.
                 */
                if newPhase == .active {
                    print("Active")
                    /*
                     Inactive scenes are running and might be visible to the user,
                     but the user isn’t able to access them. For example,
                     if you’re swiping down to partially reveal the control center
                     then the app underneath is considered inactive.
                     */
                } else if newPhase == .inactive {
                    print("Inactive")
                    /*
                     Background scenes are not visible to the user, which on iOS means
                     they might be terminated at some point in the future.
                     */
                } else if newPhase == .background {
                    print("Background")
                }
            }
    }
}

// MARK: - Specific Accessibility Needs Views

// When this setting is enabled, apps should try to make their UI clearer
// using shapes, icons, and textures rather than colors.
struct DifferentiateWithoutColorView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

    var body: some View {
        HStack {
            if differentiateWithoutColor {
                Image(systemName: "checkmark.circle")
            }

            Text("Success")
        }
        .padding()
        .background(differentiateWithoutColor ? .black : .green)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
}

/// We can use this func instead of withAnimation
///
/// If reduceMotion is enabled, just re-invoke the body as it is
/// otherwise use provided animation

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

/// limit the amount of animation that causes movement on screen.
/// For example, the iOS app switcher makes views fade in and out rather than scale up and down.
struct ReduceMotionView: View {
    @Environment(\.accessibilityReduceMotion) var reduceMotion
    @State private var scale = 1.0

    var body: some View {
        Text("Hello, World!")
            .scaleEffect(scale)
            .onTapGesture {
                withOptionalAnimation {
                    scale *= 1.5
                }
            }
    }
}


// reduce the amount of blur and translucency to make everything is clear.
struct ReduceTransparencyView: View {
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency

    var body: some View {
        Text("Hello, World!")
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //        BasicTapGestureView()
        //        ScaleGestureView()
        //        RotationGestureView()
        //        HighPriorityGestureView()
        //        SimultaneousGestureView()
        //        CombinedGestureView()
        TimerTriggeredView()
    }
}
