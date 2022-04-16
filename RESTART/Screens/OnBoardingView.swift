//
//  OnBoardingView.swift
//  RESTART
//
//  Created by Zeyad Badawy on 14/04/2022.
//

import SwiftUI

struct OnBoardingView: View {
    @AppStorage("OnBoarding") var isOnbardingViewActive = true
    
    @State private var buttonWidth = UIScreen.main.bounds.width - 80
    @State private var buttonOffset:CGFloat = 0
    @State private var isAnimating: Bool = false
    @State private var imageOffset:CGSize = .zero
    @State private var indicatorOpacity:Double = 1.0
    @State private var textTitle:String = "Share."
    
    let hapticFeedBack = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            //MARK: BG VIEW
            Color("ColorBlue")
                .ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing:20) {
                Spacer()
                //MARK: HEADER
                VStack(spacing:0) {
                    Text(textTitle)
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .transition(.opacity)
                        .id(textTitle)
                    
                    Text("""
                    It's not how much we give but
                    how much love we put into giving.
                    """)
                    .font(.title3)
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal , 10 )
                } //: HEADER
                .opacity(isAnimating ? 1 : 0)
                .offset(y:isAnimating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                //MARK: CENTRE
                ZStack {
                    CircleGroupView(circleColor: .white, CircleOpacity: 0.2)
                        .offset(x: imageOffset.width * -1 )
                        .blur(radius: abs(imageOffset.width / 5))
                        .animation(.easeOut(duration: 1), value: imageOffset)
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimating ? 1 : 0)
                        .offset(x: imageOffset.width * 1.2, y: 0)
                        .rotationEffect(.degrees(Double(imageOffset.width / 20 )))
                        .animation(.easeOut(duration: 0.5) , value: isAnimating)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                        if abs(imageOffset.width ) <= 150 {
                                            imageOffset = gesture.translation
                                            indicatorOpacity = 0
                                            textTitle = "Give."
                                        }
                                })
                                .onEnded({ _ in
                                        imageOffset = .zero
                                        indicatorOpacity = 1
                                    textTitle = "Share."
                                })
                        )
                        .animation(.easeOut(duration: 1), value: imageOffset)
                }//: CENTRE
                .overlay(alignment: .bottom) {
                    Image(systemName: "arrow.left.and.right.circle")
                        .font(.system(size: 44, weight: .ultraLight))
                        .foregroundColor(.white)
                        .offset(y:20)
                        .opacity(isAnimating ? 1:0)
                        .animation(.easeOut(duration: 1).delay(2), value: isAnimating)
                        .opacity(indicatorOpacity)
                        .animation(.linear(duration: 0.5), value: indicatorOpacity)
                }
                Spacer()
                
                //MARK: BOTTOM
                ZStack {
                    //1: BG
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                        .padding(8)
 
                    Text("Get Started")
                        .font(.system(.title3 , design: .rounded))
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .offset(x:20)
                    
                    //2: red circle
                    
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                        .frame(width: buttonOffset + 80)
                        Spacer()
                    }
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .frame(width: 80, height: 80, alignment: .center)
                        .offset(x:buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged({ gesture in
                                    if gesture.translation.width > 0 && buttonOffset <= buttonWidth - 40 {
                                        buttonOffset = gesture.translation.width
                                    }
                                })
                                .onEnded({ _ in
                                    withAnimation(.easeOut(duration: 0.4)) {
                                        if buttonOffset >= buttonWidth/2 {
                                            hapticFeedBack.notificationOccurred(.success)
                                            playAudio(name: "chimeup", type: "mp3")
                                            buttonOffset = buttonWidth - 40
                                            isOnbardingViewActive = false
                                        }else {
                                            hapticFeedBack.notificationOccurred(.warning)
                                            buttonOffset =  0
                                        }
                                    }
                                })
                        )
                        Spacer()
                    }
                        
                } //: BOTTOM
                .frame(height: 80, alignment: .center)
                .padding()
                .opacity(isAnimating ? 1 : 0)
                .offset(y: isAnimating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimating)
                
                .onAppear {
                    isAnimating = true
                }
                
            }//: VStack
        }
        .preferredColorScheme(.dark)

    }
        
}

struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView()
    }
}
