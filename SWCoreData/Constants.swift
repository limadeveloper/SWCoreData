//
//  Constants.swift
//  SWCoreData
//
//  Created by John Lima on 18/09/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

typealias DictionaryType = Dictionary<String,AnyObject>
typealias ArrayType = [Dictionary<String,AnyObject>]

enum Messages: String {
    case DataNoFound = "Dados não foram encontrados."
}

enum Key: String {
    case Login = "KEY_LOGIN"
}

enum UI: String {
    case Main = "Main"
}

enum Identity: String {
    case Login = "Login"
    case Home = "Home"
}

enum JsonName: String {
    case User = "user"
}
