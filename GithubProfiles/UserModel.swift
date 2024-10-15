//
//  UserModel.swift
//  GithubProfiles
//
//  Created by Sedat Yıldız on 13.10.2024.
//

import Foundation


struct UserModel: Codable {
    let login: String
    let avatar_url: String
    let followers_url: String
    let name: String?
    let location: String?
    let bio: String?
    let public_repos: Int
    let followers: Int
    let following: Int
    let created_at: String
}



