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
                    ForEach (viewModel.sessionElements){ session in
//                        NavigationLink (value:session){
                        Text("Date: \(formatDate(session.startTime))")
                            HStack {
                                Text("\(1)")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                    .frame(width: 30, alignment: .leading)

                                VStack(alignment: .leading) {
                                    Text(String(session.username))
                                        .font(.headline)

                                    HStack{
                                        Text("Best lap: ").font(.subheadline)
                                        Text(String(format: "%.3f", session.lapTime))
                                            .font(.subheadline)
                                    }
                                }

                                Spacer()
                            }
                            .padding(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                        }
                    }
//                }
            }
            .navigationTitle("Sessions")
        }
    }
    private func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }

}

#Preview {
    SessionsView()
}
