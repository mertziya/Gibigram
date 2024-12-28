//
//  StoriesCellForCollectionView.swift
//  Gibigram
//
//  Created by Mert Ziya on 24.12.2024.
//

import Foundation
import UIKit

class StoriesCellForCollectionView : UICollectionViewCell , UICollectionViewDelegate, UICollectionViewDataSource{
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    static let identifier = "soriesCellForCollectionViewReuseIdentifier"
    
    var stories :[Story] = []{
        didSet{
            print(stories.count)
            DispatchQueue.main.async{
                self.collectionView.reloadData()
            }
        }
    }
    
    var isOpened : Bool = false{
        didSet{
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // MARK: - Lifecycles:
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "StoryCell", bundle: nil), forCellWithReuseIdentifier: StoryCell.reuseIdentifier)
        
        configureCollection()
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 82, height: 81) // Example size
            layout.scrollDirection = .horizontal
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCollection(){
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 12),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCell.reuseIdentifier, for: indexPath) as? StoryCell else{
            print("DEBUG: Couldn't get the StoryCell")
            return UICollectionViewCell()
        }
        cell.storyImage.kf.setImage(with: URL(string: self.stories[indexPath.row].storyImageURL ?? ""))
        cell.storyName.text = self.stories[indexPath.row].storyName
        cell.storyBounds.image = self.isOpened ? .storyBoundOpened : .storyBounds
        
        return cell
    }
}

