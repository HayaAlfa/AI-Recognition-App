//
//  ContentView.swift
//  AI-Recognition
//
//  Created by Haya Alfakieh on 9/29/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var vm = CameraViewModel()
    
    var body: some View {
        GeometryReader { geo in // wrapper to do calculation
            ZStack {
                Color.black.ignoresSafeArea()
                
                ForEach(vm.detections) { det in
                    let box = pixelRect(from: det.normalizedBounds, in: geo.size)
                    
                    Rectangle()
                        .stroke(.red, lineWidth: 2)
                        .frame(width: box.width, height: box.height)
                        .position(x: box.midX, y: box.midY)
                    
                    Text("\(det.label) \(Int(det.score * 100))%")
                        .font(.caption).bold().foregroundStyle(.white)
                        .padding(.horizontal, 6).padding(.vertical, 2)
                        .background(Color.black.opacity(0.7))
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                        .position(x: box.midX, y: box.minY - 10)
                }
            }
        }
    }
    
    // ✅ helper method is at struct level now, not inside body
    private func pixelRect(from norm: CGRect, in size: CGSize) -> CGRect {
        CGRect(
            x: norm.origin.x * size.width,
            y: norm.origin.y * size.height,
            width: norm.width * size.width,
            height: norm.height * size.height
        )
    }
}

#Preview {
    ContentView()
}
