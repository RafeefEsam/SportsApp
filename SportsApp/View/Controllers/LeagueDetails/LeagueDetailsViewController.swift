//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Rafeef Esam on 07/05/2023.
//

import UIKit
import SDWebImage

class LeagueDetailsViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    @IBOutlet weak var upComingCollection: UICollectionView!
    @IBOutlet weak var latestEventsCollection: UICollectionView!
    
    var nameOfsport : String?
    var idOfLeague: Int?
    var upComingList : [UpCommingEvent]?
    var latestEventsList : [LatestEvents]?
    var teamsList :[Teams]?
    override func viewDidLoad() {
        super.viewDidLoad()
        upComingCollection.layer.cornerRadius = 40
        teamsCollectionView.layer.cornerRadius = 40
        print("id is \(String(describing: idOfLeague))")
        
   
    }
    override func viewWillAppear(_ animated: Bool) {
        //checkIfThereIsNoEvents()
        let leagueDetailVM = LeagueDetailsViewModel()
        
        leagueDetailVM.getUpccoming(sportName: nameOfsport!, leagueId: idOfLeague!)
        leagueDetailVM.bindUpComingListToLeagueDetailsVC = { () in
            DispatchQueue.main.async {
                self.upComingList = leagueDetailVM.upComingList
                self.upComingCollection.reloadData()
            }
        }
        leagueDetailVM.getLastesEvent(sportName: nameOfsport!, leagueId: idOfLeague!)
        leagueDetailVM.bindLatestEventListToLeagueDetailsVC = { () in
            DispatchQueue.main.async {
                self.latestEventsList = leagueDetailVM.latestEventsList
                self.latestEventsCollection.reloadData()
            }
        }
        leagueDetailVM.getTeams(sportName: nameOfsport!, leagueId:idOfLeague!)
        leagueDetailVM.bindTeamsListToLeagueDetailsVC = { () in
            DispatchQueue.main.async {
                self.teamsList = leagueDetailVM.teamsList
                self.teamsCollectionView.reloadData()
            }
        }
        checkIfThereIsNoEvents()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.upComingCollection {
            return upComingList?.count ?? 0
        }else if collectionView == self.latestEventsCollection{
            return latestEventsList?.count ?? 0
        }
        return teamsList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.upComingCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "upComingCell", for: indexPath) as! UpComingCell
            
            cell.homeTeamLogo.sd_setImage(with: URL(string: upComingList![indexPath.row].home_team_logo ?? ""))
            cell.awayTeamLogo.sd_setImage(with: URL(string: upComingList![indexPath.row].away_team_logo ?? ""))
            cell.homeTeamName.text = upComingList![indexPath.row].event_home_team
            cell.awatTeamName.text = upComingList![indexPath.row].event_away_team
            cell.date.text = upComingList![indexPath.row].event_date
            cell.time.text = upComingList![indexPath.row].event_time
            return cell
        } else if collectionView == self.latestEventsCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "latestEventCell", for: indexPath) as! LatestEventCell
            cell.layer.borderColor = UIColor.blue.cgColor
            cell.layer.borderWidth = 1.5
            cell.layer.cornerRadius = 20
            cell.latestHomeImg.sd_setImage(with: URL(string: latestEventsList![indexPath.row].home_team_logo ?? ""))
            cell.latestAwayImg.sd_setImage(with: URL(string: latestEventsList![indexPath.row].away_team_logo ?? ""))
            cell.latestHomeName.text = latestEventsList![indexPath.row].event_home_team
            cell.latestAwayName.text = latestEventsList![indexPath.row].event_away_team
            cell.latestFinalScore.text = latestEventsList![indexPath.row].event_final_result
            cell.latestDate.text = latestEventsList![indexPath.row].event_date
            cell.latestTime.text = latestEventsList![indexPath.row].event_time
            return cell
            }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamsCell", for: indexPath) as! TeamsCell
        cell.teamImg.layer.cornerRadius = cell.teamImg.frame.width/1.9
        cell.teamImg.clipsToBounds = true
        cell.teamImg.layer.borderColor = UIColor.blue.cgColor
        cell.teamImg.layer.borderWidth = 1.5
        cell.teamImg.sd_setImage(with: URL(string: teamsList![indexPath.row].team_logo ?? ""))
        cell.teamName.text = teamsList![indexPath.row].team_name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.teamsCollectionView {
            return CGSize(width: collectionView.frame.width / 2, height: collectionView.frame.height )
        }
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height )
    }
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
       if collectionView == self.latestEventsCollection{
           return 3
       }
       return 0
       }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.teamsCollectionView {
            if !InternetCheker.isInternetAvailable(){
                self.showNoInternetAlert()
            }else{
                if nameOfsport == "basketball" || nameOfsport == "cricket"{
                    let alert = UIAlertController(title: nil, message: "Sorry, this team has no more information", preferredStyle: .alert)
                       let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                       alert.addAction(okAction)
                       present(alert, animated: true, completion: nil)
                }else{
                    let teamdetailsVC = self.storyboard?.instantiateViewController(withIdentifier: "teamDetailVC") as! TeamDetailsViewController
                    teamdetailsVC.passedTeam = teamsList![indexPath.row]
                    self.navigationController?.pushViewController(teamdetailsVC, animated: true)
                }
            }
           
        
        }
    }
    func checkIfThereIsNoEvents(){
       
        print("check************* \(upComingList?.count)")
        
        
        if self.upComingList?.count == 0 && self.latestEventsList?.count == 0 && teamsList?.count == 0{
            let alert = UIAlertController(title: nil, message: "Sorry, this league has no information right now", preferredStyle: .alert)
               let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
               alert.addAction(okAction)
               present(alert, animated: true, completion: nil)
        }
            
    }
}
