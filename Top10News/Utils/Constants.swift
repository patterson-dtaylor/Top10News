//
//  Constants.swift
//  Top10News
//
//  Created by Taylor Patterson on 7/25/20.
//  Copyright © 2020 Taylor Patterson. All rights reserved.
//

import UIKit
import Firebase

//MARK: - Fonts
let loraBold = "Lora-Bold"
let ralewayRegular = "Raleway-Regular"
let ralewayBold = "Raleway-Bold"

//MARK: - Colors

let grayText = "regularTextGray"
let blackText = "boldTextBlack"
let gradientBG = "gradientBackgorund"

//MARK: - Database
let DB_REF = Database.database().reference()
let REF_USERS = DB_REF.child("users")
let REF_BOOKMARKS = DB_REF.child("bookmarks")
let REF_USER_BOOKMARKS = DB_REF.child("user-bookmarks")

//MARK: - Storage
let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGE = STORAGE_REF.child("profile_images")

//MARK: - NewsAPI
let api = "https://newsapi.org/v2/top-headlines?pageSize=10&"
let apiKey = "&apiKey=d1d8db101735417ea95d216fc300339e"
let top10List = "https://newsapi.org/v2/top-headlines?pageSize=10&country=us\(apiKey)"
