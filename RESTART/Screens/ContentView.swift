//
//  ContentView.swift
//  RESTART
//
//  Created by Zeyad Badawy on 14/04/2022.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("OnBoarding") var isOnbardingViewActive = true
    
    var body: some View {
        ZStack {
            if isOnbardingViewActive {
                OnBoardingView()
            }else {
                HomeView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
