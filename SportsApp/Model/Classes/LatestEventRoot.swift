//
//  LatestEventRoot.swift
//  SportsApp
//
//  Created by Rafeef Esam on 07/05/2023.
//

import Foundation
class LatestEventRoot : Decodable {
    var success : Int?
    var result : [LatestEvents]
}
