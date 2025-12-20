//
//  EventAPI.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//
import Foundation

enum EventAPI {
    case login(email: String, password: String)
    case register(email: String) //TODO: რა ველებიც გჭირდება რეგისტრაციისთვის
    case me

    case getEvents(filters: [String: Any]?)
    case getEventDetails(id: Int)
    case getEventTypes

    case registerForEvent(eventId: Int, userId: Int)
    case cancelRegistration(id: Int)
    case myEvents(userId: Int)

    case notifications
}

extension EventAPI: Endpoint {
    
    var baseURL: URL {
        guard let url = URL(string: "") else {  /* TODO: API-ის ჩაისვას */
            fatalError("Invalid base URL")
        }
        return url
    }

    var path: String {
        switch self {
        case .login:
            return "/api/auth/login"
        case .register:
            return "/api/auth/register"
        case .me:
            return "/api/auth/me"

        case .getEvents:
            return "/api/events"
        case .getEventDetails(let id):
            return "/api/events/\(id)"
        case .getEventTypes:
            return "/api/events/types"

        case .registerForEvent:
            return "/api/registrations"
        case .cancelRegistration(let id):
            return "/api/registrations/\(id)"
        case .myEvents(let userId):
            return "/api/registrations/user/\(userId)"

        case .notifications:
            return "/api/notifications"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .login, .register, .registerForEvent:
            return .post
        case .cancelRegistration:
            return .delete
        default:
            return .get
        }
    }

    var headers: [String: String]? {
        nil
    }

    var requiresAuth: Bool {
        switch self {
        case .login, .register:
            return false
        default:
            return true
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .login(let email, let password):
            return ["email": email, "password": password]

        case .register(let email):
            return [
                "email": email,
                //TODO: რა ველებიც გჭირდება
            ]

        case .getEvents(let filters):
            return filters

        case .registerForEvent(let eventId, let userId):
            return [
                "eventId": eventId,
                "userId": userId
            ]

        default:
            return nil
        }
    }
}
