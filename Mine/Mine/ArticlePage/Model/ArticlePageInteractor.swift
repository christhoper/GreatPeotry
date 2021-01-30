//
//  ArticlePageArticlePageInteractor.swift
//  BL_VIPer.xcodeproj
//
//  Created by jhd on 20/07/2020.
//  Copyright © 2020 jhd. All rights reserved.
//

// MARK: - Entity

class ArticlePageEntity {}

// MARK: - Interactor

class ArticlePageInteractor {

    weak var output: ArticlePageInteractorOutput?
}

extension ArticlePageInteractor: ArticlePageInteractorInput {}
