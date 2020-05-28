//
//  Home.swift
//  CustomersCrud
//
//  Created by rkedlor on 5/27/20.
//  Copyright © 2020 rkedlor. All rights reserved.
//
import Firebase
import FirebaseFirestore
import SwiftUI
struct Rounded: Shape {
  func path(in rect: CGRect) -> Path {
    let path = UIBezierPath(roundedRect: rect,
                        byRoundingCorners: [.bottomLeft,.bottomRight],
                        cornerRadii:CGSize(width:25,height:25))
    return Path(path.cgPath)
  }
}
struct Home: View {
  @EnvironmentObject var store: Store
  @State var edit = false
  @State var show = false
  @State var saveAlert = false
  @State var selected: Customer = .init(id: "", firstName: "", lastName: "", email: "", phone: "")
  init(){
//    self.store.add(customer: Customer.init(id: "\(UUID())", firstName: "Julio", lastName: "Torres", email: "julio.torres", phone: "917"))
  }
  var body: some View {
    ZStack(alignment: .top){
      Button(action:{
        self.show.toggle()
      }){
        Image(systemName: "plus").resizable().frame(width: 25, height: 25).padding()
      }/**ButtonEnd**/
        .background(Color.red)
        .clipShape(Circle())
        .zIndex(2)
        .foregroundColor(Color("2"))
        .padding(.top,50)
        .sheet(isPresented:$show, content: {
          CustomerSave(customer: self.selected, show: self.$show,saveAlert: self.$saveAlert)
            .environmentObject(self.store)
        })
      /**ButtonStyleEnd**/
      VStack(spacing:25 ){
        VStack{
          HStack{
            Text("Customers Crud").font(.largeTitle).fontWeight(.heavy)
            Spacer()
            Button(action: {
              self.edit.toggle()
            }) {
              Text(self.edit ? "Done" : "Edit")
            }.font(.title)
          }/**HStackEnd**/
          .padding([.leading, .trailing], 15)
          .padding(.top, 25)
            .padding(.bottom,25)
          /**HStackStyleEnd**/

        }/**VStackEnd**/
          .background(Rounded().fill(Color.white))
          .edgesIgnoringSafeArea(.top)
        /**VStackStyleEnd**/
        ScrollView(.vertical,showsIndicators: false){
          VStack(spacing: 4) {
            Text("There are \(self.store.customers.count) Customers")
            ForEach(self.store.customers, id: \.id) { customer in
              CustomerCell(edit: self.edit,show: self.show, saveAlert: self.saveAlert, customer: customer)
//              Text("touchme")
//              .onLongPressGesture(perform: {
//                self.selected = customer
//                self.show.toggle()
//              })
            }.padding()
          }/**VStackEnd**/
            .frame(maxWidth: .infinity)
          .padding(.top,30)
        }/**ScrollViewEnd**/
      }

      }
    .background(
          LinearGradient(gradient: .init(colors: [Color("2"),Color("3")]),startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all)
    )
//      .navigationBarTitle("Customers List",displayMode: .inline)
//      .navigationBarItems(trailing: EditButton())
//      .background(NavigationConfigurator { nc in
//        nc.navigationBar.barTintColor = .clear
//          nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
//      })
      /**ZStackStyleEnd**/
//              .edgesIgnoringSafeArea(.all)
//    }
//    .navigationViewStyle(StackNavigationViewStyle())
  }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
struct CustomerSave: View {
  @State var customer: Customer = .init(id: "", firstName: "", lastName: "", email: "", phone: "")
  @Binding var show: Bool
  @EnvironmentObject var store: Store
  @Binding var saveAlert: Bool
  
  var body: some View {
//    ZStack(alignment: .top){
//              LinearGradient(gradient: .init(colors: [Color("2"),Color("3")]),startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all)
////         Color.red
//         VStack{
//             Text("Hello World")
//                 .font(.title)
//             Text("Another")
//                 .font(.body)
//         }
//     }
//            .background(
//              LinearGradient(gradient: .init(colors: [Color("2"),Color("3")]),startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all)
//          )
    ZStack(alignment: .top){
      LinearGradient(gradient: .init(colors: [Color("2"),Color("3")]),startPoint: .leading, endPoint: .trailing).edgesIgnoringSafeArea(.all)
      VStack (spacing:12){
        VStack {
          HStack{
            Button(action: {
              self.saveAlert.toggle()
            }) {
              Text("Save")
            }.alert(isPresented: self.$saveAlert){ () -> Alert in
              Alert(title: Text("Modifying"),message: Text("Are your sure?"),primaryButton: .default(Text("Ok"),action: {
                if self.customer.id != "" {
                  self.store.update(customer: self.customer)
                }
                else{
                  self.customer.id = UUID().uuidString
                  self.store.add(customer: self.customer)
                }
              self.show.toggle()
              }),secondaryButton: .default(Text("Dismiss"),action: {self.show.toggle()}))
            }
          }
        } // endHStack
        TextField("Firstname", text: self.$customer.firstName)
        TextField("Lastname", text: self.$customer.lastName)
        TextField("Email", text: self.$customer.email)
        TextField("Phone", text: self.$customer.phone)
        //      Divider()
      }.padding()
//        .frame(maxWidth: .infinity,maxHeight: .infinity)
    }
//      .onAppear{
//        self.customer = self.customer
//        self.title = self.data.title
//    }
  }
  
}

struct CustomerCell: View {
  var edit: Bool
  @State var show: Bool
  @State var saveAlert: Bool
  var customer: Customer
  @EnvironmentObject var store:Store
  var body: some View{
    HStack {
      if edit {
        Button(action:{
          if self.customer.id != "" {
            self.store.delete(customer:self.customer)
          }
        }){
          Image(systemName: "minus.circle").font(.title)
        }/**ButtonEnd**/
          .foregroundColor(.red)
        /**ButtonStyleEnd**/
      }
      Text("\(customer.lastName) \(customer.firstName)").lineLimit(1)
      Spacer()
      HStack(spacing: 5, content: {
        Text(customer.phone)
        if edit {
          Button(action:{
            if self.customer.id != "" {
            }
            self.show.toggle()
          }){
            Image(systemName: "pencil").font(.title)
          }/**ButtonEnd**/
            .foregroundColor(.blue)
            .sheet(isPresented:$show, content: {
              CustomerSave(customer: self.customer, show: self.$show,saveAlert: self.$saveAlert)
                .environmentObject(self.store)
            })
          /**ButtonStyleEnd**/
        }
      })
    }/**HStackEnd**/
      .padding()
      .background(RoundedRectangle(cornerRadius:25).fill(Color.white))
      .animation(.spring())
    /**HStackStyleEnd**/
  }
}

struct Customer: Identifiable {
  var id: String = UUID().uuidString
  var firstName,lastName,email,phone: String
  var dictionary: [String:Any]{
    return [
      "id":id,
      "firstName":firstName,
      "lastName":lastName,
      "email":email,
      "phone":phone
    ]
  }
}

class Store: ObservableObject {
  @Published var customers = [Customer]()
  private let collection = "Customers"
  init(){
    //here we fetch form firestore then bind to customers variable
    print("STORE INIT")
    do{
    print("STORE DO")
      
      try Firestore.firestore().collection(collection)
        .addSnapshotListener { querySnapshot, error in
          self.customers = [Customer]()
          guard let documents = querySnapshot?.documents else{
            print("Error fetching documents \(error)")
            return
          }
//          let ids = documents.map{$0["id"]}
          let ids = documents.map{$0["id"]}
          let firstNames = documents.map{$0["firstName"]}
          let lastNames = documents.map{$0["lastName"]}
          let emails = documents.map{$0["email"]}
          let phones = documents.map{$0["phone"]}
          for i in 0..<ids.count {
            print("STORE FOR")
            self.customers.append(Customer(
              id: documents[i].documentID ?? UUID().uuidString,
              firstName: firstNames[i] as! String,
              lastName: lastNames[i] as! String,
              email: emails[i] as! String,
              phone: phones[i] as! String))
          }
          
          
      }
        print("read")//firestore read all
//      self.customers.append(Customer.init(id: "", firstName: "", lastName: "", email: "", phone: ""))
    } catch {
      print("failed to read customers from firestore")
      print(error.localizedDescription)
    }
  }
  func add(customer: Customer){
    do{
      try Firestore.firestore().document("\(collection)/\(customer.id)")
        .setData(customer.dictionary)
      print("save")//firestore save
//      self.customers.append(Customer.init(id: "\(UUID())", firstName: customer.firstName, lastName: customer.lastName,email: customer.email, phone: customer.phone))
    } catch {
      print("failed to add to firestore")
      print(error.localizedDescription)
    }
  }
  func delete(customer:Customer){
    do{
      try Firestore.firestore().document("\(collection)/\(customer.id)").delete(completion: { err in
        if let err = err {
          print("failed to remove from firestore")
        } else {
          print("Deletion success ;c")
        }
      })
        print("delete")//firestore delete
//      for cust in customers {
//        if cust.id == customer.id {
//          customers.removeAll{
//            $0.id == cust.id
//          }
//        }
//      }
        
    } catch {
      print("failed to delete from firestore")
      print(error.localizedDescription)
    }
  }
  func update(customer:Customer){
    do{
      try Firestore.firestore().document("\(collection)/\(customer.id)")
        .setData(customer.dictionary,merge:true)
//      for cust in 0..<customers.count {
//        if customers[cust].id == customer.id{
//          self.customers[cust] = customerToDate
//        }
//      }
    } catch {
      print("failed to update from firestore")
      print(error.localizedDescription)
    }
  }
}


