//
//  CustomerList.swift
//  CustomersCrud
//
//  Created by rkedlor on 5/27/20.
//  Copyright © 2020 rkedlor. All rights reserved.
//

import SwiftUI

struct CustomerList: View {
  @State var customers : Array<Any>
    var body: some View {
//          VStack(spacing: 30) {
//            Text("You're going to flip a coin – do you want to choose heads or tails?")
//
//            NavigationLink(destination: Text("Heads")) {
//              Text("Choose Heads")
//            }
//
//            NavigationLink(destination: Text("Tails")) {
//              Text("Choose Tails")
//            }
//          }
//          .navigationBarTitle("Navigation")
//        }.edgesIgnoringSafeArea(.all)
        List{
          CustomerRow(firstName: "name", lastName: "xd")
        }
//        .navigationBarTitle("Title",displayMode: .inline)
//        .navigationBarItems(leading: EditButton())
    }
}
