//
//  DuolingoIcon.swift
//  LanguageApp
//
//  Created by Александр Переславцев on 07.12.2024.
//

import SwiftUI

struct IconShape: Shape {
    func path(in rect: CGRect) -> Path {
           var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.height, startAngle: Angle(degrees: 110), endAngle: Angle(degrees: 180), clockwise: false)
        
        path.closeSubpath()
        return path
    }
}

struct DuolingoIcon: View {
    var body: some View {
        IconShape()
//            .fill()
            .frame(width: 150, height: 150)
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
//struct ContentView: View {
//    @AppStorage("tapCount") private var tapCount = 0
//
//    var body: some View {
//        Button("Tap count: \(tapCount)") {
//            tapCount += 1
//        }
//    }
//}
#Preview {
//    ContentView()
    DuolingoIcon()
}


//        Circle()
//            .fill(Color.blue)
//            .frame(width: 200, height: 200)
//            .mask(
//                Rectangle()
//                    .frame(width: 200, height: 100)
//                    .offset(y: -50) // Сдвиг маски для верхней половины
//            )
