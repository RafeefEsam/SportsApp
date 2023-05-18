//
//  NetworkServices.swift
//  SportsApp
//
//  Created by Rafeef Esam on 06/05/2023.
//

import Foundation
class NetworkService : NetworkServicesProtocol {
    
    static func getLeague(sportName: String, completionHandler: @escaping (LeagueRoot?) -> Void ) {
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sportName)/?met=Leagues&APIkey=9ebf316812c4ea1a061205bef2c843b77f92a8c8e9720cfd2b643ba350fc3617")
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(LeagueRoot.self, from: data!)
                completionHandler(result)
            }catch let error{
                print(error.localizedDescription)
                completionHandler(nil)
            }
        
        }
        task.resume()
    }
    
    static func getUpComingEvents(sportName: String, leagueId: Int, completionHandler: @escaping (UpComingRoot?) -> Void) {
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&leagueId=\(leagueId)&from=2023-05-09&to=2024-02-09&APIkey=9ebf316812c4ea1a061205bef2c843b77f92a8c8e9720cfd2b643ba350fc3617")
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(UpComingRoot.self, from: data!)
                completionHandler(result)
            }catch let error{
                print(error.localizedDescription)
                completionHandler(nil)
            }
            
        }
        task.resume()
    }
    
    static func getLatestEvents(sportName: String, leagueId: Int, completionHandler: @escaping (LatestEventRoot?) -> Void) {
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sportName)/?met=Fixtures&leagueId=\(leagueId)&from=2023-04-09&to=2024-02-09&APIkey=9ebf316812c4ea1a061205bef2c843b77f92a8c8e9720cfd2b643ba350fc3617")
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(LatestEventRoot.self, from: data!)
                completionHandler(result)
            }catch let error{
                print(error.localizedDescription)
                completionHandler(nil)
            }
            
        }
        task.resume()
    }
    
    static func getTeams(sportName: String, leagueId: Int, completionHandler: @escaping (TeamsRoot?) -> Void) {
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sportName)/?met=Teams&?met=Leagues&leagueId=\(leagueId)&APIkey=9ebf316812c4ea1a061205bef2c843b77f92a8c8e9720cfd2b643ba350fc3617")
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(TeamsRoot.self, from: data!)
                completionHandler(result)
            }catch let error{
                print(error.localizedDescription)
                completionHandler(nil)
            }
            
        }
        task.resume()
    }
    
    static func getTeamDetails(teamId: Int , completionHandler: @escaping (TeamsRoot?) -> Void ){
        let url = URL(string: "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=\(teamId)&APIkey=9ebf316812c4ea1a061205bef2c843b77f92a8c8e9720cfd2b643ba350fc3617")
        guard let newUrl = url else {
            return
        }
        let request = URLRequest(url: newUrl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ data,response , error in
            do{
                let result = try JSONDecoder().decode(TeamsRoot.self, from: data!)
                completionHandler(result)
            }catch let error{
                print(error.localizedDescription)
                completionHandler(nil)
            }
            
        }
        task.resume()
    }
}
