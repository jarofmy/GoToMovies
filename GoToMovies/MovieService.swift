//
//  MovieService.swift
//  GoToMovies
//
//  Created by Jeremy Van on 1/26/19.
//  Copyright © 2019 Jeremy Van. All rights reserved.
//

import UIKit

class MovieService {
    
    var dataTask: URLSessionDataTask?
    
    private let urlString = "https://itunes.apple.com/search?country=US&media=movie&limit=20&term="
    
    func search(for searchTerm: String, completion: @escaping ([MovieItem]?, Error?) -> ()) {
        
        guard let url = URL(string: urlString + searchTerm) else {
            print("invalid url: \(urlString + searchTerm)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                DispatchQueue.main.async { completion(nil, error) }
                return
            }
            
            print("Status code: \(response.statusCode)")
            print(String(data: data, encoding: .utf8) ?? "unable to print data")
            
            do {
                let decoder = JSONDecoder()
                let movieResult = try decoder.decode(MovieResult.self, from: data)
                DispatchQueue.main.async { completion(movieResult.results, nil) }
            } catch (let error) {
                
                DispatchQueue.main.async { completion(nil, error) }
                
            }
        }
        task.resume()
    }
}
