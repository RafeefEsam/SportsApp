//
//  fetchLeaguesProtocol.swift
//  SportsApp
//
//  Created by Rafeef Esam on 11/05/2023.
//

import Foundation
protocol FetchLeaguesProtocol {
    static func getLeague(sportName: String , completionHandler: @escaping (LeagueRoot?) -> Void )
}
