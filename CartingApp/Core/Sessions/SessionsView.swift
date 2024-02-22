//
//  SessionsView.swift
//  CartingApp
//
//  Created by Kristian Yodanov on 21.02.24.
//

import Foundation
import SwiftUI

struct SessionsView: View{
    
    @StateObject var viewModel = SessionsViewModel()
    
    var body: some View{
        NavigationStack{
            ScrollView{
                LazyVStack{
                    ForEach (viewModel.sessions){ session in
                        NavigationLink (value:session){
                            VStack {
                                Text("must be som")
                                Divider()

                            }
                            .padding(.vertical,4)
                        }
                    }
                }
            }
            .navigationTitle("Sessions")
        }
    }
}

#Preview {
    SessionsView()
}
