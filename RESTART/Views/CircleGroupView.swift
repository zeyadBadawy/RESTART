//
//  CircleGroupView.swift
//  RESTART
//
//  Created by Zeyad Badawy on 15/04/2022.
//

import SwiftUI

struct CircleGroupView: View {
    
    @State var circleColor: Color
    @State var CircleOpacity: Double
    @State var isAnimation:Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(circleColor.opacity(CircleOpacity), lineWidth: 40)
            .frame(width: 260, height: 260, alignment: .center)
            Circle()
                .stroke(circleColor.opacity(CircleOpacity), lineWidth: 80)
                .frame(width: 260, height: 260, alignment: .center)
        }
        .opacity(isAnimation ? 1 : 0 )
        .blur(radius: isAnimation ? 0 : 10 )
        .scaleEffect(isAnimation ? 1 : 0.5 )
        .animation(.easeOut(duration: 1), value: isAnimation)
        .onAppear {
            isAnimation = true
        }
    }
}

struct CircleGroupView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("ColorBlue")
                .ignoresSafeArea(.all
                                 , edges: .all)
            CircleGroupView(circleColor: .white, CircleOpacity: 0.2)
        }
    }
}
