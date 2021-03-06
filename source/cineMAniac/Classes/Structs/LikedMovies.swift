//
//  LikedMovies.swift
//  cineMAniac
//
//  Created by Glny Gl on 17.09.2018.
//  Copyright © 2018 Glny Gl. All rights reserved.
//

import Foundation

struct LikedMovies: Codable {
    
    static var shared = LikedMovies()
    
    var likedMovies: [PopMovResults] = []
    
    func isLiked(movie: PopMovResults) -> Bool{
        
        if likedMovies.contains(where: {$0.id == movie.id}) {
            return true
        } else {
            return false
        }
    }
    
    mutating func like(movie: PopMovResults){
        
        if isLiked(movie: movie){
            return
        }
        likedMovies.append(movie)
        saveLikedMovies()
    }
    
    mutating func unlike(movie: PopMovResults){
        
        if !isLiked(movie: movie){
            return
        }
        likedMovies = likedMovies.filter {$0.id != movie.id}
        saveLikedMovies()
    }
    
    func arrayToString(array: [PopMovResults]) -> String {
        
        let encoder = JSONEncoder()
        if let jsonData: Data = try? encoder.encode(array) {
            let dataString = String(data: jsonData, encoding: String.Encoding.utf8)
            return dataString!
        }
        return ""
    }
    
    func stringToArray(string: String) -> [PopMovResults] {
        
        let decoder = JSONDecoder()
        if let data = string.data(using: .utf8) {
            let jData = try? decoder.decode([PopMovResults].self, from: data)
            return jData ?? []
        }
        
        return []
    }
  

    
    func saveLikedMovies(){
        let string =  arrayToString(array: likedMovies)
        UserDefaults.standard.set(string, forKey: "SavedMovies")
    }
    
    mutating func loadLikedMovies(){
        if let string = UserDefaults.standard.object(forKey: "SavedMovies") as? String {
            
            let array = self.stringToArray(string: string)
            self.likedMovies = array
        }
    }
}
