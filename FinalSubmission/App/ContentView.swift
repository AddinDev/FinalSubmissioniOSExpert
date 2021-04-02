//
//  ContentView.swift
//  FinalSubmission
//
//  Created by addin on 02/04/21.
//

import SwiftUI
import SIECore
import Game

struct ContentView: View {
  
  @EnvironmentObject var homePresenter: GetListPresenter<
    Any,
    GameModel,
    Interactor<
      Any,
      [GameModel],
      GetGameRepository<
        GetGameLocaleDataSource,
        GetGameRemoteDataSource,
        GameTransformer>>>
  
  @EnvironmentObject var searchPresenter: SearchPresenter<
    GameModel,
    Interactor<
      String,
      [GameModel],
      SearchGameRepository<
        SearchGameRemoteDataSource,
        GameTransformer>>>
  
  @EnvironmentObject var favouritePresenter: GetListPresenter<
    Any,
    GameModel,
    Interactor<
      Any,
      [GameModel],
      GetFavouriteGameRepository<
        GetFavouriteGameLocaleDataSource,
        FavGameTransformer>>>
  
  @State var selected = 0
  
  var body: some View {
    NavigationView {
      if #available(iOS 14.0, *) {
        TabView(selection: $selected) {
          HomeView(presenter: homePresenter)
            .tabItem {
              VStack {
                Text("Home")
                Image(systemName: "house")
              }
            }.tag(0)
          
          FavouriteView(presenter: favouritePresenter)
            .tabItem {
              VStack {
                Text("Favourite")
                Image(systemName: "heart")
              }
            }.tag(1)
          
          SearchView(presenter: searchPresenter)
            .tabItem {
              VStack {
                Text("Search")
                Image(systemName: "magnifyingglass")
              }
            }.tag(2)
        }
        .navigationBarTitle(title, displayMode: .inline)
        .navigationBarItems(trailing: profileButton)
      } else {
        // Fallback on earlier versions
      }
    }
  }
  
}

extension ContentView {
  
  private var title: String {
    switch selected {
    case 0:
      return "Home"
    case 1:
      return "Favourite"
    case 2:
      return "Search"
    default:
      return "Game App"
    }
  }
  
  var profileButton: some View {
    NavigationLink(destination: ProfileView()) {
      Image(systemName: "person.circle")
    }
  }
  
}
