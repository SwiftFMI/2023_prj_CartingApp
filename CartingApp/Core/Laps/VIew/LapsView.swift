//
//  LapsView.swift
//  CartingApp
//
//  Created by Kristian Yodanov on 23.02.24.
//

import Foundation
import SwiftUI

struct LapsView: View {
    let userId: String
    let sessionId: String
    
    @State var laps: [Lap] = []
    
    var body: some View {
        ZStack {
            VStack {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            HStack(alignment: .center) {
                                Image(systemName: "flag.checkered.2.crossed")
                                    .font(.title2)
                                    .frame(alignment: .center)
                                Text("Laps")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .frame(alignment: .center)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.top, 10)
                            Divider()
                            if laps.isEmpty {
                                Text("Don't have any sessions yet")
                                    .multilineTextAlignment(.center)
                                    .padding()
                                    .foregroundColor(.gray)
                            } else {
                                ForEach(laps, id: \.self){lap in
                                    LapEntry(lap:lap)
                                        .frame(width: 350)
                                }
                                
                            }
                        }
                        .padding(.bottom, 10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 10)
                    .padding()
                }
            }
            .onAppear {
                Task{
                    do{
                        let result = try await LapService.shared.fetchLapsInSessionForSpecificUser(sessionId: self.sessionId, userId: self.userId)
                        DispatchQueue.main.async {
                            laps = result
                        }
                    } catch {
                        DispatchQueue.main.async {
                            print("Error fetching last session: \(error.localizedDescription)")
                        }
                    }
                    }
            }
    }
}
