//
//  ApiModel.swift
//  createAPI
//
//  Created by albert Michael on 20/02/24.
//

import Foundation
import ObjectMapper

//Login Model
struct LoginViewModel: Mappable
{
    var response_code  : Int?
    var message : String?
    var statusFlag : Bool?
    var status  : String?
    var errorDetails : String?
    var loginData   : [LoginData]
    
    init?(map: Map)
    {
        loginData = []
    }
    
    mutating func mapping(map: Map) {
        
        response_code   <- map["response_code"]
        message    <- map["message"]
        statusFlag  <- map ["statusFlag"]
        status    <- map["status"]
        errorDetails  <- map ["errorDetails"]
        loginData <- map ["data"]
    }
    
}
struct LoginData: Mappable {
    
    var token  : String?
    var user : User?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
       
        token   <- map["token"]
        user <- map["user"]
        
    }
}

struct User: Mappable {
    
    var user_id : Int?
    var user_email : String?
    var user_name : String?
    var first_login : Bool?
    
    init?(map: Map)
    {
    }
    
    mutating func mapping(map: Map) {
        user_id      <- map["user_id"]
        user_email <- map["user_email"]
        first_login <- map ["first_login"]
        user_name <- map ["user_name"]
        
    }
    
}
