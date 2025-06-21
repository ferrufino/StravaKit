//
//  StravaService.swift
//
//
//  Created by Gustavo Ferrufino on 2024-12-14.
//

import Foundation

/// Business logic processing for Strava API
public final class StravaService {
    private let repository: StravaRepository
    private let authManager: StravaAuthManager
    
    // MARK: Request Methods
    /// Initialize with a repository
    public init(repository: StravaRepository, authManager: StravaAuthManager) {
        self.repository = repository
        self.authManager = authManager
    }
    
    /// Fetch Athlete personal info
    public func fetchAthlete() async throws -> Athlete {
        let token = try await authManager.getValidToken()
        return try await repository.fetchAthlete(token: token)
    }
    
    /// Fetch Athlete zones
    public func fetchAthleteZones() async throws -> AthleteZone {
        let token = try await authManager.getValidToken()
        return try await repository.fetchAthleteZones(token: token)
    }

    /// Fetch all activities
    public func fetchActivities(page: Int = 1, perPage: Int = 30) async throws -> [Activity] {
        let token = try await authManager.getValidToken()
        return try await repository.fetchAllActivities(token: token, page: page, perPage: perPage)
    }

    /// Fetch all saved routes
    public func fetchSavedRoutes(page: Int = 1, perPage: Int = 30) async throws -> [Route] {
        let token = try await authManager.getValidToken()
        return try await repository.fetchSavedRoutes(token: token, page: page, perPage: perPage)
    }
    /// Fetch an activity stream
    public func fetchActivityStream(activityId: String, streamTypes: [StreamType]) async throws -> ActivityStreamResponse {
        let token = try await authManager.getValidToken()
        return try await repository.fetchActivityStream(activityId: activityId, token: token, streamTypes: streamTypes)
    }
    /// Fetch a route stream
    public func fetchRouteStream(routeId: String) async throws -> RouteStreamResponse {
        let token = try await authManager.getValidToken()
        return try await repository.fetchRouteStream(routeId: routeId, token: token)
    }
    
    public func fetchRoute(routeId: String) async throws -> Route {
        let token = try await authManager.getValidToken()
        return try await repository.fetchRoute(routeId: routeId, token: token)
    }
    
    // MARK: Autentication Methods
    public func login() async throws {
        try await authManager.authorize()
    }
    
    public func logout() async throws {
        try await authManager.deauthorize()
    }
    
    public func handleAuthResponse(url: URL) async throws -> OAuthToken {
        return try await authManager.handleAuthResponse(url: url)
    }
    
    public func isAuthenticated() async -> Bool {
        return await authManager.authenticated()
    }
}
