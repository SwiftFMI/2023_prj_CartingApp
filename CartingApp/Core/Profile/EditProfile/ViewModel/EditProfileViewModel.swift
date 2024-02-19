//
//  EditProfileViewModel.swift
//  CartingApp
//
//  Created by Stoyan Tinchev on 18.02.24.
//

import Foundation
import Combine
import PhotosUI
import SwiftUI

class EditProfileViewModel: ObservableObject{
    @Published var currentUser: User?
    @Published var newNickname = ""

    @Published var selectedItem: PhotosPickerItem?{
        didSet { Task {await loadImage() }}
    }
    @Published var profileImage: Image?
    
    private var uiImage: UIImage?
    
    private var cancelables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers(){
        UserService.shared.$currentUser.sink { [weak self] user in
            self?.currentUser = user
//            print("Debug: User in view model from combine is \(user)")
        }.store( in: &cancelables )
    }
    
    func updateUerData() async throws{
        try await updateProfileImage()
        try await updateUserNickname()
    }
    
    @MainActor
    private func loadImage() async {
        guard let item = selectedItem else {return}
        guard let data = try? await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: data) else {return}
        self.uiImage = uiImage
        self.profileImage = Image(uiImage: uiImage)
    }
    
    private func updateProfileImage() async throws {
        guard let image = self.uiImage else {return}
        guard let imageUrl = try? await ImageUploader.uploadImage(image) else {return}
        try await UserService.shared.updateUserProfileImage(withImageUrl: imageUrl)
        
    }
    
    @MainActor
    func updateUserNickname() async throws {
        if newNickname.isEmpty {return}
        try await UserService.shared.updateUserNickname(newNickname: newNickname)
    }

    func sendPasswordResetEmail() async throws {
        guard let email = currentUser?.email else {return}
        try await UserService.shared.sendPasswordResetEmail(email: email)
    }
}
