//
//  AthleteZone.swift
//  StravaKit
//
//  Created by Gustavo Ferrufino on 2025-06-19.
//

import Foundation

public struct AthleteZone: Codable {
    public let heartRate: ZoneCategory // These are the classic 5‑zone HR model used for any sport involving effort—running, cycling, etc.
    public let power:     ZoneCategory
    
    public enum CodingKeys: String, CodingKey {
        case heartRate = "heart_rate"
        case power
    }
}

public struct ZoneCategory: Codable {
    public let customZones: Bool?
    public let zones:       [ZoneRange]
    
    enum CodingKeys: String, CodingKey {
        case customZones = "custom_zones"
        case zones
    }
}

public struct ZoneRange: Codable {
  public let min: Int?
  public let max: Int?
}
