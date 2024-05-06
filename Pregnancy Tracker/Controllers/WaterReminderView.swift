//
//  WaterReminderView.swift
//  Pregnancy Tracker
//
//  Created by Turan Çabuk on 4.05.2024.
//

import SwiftUI

struct WaterReminderView: View {
    @State private var hydrationPercent: CGFloat = 65
    let targetIntake = 3300.0 // ml

    var body: some View {
        VStack {
            // Greeting and Date
            VStack(alignment: .leading) {
                Text("Hi, Justin")
                    .font(.title)
                    .fontWeight(.medium)
                Text("Today, 8 Feb, 2023")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding()

            // Hydration Circle
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)

                Circle()
                    .trim(from: 0.0, to: hydrationPercent / 100)
                    .stroke(style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .foregroundColor(Color.blue)
                    .rotationEffect(Angle(degrees: 270))
                    .animation(.linear, value: hydrationPercent)

                VStack {
                    Text("\(Int(hydrationPercent))%")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("\(Int(hydrationPercent / 100 * targetIntake), specifier: "%g") ML")
                        .font(.title3)
                    Text("\(Int(targetIntake - hydrationPercent / 100 * targetIntake), specifier: "%+g") ML")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 200, height: 200)

            // Water Intake Buttons
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 20) {
                ForEach([300, 600, 250, 200, 100, 50], id: \.self) { amount in
                    Button(action: {
                        self.hydrationPercent += CGFloat(amount) / self.targetIntake * 100
                    }) {
                        VStack {
                            Image(systemName: "drop.fill")
                                .foregroundColor(.white)
                            Text("\(amount) ml")
                                .foregroundColor(.white)
                        }
                        .padding()
                        .background(Circle().fill(Color.blue))
                    }
                }
            }
            .padding()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WaterReminderView()
    }
}

