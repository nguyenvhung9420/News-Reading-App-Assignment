//
//  YourNewsView.swift
//  NewsApp
//
//  Created by Hung Nguyen on 13/3/21.
//

import SwiftUI

struct YourNewsView: View {
    var body: some View {
        VStack {
            Image("placeholder_1")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
            Text("Hung")
        }.padding()
        .navigationBarTitle(Text("Your news"))
    }
}

struct YourNewsView_Previews: PreviewProvider {
    static var previews: some View {
        YourNewsView()
    }
}
