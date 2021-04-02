//
//  Injection.swift
//  FinalSubmission
//
//  Created by addin on 02/04/21.
//

import UIKit
import Game
import SIECore

final class Injection: NSObject {
  
  func provideHome<U: UseCase>() -> U where U.Request == Any, U.Response == [GameModel] {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let locale = GetGameLocaleDataSource(realm: appDelegate.realm)
    let remote = GetGameRemoteDataSource(endpoint: EndPoints.Gets.games.url)
    
    let mapper = GameTransformer()
    
    let repository = GetGameRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
    
    return Interactor(repository: repository) as! U
  }
  
  func provideDetail<U: UseCase>() -> U where U.Request == String, U.Response == DetailModel {
    
    let remote = GetDetailRemoteDataSource(endpoint: Api.baseUrl)
    
    let mapper = DetailTransformer()
    
    let repository = GetDetailRepository(remoteDataSource: remote, mapper: mapper)
    
    return Interactor(repository: repository) as! U
  }
  
  func provideSearch<U: UseCase>() -> U where U.Request == String, U.Response == [GameModel] {
    
    let remote = SearchGameRemoteDataSource(endpoint: EndPoints.Gets.search.url)
    
    let mapper = GameTransformer()
    
    let repository = SearchGameRepository(remoteDataSource: remote, mapper: mapper)
    
    return Interactor(repository: repository) as! U
  }
  
  func provideFavourite<U: UseCase>() -> U where U.Request == Any, U.Response == [GameModel] {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let locale = GetFavouriteGameLocaleDataSource(realm: appDelegate.realm)
    
    let mapper = FavGameTransformer()
    
    let repository = GetFavouriteGameRepository(localeDataSource: locale, mapper: mapper)
    
    return Interactor(repository: repository) as! U
  }
  
  func provideAddFavourite<U: UseCase>() -> U where U.Request == GameModel, U.Response == Bool {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let locale = AddFavouriteGameLocaleDataSource(realm: appDelegate.realm)
    
    let mapper = AddFavGameTransformer()
    
    let repository = AddFavouriteGameRepository(localeDataSource: locale, mapper: mapper)
    
    return Interactor(repository: repository) as! U
  }
  
  func provideRemoveFavourite<U: UseCase>() -> U where U.Request == GameModel, U.Response == Bool {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let locale = AddFavouriteGameLocaleDataSource(realm: appDelegate.realm)
    
    let mapper = AddFavGameTransformer()
    
    let repository = RemoveFavouriteGameRepository(localeDataSource: locale, mapper: mapper)
    
    return Interactor(repository: repository) as! U
  }
  
}
