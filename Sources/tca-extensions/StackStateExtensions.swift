//
//  StackState + Extensions.swift
//  tca-extensions
//
//  Created by Andrey Barsukov on 01.06.2025.
//

import ComposableArchitecture

// MARK: - SearchDirection

/// Defines the direction used when searching within a stack-like collection.
internal enum SearchDirection {
    
    // MARK: - Cases

    /// Indicates that the search should begin from the first element.
    case fromFirst

    /// Indicates that the search should begin from the last element.
    case fromLast
}

// MARK: - StackState + Useful

/// Provides utility methods for accessing the first or last occurrence of a specific
/// case within a `StackState` whose elements conform to `CasePathable`.
extension StackState where Element: CasePathable {
    
    // MARK: - First

    /// Returns the identifier of the first element matching the given case path.
    ///
    /// - Parameter path: A case path used to match a specific case within an enum.
    /// - Returns: The `StackElementID` of the first matching element, or `nil` if none is found.
    public func firstID<Case>(for path: CaseKeyPath<Element, Case>) -> StackElementID? {
        id(for: path, from: .fromFirst)
    }

    /// Returns the state of the first element matching the given case path.
    ///
    /// - Parameter path: A case path used to extract the associated case's value.
    /// - Returns: The associated value of the first matching element, or `nil` if none is found.
    public func firstState<Case>(for path: CaseKeyPath<Element, Case>) -> Case? {
        state(for: path, from: .fromFirst)
    }

    /// Returns both the ID and state of the first element matching the given case path.
    ///
    /// - Parameter path: A case path used to extract the associated case's value.
    /// - Returns: A tuple containing the ID and state of the first matching element,
    ///   or `nil` if none is found.
    public func firstItem<Case>(for path: CaseKeyPath<Element, Case>) -> (id: StackElementID, state: Case)? {
        item(for: path, from: .fromFirst)
    }
    
    // MARK: - Last

    /// Returns the identifier of the last element matching the given case path.
    ///
    /// - Parameter path: A case path used to match a specific case within an enum.
    /// - Returns: The `StackElementID` of the last matching element, or `nil` if none is found.
    public func lastID<Case>(for path: CaseKeyPath<Element, Case>) -> StackElementID? {
        id(for: path, from: .fromLast)
    }

    /// Returns the state of the last element matching the given case path.
    ///
    /// - Parameter path: A case path used to extract the associated case's value.
    /// - Returns: The associated value of the last matching element, or `nil` if none is found.
    public func lastState<Case>(for path: CaseKeyPath<Element, Case>) -> Case? {
        state(for: path, from: .fromLast)
    }

    /// Returns both the ID and state of the last element matching the given case path.
    ///
    /// - Parameter path: A case path used to extract the associated case's value.
    /// - Returns: A tuple containing the ID and state of the last matching element,
    ///   or `nil` if none is found.
    public func lastItem<Case>(for path: CaseKeyPath<Element, Case>) -> (id: StackElementID, state: Case)? {
        item(for: path, from: .fromLast)
    }
    
    // MARK: - Private

    /// Searches for the ID of an element matching the given case path, starting from the
    /// specified direction.
    ///
    /// - Parameters:
    ///   - path: The case path to match.
    ///   - direction: The direction from which to start the search.
    /// - Returns: The `StackElementID` of the matching element, or `nil` if none is found.
    private func id<Case>(
        for path: CaseKeyPath<Element, Case>,
        from direction: SearchDirection
    ) -> StackElementID? {
        switch direction {
        case .fromFirst:
            return ids.first(where: { self[id: $0, case: path] != nil })
        case .fromLast:
            return ids.last(where: { self[id: $0, case: path] != nil })
        }
    }

    /// Returns a tuple of ID and state for the first or last matching element,
    /// depending on the direction.
    ///
    /// - Parameters:
    ///   - path: The case path to match.
    ///   - direction: The direction from which to start the search.
    /// - Returns: A tuple of `(id, state)` or `nil` if no match is found.
    private func item<Case>(
        for path: CaseKeyPath<Element, Case>,
        from direction: SearchDirection
    ) -> (id: StackElementID, state: Case)? {
        guard let id = id(for: path, from: direction),
              let state = self[id: id, case: path] else {
            return nil
        }
        return (id: id, state: state)
    }

    /// Returns the state of the first or last matching element, depending on the direction.
    ///
    /// - Parameters:
    ///   - path: The case path to match.
    ///   - direction: The direction from which to start the search.
    /// - Returns: The associated state value, or `nil` if not found.
    private func state<Case>(
        for path: CaseKeyPath<Element, Case>,
        from direction: SearchDirection
    ) -> Case? {
        item(for: path, from: direction)?.state
    }
}
