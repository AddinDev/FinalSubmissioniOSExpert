//
//  SearchView.swift
//  FinalSubmission
//
//  Created by addin on 02/04/21.
//

import SwiftUI
import SIECore
import Game

struct SearchView: View {
  
  @ObservedObject var presenter: SearchPresenter<
    GameModel,
    Interactor<
      String,
      [GameModel],
      SearchGameRepository<
        SearchGameRemoteDataSource,
        GameTransformer>>>
  
  var body: some View {
    ZStack {
      VStack {
        searchBar
        Group {
          if presenter.isLoading {
            loadingIndicator
          } else if presenter.isError {
            errorIndicator
          } else if presenter.list.isEmpty {
            emptyIndicator
          } else {
            content
          }
        }
      }
    }
  }
  
}

extension SearchView {
  
  var loadingIndicator: some View {
    VStack {
      Spacer()
      Text("Loading...")
      if #available(iOS 14.0, *) {
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle())
      } else {
        // Fallback on earlier versions
      }
      Spacer()
    }
  }
  
  var errorIndicator: some View {
    VStack {
      Spacer()
      Text(presenter.errorMessage)
      Spacer()
    }
  }
  
  var emptyIndicator: some View {
    VStack {
      Spacer()
      Text("Game Not Found")
      Spacer()
    }
  }
  
  var content: some View {
    ScrollView {
      if #available(iOS 14.0, *) {
        LazyVStack {
          ForEach(presenter.list) { game in
            linkBuilder(for: game) {
              GameRow(game: game)
            }
          }
        }
      } else {
        // Fallback on earlier versions
      }
    }
  }
  
  var searchBar: some View {
    HStack {
      TextField("Search Games", text: $presenter.keyword)
        .disableAutocorrection(true)
        .autocapitalization(.none)
        .padding(7)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .onTapGesture {
          withAnimation(.linear) {
            presenter.isSearching = true
          }
        }
      if presenter.isSearching {
        Button("Cancel") {
          presenter.keyword = ""
          withAnimation(.linear) {
            presenter.isSearching = false
          }
          UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
      }
    }
    .padding(.horizontal)
    .padding(.top)
    
  }
  
  func linkBuilder<Content: View>(
    for game: GameModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: SearchRouter().makeDetailView(for: game)
    ) { content() }
  }
  
}
