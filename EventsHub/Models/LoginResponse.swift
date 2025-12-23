//
//  LoginResponse.swift
//  EventsHub
//
//  Created by Tatarella on 22.12.25.
//


struct LoginResponse: Decodable {
    let token: String
    let userId: Int
    let fullName: String
    let role: String
}
