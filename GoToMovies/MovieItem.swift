//
//  MovieItem.swift
//  GoToMovies
//
//  Created by Jeremy Van on 1/26/19.
//  Copyright © 2019 Jeremy Van. All rights reserved.
//

import UIKit

struct MovieResult: Codable {
    let resultCount: Int
    let results: [MovieItem]
}


struct MovieItem: Codable {
    let trackName: String?
    let primaryGenreName: String?
    let releaseDate: String?
    let contentAdvisoryRating: String?
    let longDescription: String?
    let previewUrl: String?
    let hasITunesExtras: Bool?
}


