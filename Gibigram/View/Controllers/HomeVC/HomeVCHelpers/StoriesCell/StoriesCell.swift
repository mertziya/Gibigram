//
//  StoriesCell.swift
//  Gibigram
//
//  Created by Mert Ziya on 20.12.2024.
//

import UIKit


protocol presentStoryDelegate: AnyObject{
    func didOpenStory(vc : UIViewController)
}


class StoriesCell: UITableViewCell {
    // MARK: - UI Components:
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties:
    var viewmodel = StoryCellVM()
    var stories : [Story]?
    
    weak var delegate : presentStoryDelegate?
    
    // MARK: - Lifecycles:
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        viewmodel.delegate = self
        viewmodel.fetchStoriesOfFollowedUser()
        
        collectionView.register(UINib(nibName: "StoryCell", bundle: nil), forCellWithReuseIdentifier: StoryCell.reuseIdentifier)
        collectionView.alwaysBounceHorizontal = true

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 82, height: 81) // Example size
            layout.scrollDirection = .horizontal
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}


extension StoriesCell : UICollectionViewDataSource, UICollectionViewDelegate, StoryCellVMDelegate {
    func didFetchStories(stories: [Story]?) {
        DispatchQueue.main.async{
            self.stories = stories
            self.collectionView.reloadData()
        }
    }
    
    func didFailWithError(error: any Error) {
        print("ERROR")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.stories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCell.reuseIdentifier, for: indexPath) as? StoryCell else{
            print("DEBUG: Couldn't get the StoryCell")
            return UICollectionViewCell()
        }
        guard let urlString = self.stories![indexPath.row].storyImageURL else{ return UICollectionViewCell()}
        let url = URL(string: urlString)
        cell.storyImage.kf.setImage(with: url)
        cell.storyName.text = self.stories![indexPath.row].storyDescription
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = StoryVC()
        vc.story = self.stories?[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.delegate?.didOpenStory(vc: vc)
    }
}

