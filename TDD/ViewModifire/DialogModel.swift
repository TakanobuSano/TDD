//
//  DialogModel.swift
//  TDD
//
//  Created by 佐野貴信 on 2022/05/14.
//

import Foundation

public enum DialogType {
    case none
    case loading
}

class DialogModel: NSObject, ObservableObject {
    @Published var dialogType: DialogType = .none
}

