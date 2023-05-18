//
//  FetchLatestEventsProtocol.swift
//  SportsApp
//
//  Created by Rafeef Esam on 11/05/2023.
//

import Foundation
protocol FetchLatestEventsProtocol {
    static func getLatestEvents(sportName: String ,leagueId: Int , completionHandler: @escaping (LatestEventRoot?) -> Void )
}
