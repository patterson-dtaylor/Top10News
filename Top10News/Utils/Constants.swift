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

//MARK: - Storage
let STORAGE_REF = Storage.storage().reference()
let STORAGE_PROFILE_IMAGE = STORAGE_REF.child("profile_images")
