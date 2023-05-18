//
//  LeagueTableViewController.swift
//  SportsApp
//
//  Created by Rafeef Esam on 06/05/2023.
//

import UIKit
import SDWebImage

class LeagueTableViewController: UITableViewController {

    var leagueList : [League]?
    var sportName : String?
    var leagueViewModel : LeagueViewModel?
    var placeHolderImg : UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Leagues"
        let backButton = UIBarButtonItem()
        backButton.title = "home"
        navigationController!.navigationBar.topItem?.backBarButtonItem = backButton
        leagueViewModel = LeagueViewModel()
        leagueViewModel?.getLeagues(sportName: sportName!)
        leagueViewModel?.bindListToLeagueTableViewController = { () in
            DispatchQueue.main.async {
                self.leagueList = self.leagueViewModel?.leagueList
                self.tableView.reloadData()
            }
            
        }
      
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return leagueList?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueCell
        
        // Configure the cell...
        switch sportName {
        case SportName.FootBall.rawValue:
            placeHolderImg = UIImage(named: "FootBall")
        case SportName.BasketBall.rawValue :
            placeHolderImg = UIImage(named: "BasketBall")
        case SportName.Cricket.rawValue :
            placeHolderImg = UIImage(named: "Cricket")
        default:
            placeHolderImg = UIImage(named: "Tennis")
            
        }
      
        cell.leagueLogo.sd_setImage(with: URL(string:(leagueList![indexPath.row].league_logo ?? "")),
                                    placeholderImage: placeHolderImg)
        cell.leagueLogo.layer.cornerRadius = cell.leagueLogo.frame.width/2.17
        cell.leagueLogo.clipsToBounds = true
        cell.leagueLogo.layer.borderColor = UIColor.blue.cgColor
        cell.leagueLogo.layer.borderWidth = 1.5
        cell.leagueName.text = leagueList![indexPath.row].league_name
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !InternetCheker.isInternetAvailable(){
            self.showNoInternetAlert()
        }else{
           /* if sportName == "tennis"{
                let alert = UIAlertController(title: nil, message: "Sorry, this league has no information right now", preferredStyle: .alert)
                   let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                   alert.addAction(okAction)
                   present(alert, animated: true, completion: nil)
            }else{*/
                let leaguedetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "leagueDetailsVC") as! LeagueDetailsViewController
                leaguedetailsVC.nameOfsport = sportName
                leaguedetailsVC.idOfLeague = leagueList![indexPath.row].league_key
                   self.navigationController?.pushViewController(leaguedetailsVC, animated: true)
            }
      //  }
       
      
    }

}
