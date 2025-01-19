//
//  Route.swift
//
//
//  Created by Gustavo Ferrufino on 2024-12-05.
//

import Foundation
import CoreLocation

/// Represents a saved route in Strava
public struct Route: Codable, Identifiable, Hashable {
    public let id: Int
    public let name: String?
    public let description: String?
    public let distance: Double
    public let elevationGain: Double
    public let type: Int // Route type (e.g., "ride", "run")
    public let map: Map?

    enum CodingKeys: String, CodingKey {
        case id, name, description, distance
        case elevationGain = "elevation_gain"
        case type = "type"
        case map
    }
    
    public static func == (lhs: Route, rhs: Route) -> Bool {
        lhs.id == rhs.id
    }
}

extension Route {
    
    public var stravaId: String {
        return id.description
    }
    // Route only fills summaryPolyline
    public func decodePolyline() -> [CLLocationCoordinate2D]? {
        guard let polyline = map?.summaryPolyline else { return nil }
        var coordinates: [CLLocationCoordinate2D] = []
        var index = polyline.startIndex
        let end = polyline.endIndex
        var lat = 0
        var lng = 0

        while index < end {
            var byte = 0
            var shift = 0
            var result = 0
            repeat {
                byte = Int(polyline[index].asciiValue! - 63)
                index = polyline.index(after: index)
                result |= (byte & 0x1F) << shift
                shift += 5
            } while byte >= 0x20
            let deltaLat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1))
            lat += deltaLat

            shift = 0
            result = 0
            repeat {
                byte = Int(polyline[index].asciiValue! - 63)
                index = polyline.index(after: index)
                result |= (byte & 0x1F) << shift
                shift += 5
            } while byte >= 0x20
            let deltaLng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1))
            lng += deltaLng

            coordinates.append(CLLocationCoordinate2D(latitude: Double(lat) / 1E5, longitude: Double(lng) / 1E5))
        }

        return coordinates
    }
    
    public var typeIconName: String {
        switch type {
        case 1: // Ride
            return "figure.outdoor.cycle"
        case 2: // Run
            return "figure.run"
        case 3: // Swim
            return "figure.swim"
        case 4: // Hike
            return "figure.hiking"
        case 5: // Walk
            return "figure.walk"
        case 6: // Alpine Ski
            return "figure.skiing.downhill"
        case 7: // Backcountry Ski
            return "figure.skiing.crosscountry"
        case 8: // Nordic Ski
            return "figure.skiing.crosscountry"
        case 9: // Snowboard
            return "figure.snowboarding"
        case 10: // Snowshoe
            return "figure.snowshoeing"
        case 11: // Wheelchair
            return "figure.roll"
        case 12: // E-Bike Ride
            return "bicycle"
        case 13: // Virtual Ride
            return "laptopcomputer.and.bicycle"
        case 14: // Virtual Run
            return "laptopcomputer.and.figure.run"
        case 15: // Canoeing
            return "figure.rower"
        case 16: // Kayaking
            return "figure.rower"
        case 17: // Rowing
            return "figure.rower"
        case 18: // Stand Up Paddling
            return "figure.stand.line.dotted.figure.stand"
        case 19: // Surfing
            return "figure.surfing"
        case 20: // Rock Climbing
            return "figure.climbing"
        case 21: // Ice Skate
            return "figure.ice.skate"
        case 22: // Inline Skate
            return "figure.inline.skate"
        default:
            return "figure.dance"
        }
    }
}
