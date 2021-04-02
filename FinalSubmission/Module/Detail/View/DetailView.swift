//
//  DetailView.swift
//  FinalSubmission
//
//  Created by addin on 02/04/21.
//

import SwiftUI
import SDWebImageSwiftUI
import SIECore
import Game

struct DetailView: View {
  
  @ObservedObject var presenter: GetDetailPresenter<
    Interactor<
      String,
      DetailModel,
      GetDetailRepository<
        GetDetailRemoteDataSource,
        DetailTransformer>>,
    Interactor<
      GameModel,
      Bool,
      AddFavouriteGameRepository<
        AddFavouriteGameLocaleDataSource,
        AddFavGameTransformer>>,
    Interactor<
      GameModel,
      Bool,
      RemoveFavouriteGameRepository<
        AddFavouriteGameLocaleDataSource,
        AddFavGameTransformer>>>
  
  var game: GameModel
  
  var body: some View {
    if #available(iOS 14.0, *) {
      ZStack {
        if presenter.isLoading {
          loadingIndicator
        } else if presenter.isError {
          errorIndicator
        } else {
          content
        }
      }
      .onAppear {
        presenter.getDetail(request: game.id)
      }
      .navigationBarTitle(game.title, displayMode: .inline)
      .navigationBarItems(trailing: favButton)
    } else {
      // Fallback on earlier versions
    }
  }
  
}

extension DetailView {
  
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      if #available(iOS 14.0, *) {
        ProgressView()
          .progressViewStyle(CircularProgressViewStyle())
      } else {
        // Fallback on earlier versions
      }
    }
  }
  
  var errorIndicator: some View {
    VStack {
      Text(presenter.errorMessage)
    }
  }
  
  var image: some View {
    WebImage(url: URL(string: game.image))
      .resizable()
      .indicator(.activity)
      .transition(.fade)
      .frame(height: 200)
      .aspectRatio(contentMode: .fit)
  }
  
  var desc: some View {
    VStack {
      HStack {
        Spacer()
        VStack {
          Text("Released")
            .foregroundColor(.gray)
          Text(presenter.detail?.released ?? "")
        }
        Spacer()
        VStack {
          Text("Rating")
            .foregroundColor(.gray)
          HStack {
            Image(systemName: "star.fill")
              .foregroundColor(.yellow)
              .padding(0)
            Text(presenter.detail?.rating ?? "")
          }
        }
        Spacer()
      }
      .padding([.horizontal, .top])
      
      Text(presenter.detail?.desc ?? "")
        .padding()
    }
  }
  
  var content: some View {
    ScrollView {
      VStack {
        image
        desc
      }
    }
  }
  
  var favButton: some View {
    Button(action: {
      presenter.changeFav {
        presenter.addFavourite(request: game)
      } remove: {
        presenter.removeFavourite(request: game)
      }
      
    }, label: {
      Image(systemName: presenter.isFav ? "heart.fill" : "heart")
    })
  }
  
}
