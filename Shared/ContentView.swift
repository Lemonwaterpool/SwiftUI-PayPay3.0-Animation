//
//  ContentView.swift
//  Shared
//
//  Created by H Chan on 2021/06/14.
//

import SwiftUI

enum CardType {
    case barcode
    case balance
}


struct ContentView: View {
    
    @State var type = CardType.barcode
    @State var movingUp = false
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                Spacer()
                Color.green
                    .frame(width: 240, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .zIndex(0)
            
            Text("barcode")
                .frame(width: 200, height: 100)
                .background(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .rotation3DEffect(.degrees(type == .barcode ? 0 : -180), axis: (x: 1, y: 0, z: 0))
                .opacity(type == .barcode ? 1 : 0)
                .offset(y: movingUp ? -20 : 0)
                .animation(.default)
                .zIndex(1)
                .shadow(radius: 10)
                .onTapGesture {
                    type = .balance
                    moveCardUp()
                }
            
            Text("balance")
                .frame(width: 200, height: 100)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .rotation3DEffect(.degrees(type == .balance ? 0 : 180), axis: (x: 1, y: 0, z: 0))
                .opacity(type == .balance ? 1 : 0)
                .offset(y: movingUp ? -20 : 0)
                .animation(.default)
                .zIndex(3)
                .shadow(radius: 10)
                .onTapGesture {
                    type = .barcode
                    moveCardUp()
                }
            
            VStack {
                Spacer()
                Color.purple
                    .frame(width: 240, height: 65)
                    .clipShape(FrontCardShape())
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius: 10)
            }
            .zIndex(2)
        }
        .frame(height: 160)
        .padding()
    }
    
    private func moveCardUp() {
        movingUp = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            movingUp = false
        }
    }
}

struct FrontCardShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint.zero)
            path.addLine(to: CGPoint(x: rect.maxX * 0.7, y: rect.minY))
            path.addArc(center: CGPoint(x: rect.maxX * 0.7, y: 10), radius: 10, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
            path.addArc(center: CGPoint(x: rect.maxX * 0.7+20, y: 10), radius: 10, startAngle: .degrees(180), endAngle: .degrees(90), clockwise: true)
            path.addLine(to: CGPoint(x: rect.maxX - 12, y: 20))
            path.addArc(center: CGPoint(x: rect.maxX - 12, y: 32), radius: 12, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 500, height: 400)
    }
}
