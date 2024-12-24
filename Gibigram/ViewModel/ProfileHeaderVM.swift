//
//  ProfileHeaderVM.swift
//  Gibigram
//
//  Created by Mert Ziya on 23.12.2024.
//


import FirebaseAuth
import FirebaseFirestore
import Combine

class ProfileHeaderVM {
    @Published var user: User?
    @Published var isLoading: Bool = false
    private var cancellable = Set<AnyCancellable>()
    private var listener: ListenerRegistration?
    
    init() {
        fetchUser()
    }
    
    func updateUser(){
        fetchUser()
    }
    
    func fetchUser(){
        isLoading = true
    
        UserService.fetchUser()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                switch completion{
                case .finished: break // succesfully finished
                case .failure(let error): print("DEBUG: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] user in
                self?.user = user
            })
            .store(in: &cancellable)
    }
    
  
}
