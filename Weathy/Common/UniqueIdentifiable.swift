//
//  UniqueIdentifiable.swift
//  Weathy
//
//  Created by Семен Семенов on 21.10.2020.
//

typealias UniqueIdentifier = String

// Протокол определяющий поведение объектов идентифицируемых уникально
protocol UniqueIdentifiable {
    var uid: UniqueIdentifier { get }
}
