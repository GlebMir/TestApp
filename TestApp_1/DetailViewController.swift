//
//  DetailViewController.swift
//  TestApp_1
//
//  Created by Глеб Никитенко on 05.09.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var imageString: String?
    var comments: [Comment] = []
    var postID: String?
    
    let mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .green
        return iv
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "comment")
        //tv.showsVerticalScrollIndicator = false
        tv.backgroundColor = .green
        return tv
    }()
    
    private let commentsLabel: UILabel = {
        let label = UILabel()
        label.text = "Комментарии"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        return label
    }()
    
    private let lineView: UIView = {
        let line = UIView()
        line.backgroundColor = .black
        return line
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(mainImageView)
        setupImageView()
        mainImageView.kf.setImage(with: URL(string: imageString ?? "image1"))
        
        view.addSubview(tableView)
        setupTableView()
        
        view.addSubview(commentsLabel)
        setupCommentsLabel()
        
        view.addSubview(lineView)
        setupLineView()
        
        
       getComments()
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func getComments() {
        ContentService.GetCommets(postID: postID ?? "") { [weak self] (comments, error) in
            guard let commt = comments else {return}
            self?.comments = commt
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "comment", for: indexPath)
        cell.textLabel?.text = comments[indexPath.row].comment
        return cell
    }

    
    private func setupImageView() {
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        mainImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        mainImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        mainImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        mainImageView.heightAnchor.constraint(equalToConstant: 220).isActive = true
    }
    
    
    //Разместить tableView
    private func setupTableView(){
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 50).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    private func setupCommentsLabel() {
        commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        commentsLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        commentsLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        commentsLabel.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 5).isActive = true
        commentsLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    private func setupLineView() {
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        lineView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -40).isActive = true
        lineView.topAnchor.constraint(equalTo: commentsLabel.bottomAnchor, constant: 3).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    

}
