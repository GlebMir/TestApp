//
//  ViewController.swift
//  TestApp_1
//
//  Created by Глеб Никитенко on 04.09.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit
import Kingfisher


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    var posts: [TAPost] = []
    var fetchingMore = false
    var currentPage = 1
    
    let collectionView: UICollectionView = {
          let layout = UICollectionViewFlowLayout()
          //layout.scrollDirection = .horizontal //Чтобы шли одна под другой
          layout.minimumLineSpacing = 30
          layout.minimumInteritemSpacing = 5
          let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
          cv.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "test")
          cv.contentInset = UIEdgeInsets(top: 25, left: 22, bottom: 15, right: 22)
          cv.isPagingEnabled = true
          cv.showsVerticalScrollIndicator = false
          cv.showsHorizontalScrollIndicator = false
          return cv
      }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
            
       view.addSubview(collectionView)
       setUpCollectionView()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    
        view.backgroundColor = .black
        getImages()
        
    }
    
    private func getImages() {
        ContentService.getImagesContent(page: currentPage) { [weak self] (posts, error) in
            guard let posts = posts else {return}
            self?.posts = posts
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            
        }
    }
    
   
    
    private func setUpCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "test", for: indexPath) as! CustomCollectionViewCell
        cell.backgroundColor = .blue
        cell.titleLabel.text = posts[indexPath.row].title
        if let imageString = posts[indexPath.row].images?.first?.link {
            cell.myimageView.kf.setImage(with: URL(string: imageString))
        }

        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           return CGSize(width: 140, height: 140)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let vc2 = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc2.imageString = posts[indexPath.row].images?.first?.link
        let id = posts[indexPath.row].id ?? ""
        vc2.postID = id
        self.navigationController?.pushViewController(vc2, animated: true)
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > (contentHeight - 100 - scrollView.frame.size.height) {
            print("FETCH DATA")
       }
        
    }
    
    
   
    
    
    
    

}




