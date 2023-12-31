//
//  WebServiceResult.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 28/06/23.
//

import Foundation

/// Typealias used to simplify the completion handler that will return the result of the request.
typealias RequestCompletion<Response: Decodable> = (WebServiceResult<Response>) -> Void

// MARK: - WebServiceResult

/// The possible results after peforming a network call.
enum WebServiceResult<Response: Decodable> {

    /// Result when the request returns a valid response.
    case success(response: Response)

    /// Result when the request fails returning a valid response.
    case failure(error: NSError)
}
