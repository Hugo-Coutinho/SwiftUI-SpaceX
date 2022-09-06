//
//  HomeCompanySectionPresenterInput.swift
//  SpaceX
//
//  Created by hugo.coutinho on 16/12/21.
//  Copyright © 2021 . All rights reserved.
//

// MARK: - PRESENTER INPUT PROTOCOL -
public protocol HomeCompanySectionPresenterInput: AnyObject {

    // MARK: - VARIABLES -
    var output: HomeCompanySectionPresenterOutput? { get set }
    var input: HomeCompanySectionInteractorInput { get set }

    // MARK: - INPUT METHODS -
    func getInfo()
}

// MARK: - PRESENTER OUTPUT PROTOCOL -
public protocol HomeCompanySectionPresenterOutput: AnyObject {

    // MARK: - OUTPUT METHODS -
    func handleSuccess(domain: HomeCompanySectionDomain)
    func removeSection()
}


