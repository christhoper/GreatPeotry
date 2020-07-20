//
//  ArticlePageArticlePageProtocols.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 BaiLun. All rights reserved.
//

// MARK: - ModuleProtocol

/**
 *  methods for communication OuterSide -> ArticlePage
 *  define the capabilities of ArticlePage
 */
protocol ArticlePageModuleInput: class {}

/**
 *  methods for communication ArticlePage -> OuterSide
 *  tell the caller what is changed
 */
protocol ArticlePageModuleOutput: class {}

// MARK: - SceneProtocol

/// methods for communication Presenter -> View
protocol ArticlePageViewInput: class {}

/// methods for communication View -> Presenter
protocol ArticlePageViewOutput {}

/// methods for communication Presenter -> Interactor
protocol ArticlePageInteractorInput {}

/// methods for communication Interactor -> Presenter
protocol ArticlePageInteractorOutput: class {}
