//
//  ContentService.swift
//  TestApp_1
//
//  Created by Глеб Никитенко on 06.09.2020.
//  Copyright © 2020 Gleb Nikitenko. All rights reserved.
//

import Foundation

class ContentService {
    
    enum ContentType: String {
        case jpegPhoto = "image/jpeg"
        case pngPhoto = "image/png"
    }
    
    static func getImagesContent(page: Int, handler: @escaping ([TAPost]?, Error?) -> Void)  {
        guard let url = URL(string: "https://api.imgur.com/3/gallery/top/viral/\(page)/") else {return}
                var request = URLRequest(url: url)
                request.setValue("Client-ID ecb21469998c4bf", forHTTPHeaderField: "Authorization")
                
                URLSession.shared.dataTask(with: request) { (data, response, error) in
            
                    guard let data = data else {return}
                    
                        do {
                            let taData = try JSONDecoder().decode(TAData.self, from: data)
                            let result: [TAPost] = taData.data.reduce([]) { (result, post) -> [TAPost] in
                                let isCorrectType = post.images?.contains(where: { (image) -> Bool in
                                    return (image.type == ContentType.jpegPhoto.rawValue) || (image.type == ContentType.pngPhoto.rawValue)
                                })
                                if (isCorrectType ?? false) {
                                    return result + [post]
                                }
                                return result
                            }
                            
                            handler(result, nil)
                        } catch let error {
                            handler(nil, error)
                        }
                        
                    
                
                }.resume()
                
                
    }
    
    
    //Get comment
    static func GetCommets(postID: String, handler: @escaping ([Comment]?, Error?) -> Void) {
        guard let url = URL(string: "https://api.imgur.com/3/gallery/\(postID)/comments/top") else {return}
        var request = URLRequest(url: url)
        request.setValue("Client-ID ecb21469998c4bf", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) {(data, response, error) in
        guard let data = data else {return}
            do{
                let commData = try JSONDecoder().decode(CommentData.self, from: data)
                let comments = commData.data
                handler(comments, nil)
            }catch let error{
                handler(nil, error)
            }
        }.resume()
        
    }
    
    
    
}
