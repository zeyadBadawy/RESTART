//
//  HomeView.swift
//  RESTART
//
//  Created by Zeyad Badawy on 14/04/2022.
//

import SwiftUI

struct HomeView: View {
    @AppStorage("OnBoarding") var isOnbardingViewActive = true
    @State private var isAnimating:Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                //MARK: HEADER
                ZStack {
                    CircleGroupView(circleColor: .gray, CircleOpacity: 0.1)
                    
                    Image("character-2")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .offset(y: isAnimating ? 20 : -20)
                        .animation(
                            Animation
                                .easeOut(duration: 4)
                                .repeatForever()
                            , value: isAnimating
                        )
                } //: HEADER
                
                //MARK: CENTRE
                
                Text("""
                    The time that leads to mastery is
                    dependent on the intensity of our foucs.
                    """)
                .font(.system(.title3))
                .fontWeight(.light)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
                //: CENTRE
                
                Spacer()
                //MARK: BOTTOM
                Button {
                    withAnimation {
                        playAudio(name: "success", type: "m4a")
                        isOnbardingViewActive = true
                    }
                    
                } label: {
                    Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
                        .imageScale(.large)
                    Text("Restart")
                        .font(.system(.title3 ,design: .rounded))
                        .fontWeight(.bold)
                } //:BOTTOM
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .controlSize(.large)
            } //: VSTACK
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isAnimating = true
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
