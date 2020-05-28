//
//  CustomerRow.swift
//  CustomersCrud
//
//  Created by rkedlor on 5/27/20.
//  Copyright © 2020 rkedlor. All rights reserved.
//

import SwiftUI

struct CustomerRow: View {
  @State var firstName : String
  @State var lastName : String
  @State var data = [1,2,3,4,5]
  var body: some View {
//        Text("\(lastName), \(firstName)")
//    return VStack(alignment: .center, spacing: 22, content: {
//      List {
        ForEach(data, id: \.self) { a in
//          Text("\(a)")
          NavigationLink(destination: Text("\(a)")){
            Text("hi \(a)")
          }
          //          .navigationBarTitle("Navigation")
          //        }.edgesIgnoringSafeArea(.all)
        }.onDelete(perform: {index in
          
          print("\(index)")
//          self.data.remove(atOffsets:index)
        })
//      }.navigationBarItems(leading: EditButton())
//    })
  }
}
