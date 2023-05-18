//
//  FetchUpcommingEventsProtocol.swift
//  SportsApp
//
//  Created by Rafeef Esam on 11/05/2023.
//

import Foundation
protocol FetchUpComingEventsProtocol {
    static func getUpComingEvents(sportName: String ,leagueId: Int , completionHandler: @escaping (UpComingRoot?) -> Void )
}
