//
//  Constants.swift
//  SWCoreData
//
//  Created by John Lima on 18/09/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

enum Messages: String {
    case DataNoFound = "Dados não foram encontrados."
    case Alert = "Alerta"
    case Ok = "Ok"
    case CheckFields = "Verifique os campos"
    case Saved = "Dados salvos com sucesso"
    case SaveError = "Ocorreu um erro ao tentar salvar os dados"
    case Success = "Sucesso"
}

enum Key: String {
    case Login = "KEY_LOGIN"
    case User = "KEY_USER_ID"
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

enum Segue: String {
    case User = "user"
}
