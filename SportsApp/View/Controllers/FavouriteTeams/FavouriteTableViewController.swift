//
//  FavouriteTableViewController.swift
//  SportsApp
//
//  Created by Rafeef Esam on 10/05/2023.
//

import UIKit
import SDWebImage
import Reachability
class FavouriteTableViewController: UITableViewController {

    var favouriteTeams : [Teams]?
    var favouriteViewModel : FavouriteViewModel?
    private var emptyListView : UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        favouriteViewModel = FavouriteViewModel()
        emptyListView = UIImageView()
       
     
    }
    override func viewWillAppear(_ animated: Bool) {
        addTitleForTableView()
        addImageIfEmptyList()
        favouriteViewModel?.getFavouriteTeams()
        DispatchQueue.main.async {
            self.favouriteTeams = self.favouriteViewModel?.favList
            print("favouriteList")
            self.tableView.reloadData()
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if favouriteTeams?.count == 0{
            emptyListView?.isHidden = false
        }
        return favouriteTeams?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favouriteCell", for: indexPath) as! FavouriteCell
        
        // Configure the cell...
        cell.favTeamImg.sd_setImage(with: URL(string: favouriteTeams![indexPath.row].team_logo ?? ""))
        cell.favTeamName.text = favouriteTeams![indexPath.row].team_name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !InternetCheker.isInternetAvailable() {
            self.showNoInternetAlert()
        }else{
            favouriteViewModel?.getTeamDetails(teamId: favouriteTeams![indexPath.row].team_key!)
            let teamdetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "teamDetailVC") as! TeamDetailsViewController
           favouriteViewModel?.bindTeamListToFavouriteTableViewController = {
                () in
                teamdetailsVC.passedTeam = self.favouriteViewModel?.teamDetail
               DispatchQueue.main.async {
                  
                   self.navigationController?.pushViewController(teamdetailsVC, animated: true)
               }
           }
        }
     
        
    }
    
    @IBAction func deleteTeam(_ sender: Any) {
        let buttonPosition = (sender as AnyObject).convert(CGPoint.zero, to: tableView)
        let indexPath = tableView.indexPathForRow(at: buttonPosition)
        let alert = UIAlertController(title: "Delete Team", message: "Are you sure you want to delete this team from favourite?", preferredStyle: .alert)
           
           // Add a "Delete" action
           alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
               // Handle deletion of item
               self.favouriteViewModel?.deleteTeam(team: self.favouriteTeams![indexPath!.row])
               self.favouriteViewModel?.getFavouriteTeams()
               DispatchQueue.main.async {
                   self.favouriteTeams = self.favouriteViewModel?.favList
                   print("favouriteList")
                   self.tableView.reloadData()
               }
             //  self.tableView.reloadData()
           }))
           
           // Add a "Cancel" action
           alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
           
           // Show the alert
           present(alert, animated: true)
                 // Call the delete method in the view model
   
    }
    
    func addImageIfEmptyList(){
        self.emptyListView?.image = UIImage(named: "noFavourit") // Set your desired image here
        emptyListView?.contentMode = .center
        emptyListView!.isHidden = true // Hide it initially

        // Add the image view as a subview
        tableView.addSubview(emptyListView!)
        emptyListView?.translatesAutoresizingMaskIntoConstraints = false
    
    }
    func addTitleForTableView(){
        let titleLabel = UILabel()
        titleLabel.text = "Favourite Teams"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.sizeToFit()

        tableView.tableHeaderView = titleLabel
    }

}
