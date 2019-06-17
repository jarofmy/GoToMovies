//
//  ChicagoTableViewController.swift
//  GoToMovies
//
//  Created by Jeremy Van on 1/25/19.
//  Copyright © 2019 Jeremy Van. All rights reserved.
//

import UIKit

class ChicagoTableViewController: UITableViewController {

    var movieItems: [MovieItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refreshTable), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        
        let movieService = MovieService()
        movieService.search(for: "chicago", completion: { movies, error in
            guard let movies = movies, error == nil else {
                print(error ?? "unknown error")
                return
            }
            self.movieItems = movies
            self.tableView.reloadData()
        })

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func refreshTable(_ sender: Any) {
        let movieService = MovieService()
        movieService.search(for: "chicago", completion: { movies, error in
            guard let movies = movies, error == nil else {
                print(error ?? "unknown error")
                return
            }
            self.movieItems = movies
            print(self.movieItems)
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return movieItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }

//         Configure the cell...
        let movie = movieItems[indexPath.row]
        cell.movieTitleLabel.text = movie.trackName
        cell.movieGenreLabel.text = movie.primaryGenreName
        
        let movieImageString = movie.hasITunesExtras == true ? "popcorn" : "ticket"
        if let imageObj = UIImage(named: movieImageString) {
            cell.movieImageView.image = imageObj
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard let movieDetailViewController = segue.destination as? MovieDetailViewController else { return }
        guard let selectedTableViewCell = sender as? MovieTableViewCell else { return }
        guard let selectedIndexPath = tableView.indexPath(for: selectedTableViewCell) else { return }
        
        let movie = movieItems[selectedIndexPath.row]
        movieDetailViewController.movie = movie
    }

}
