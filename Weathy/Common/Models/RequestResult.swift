//
//  RequestResult.swift
//  Weathy
//
//  Created by Семен Семенов on 21.10.2020.
//

import Foundation

enum RequestResult<T> {
    case success(T)
    case failure(String)
}
