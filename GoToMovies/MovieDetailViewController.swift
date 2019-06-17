//
//  MovieDetailViewController.swift
//  GoToMovies
//
//  Created by Jeremy Van on 1/26/19.
//  Copyright © 2019 Jeremy Van. All rights reserved.
//

import UIKit
import SafariServices

class MovieDetailViewController: UIViewController {
    
    let formatter = DateFormatter()
    var movie: MovieItem!
    
    @IBOutlet weak var detailMovieTitleLabel: UILabel! {
        didSet {
            detailMovieTitleLabel.text = movie.trackName
        }
    }
    @IBOutlet weak var detailGenreLabel: UILabel! {
        didSet {
            detailGenreLabel.text = "Genre: \(movie.primaryGenreName!)"
        }
    }
    @IBOutlet weak var detailRatingLabel: UILabel! {
        didSet {
            detailRatingLabel.text = "Rating: \(movie.contentAdvisoryRating!)"
        }
    }
    @IBOutlet weak var detailReleaseLabel: UILabel!{
        didSet {
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
            
            guard let dateObject = formatter.date(from: movie.releaseDate!) else { return }
            formatter.dateStyle = .medium
            
            detailReleaseLabel.text = "Released: \(formatter.string(from: dateObject))"
        }
    }
    
    @IBOutlet weak var detailImageView: UIImageView! {
        didSet {
            let movieImageString = movie.hasITunesExtras == true ? "popcorn" : "ticket"
            if let imageObj = UIImage(named: movieImageString) {
                detailImageView.image = imageObj
            }
        }
    }
    @IBOutlet weak var detailTextView: UITextView! {
        didSet {
            detailTextView.text = movie.longDescription
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = movie.trackName
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(buttonTapped(sender:)))
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonTapped(sender: UIBarButtonItem!) {
        _ = sender as UIBarButtonItem
        guard let previewURL = movie.previewUrl, let urlCheck = URL(string: previewURL) else {
            print("No preview for \(String(describing: movie.trackName))")
            return
        }
        let vc = SFSafariViewController(url: urlCheck)
        present(vc, animated: true)
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
