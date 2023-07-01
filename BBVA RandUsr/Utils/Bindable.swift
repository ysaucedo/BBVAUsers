//
//  Bindable.swift
//  BBVA RandUsr
//
//  Created by Yair Saucedo on 29/06/23.
//

import Foundation

// MARK: - Observer Typealias

typealias Listener<Observable> = ((Observable?) -> Void)

// MARK: - Bindable

final class Observable<Object> {
    
    // MARK: - Properties
    
    var value: Object? {
        didSet {
            listener?(value)
        }
    }
    
    private var listener: Listener<Object>?
    
    // MARK: - Initializer
    
    init(_ value: Object?) {
        self.value = value
    }
    
    // MARK: - Methods
    
    func bindTo(listener: @escaping Listener<Object>) {
        listener(value)
        self.listener = listener
    }
}
