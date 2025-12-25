//
//  EventAPI.swift
//  EventsHub
//
//  Created by Tatarella on 20.12.25.
//
import Foundation

enum EventAPI {
    case login(email: String, password: String)
    case register(firstName: String, lastName: String, email: String, mobileNumber: String, departmentId: Int, password: String, confirmPassword: String)
    case departments

    case getEvents(filters: [String: Any]?)
    case getTrendingEvents
    case getEventDetails(id: Int)
    case getEventTypes

    case checkRegistrationon(eventId: Int)
    case registerForEvent(eventId: Int, userId: Int)
    case cancelRegistration(eventId: Int)
    case myEvents

    case notifications
}

extension EventAPI: Endpoint {
    
    var baseURL: URL {
        guard let url = URL(string: "http://63.182.53.107:5000") else {  /* TODO: API-ის ჩაისვას */
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
        case .departments:
            return "/api/departments"

        case .getEvents:
            return "/api/events"
        case .getTrendingEvents:
            return "/api/events/trending"
        case .getEventDetails(let id):
            return "/api/events/\(id)"
        case .getEventTypes:
            return "/api/events/types"

        case .checkRegistrationon(let id):
            return "/api/registrations/event/\(id)/status"
        case .registerForEvent:
            return "/api/registrations"
        case .cancelRegistration(let eventId):
            return "/api/registrations/event/\(eventId)/cancel"
        case .myEvents:
            return "/api/registrations/user/me"

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
            case .login, .register, .getTrendingEvents, .getEventTypes, .getEvents:
            return false
        default:
            return true
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .login(let email, let password):
            return ["email": email, "password": password]

        case .register(let firstName, let lastName, let email, let mobileNumber, let departmentId, let password, let confirmPassword):
            return [
                "firstName": firstName,
                "lastName": lastName,
                "email": email,
                "mobileNumber": mobileNumber,
                "departmentId": departmentId,
                "password": password,
                "confirmPassword": confirmPassword
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
