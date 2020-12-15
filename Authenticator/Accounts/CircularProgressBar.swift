//
//  CircularProgressBar.swift
//  Authenticator
//
//  Created by Bastiaan Jansen on 15/12/2020.
//

import SwiftUI

struct CircularProgressBar: View {
    @Binding var progress: Float
    @Binding var color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 4)
                .opacity(0.3)
                .foregroundColor(.gray)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(max(0.01, progress), 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270))
                .animation(.linear)
        }
    }
}

struct CircularProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        CircularProgressBar(progress: .constant(0.4), color: .constant(.accentColor))
    }
}
