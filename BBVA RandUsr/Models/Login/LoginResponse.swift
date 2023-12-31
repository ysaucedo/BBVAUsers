//
//  LoginResponse.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 28/06/23.
//

import Foundation

struct LoginResponse: Codable {
    
    let success: Bool?
    
    enum CodingKeys: String, CodingKey {
        case success
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
    }
    
}
