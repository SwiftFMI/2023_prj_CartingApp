//
//  BottomBarView.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 18.02.24.
//

import Foundation
import SwiftUI

struct CartingTabView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab)  {
            CurrentUserProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .environment(\.symbolVariants, selectedTab == 0 ? .fill: .none)
                }
                .onAppear{ selectedTab = 0}.tag(0)
            
            ExploreView()
                            .tabItem {
                                Image(systemName: "magnifyingglass")
                            }.onAppear{ selectedTab = 1}.tag(1)
            
            CurrentUserProfileView()
                .tabItem {
                    Image(systemName: selectedTab == 2 ? "person.fill" : "person")
                        .environment(\.symbolVariants, selectedTab == 2 ? .fill: .none)
                }.onAppear{ selectedTab = 2}.tag(2)
        }
        .tint(.black)
    }
}

#Preview {
    CartingTabView()
}
