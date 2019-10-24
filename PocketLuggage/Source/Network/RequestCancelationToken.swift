//
//  RequestCancelationToken.swift
//  PocketLuggage
//
//  Created by Alexandre Quiblier on 01/08/2019.
//  Copyright © 2019 Alexandre Quiblier. All rights reserved.
//


import Foundation

/// Object defining lifecycle of a pending HTTP request.
/// The request associated with this instance will be cancelled when the instance gets deallocated.
public class RequestCancellationToken {

    // MARK: - Lifecycle

    public init() {}

    deinit {
        willDeallocate?()
    }

    // MARK: - Internal

    internal var willDeallocate: (() -> Void)?
}
