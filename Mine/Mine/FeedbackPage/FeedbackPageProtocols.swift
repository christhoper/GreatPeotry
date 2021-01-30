//
//  FeedbackPageFeedbackPageProtocols.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

// MARK: - ModuleProtocol

/**
 *  methods for communication OuterSide -> FeedbackPage
 *  define the capabilities of FeedbackPage
 */
protocol FeedbackPageModuleInput: class {}

/**
 *  methods for communication FeedbackPage -> OuterSide
 *  tell the caller what is changed
 */
protocol FeedbackPageModuleOutput: class {}

// MARK: - SceneProtocol

/// methods for communication Presenter -> View
protocol FeedbackPageViewInput: class {}

/// methods for communication View -> Presenter
protocol FeedbackPageViewOutput {}

/// methods for communication Presenter -> Interactor
protocol FeedbackPageInteractorInput {}

/// methods for communication Interactor -> Presenter
protocol FeedbackPageInteractorOutput: class {}
