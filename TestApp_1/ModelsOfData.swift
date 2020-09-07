//
//  ModelsOfData.swift
//  TestApp_1
//
//  Created by Глеб Никитенко on 06.09.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import Foundation

struct TAData: Codable {
    let data: [TAPost]
    let status: Int
    let success: Bool
}

struct TAPost: Codable {
    let id: String?
    let title: String?
    let images: [Images]?
}

struct Images: Codable {
    let link: String?
    let type: String?
    let id: String?
}


//Comment
struct CommentData: Codable {
    let data: [Comment]?
}

struct Comment: Codable {
    let image_id: String?
    let comment: String?
}
