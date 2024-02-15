//
//  Text.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 15.02.24.
//

import Foundation
import SwiftUI

struct ThreadsTextViewModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .padding(12)
            .font(.subheadline)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
}

struct ThreadsButtonViewModifier: ViewModifier{
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundStyle(Color.white)
            .frame(width: 352, height: 44)
            .background(.black)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
