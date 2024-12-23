//
//  ProfileHeaderVM.swift
//  Gibigram
//
//  Created by Mert Ziya on 23.12.2024.
//

import RxSwift
import RxCocoa
import FirebaseAuth
import FirebaseFirestore

class ProfileHeaderVM {
    // Subject to emit user data
    private let userSubject = PublishSubject<User>()
    var userObservable: Observable<User> {
        return userSubject.asObservable()
    }
    
    // Dispose bag for RxSwift
    private let disposeBag = DisposeBag()
    
    init() {
        fetchUser()
    }
    
    private func fetchUser() {
        Self.fetchUser { [weak self] user in
            if let user = user {
                self?.userSubject.onNext(user)
            }
        }
    }
    
    // Fetch user method
    private static func fetchUser(completion: @escaping (User?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(nil)
            return
        }
        let userCollection = Firestore.firestore().collection("users")
        userCollection.document(uid).getDocument(as: User.self) { result in
            switch result {
            case .failure(let error):
                print("DEBUG: user cannot be fetched -> \(error.localizedDescription)")
                completion(nil)
            case .success(let user):
                completion(user)
            }
        }
    }
}
