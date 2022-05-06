//
//  DateModel.swift
//  TDD
//
//  Created by 佐野貴信 on 2022/04/29.
//

import Foundation

protocol DateProtocol {
    func now() -> Date
}

struct DateModel: DateProtocol {
    func now() -> Date {
        return Date()
    }
}
