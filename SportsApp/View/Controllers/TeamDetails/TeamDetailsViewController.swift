//
//  TeamDetailsViewController.swift
//  SportsApp
//
//  Created by Rafeef Esam on 09/05/2023.
//

import UIKit
import SDWebImage
import Toast_Swift
class TeamDetailsViewController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    @IBOutlet weak var isfavTeam: UIButton!
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var teamImg: UIImageView!
    
    var passedTeam : Teams?
    var playersList : [Player]?
    var teamDetailsViewModel: TeamDetailsViewModel?
    //var isTeamFav : Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        teamDetailsViewModel = TeamDetailsViewModel()
        self.navigationItem.title = "Team Details"
        let backButton = UIBarButtonItem()
        backButton.title = "league details"
        navigationController!.navigationBar.topItem?.backBarButtonItem = backButton
        playersList = passedTeam?.players
        teamName.text = passedTeam?.team_name
        teamImg.sd_setImage(with: URL(string: passedTeam?.team_logo ?? ""))
        coachName.text = "Coach: \((passedTeam?.coaches![0].coach_name)!)"
        updateFavouriteButton()
        // Do any additional setup after loading the view.
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playersList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as! PlayerCell
        cell.layer.cornerRadius = 20
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.borderWidth = 1
        cell.playerImg.sd_setImage(with: URL(string: playersList![indexPath.row].player_image ?? ""))
        cell.playerName.text = playersList![indexPath.row].player_name
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 2.07, height: collectionView.frame.height)
    }
    
    @IBAction func addOrRemoveFromFavourite(_ sender: Any) {
        if teamDetailsViewModel?.isFavouriteTeam(team: passedTeam) == false{
            teamDetailsViewModel?.saveToCoreData(team: passedTeam)
            updateFavouriteButton()
          //  self.view.reloadInputViews()
            self.view.makeToast("added to favourite successfully", position: .bottom)
           // self.view.showToast("added to favourite successfully")
        }else{
            let alert = UIAlertController(title: "Delete Team", message: "Are you sure you want to delete this team from favourite?", preferredStyle: .alert)
               
               // Add a "Delete" action
               alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                   // Handle deletion of item
                   self.teamDetailsViewModel?.deleteFromCoreData(team: self.passedTeam)
                   self.updateFavouriteButton()
               }))
               
               // Add a "Cancel" action
               alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
               
               // Show the alert
               present(alert, animated: true)
        }
    }
    func updateFavouriteButton(){
        if teamDetailsViewModel?.isFavouriteTeam(team: passedTeam) == true{
            isfavTeam.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            isfavTeam.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
}
