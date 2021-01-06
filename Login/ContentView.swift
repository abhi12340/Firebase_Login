//
//  ContentView.swift
//  Login
//
//  Created by Abhishek Kumar on 05/01/21.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View {
    @State var show = false
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    var body: some View {
        NavigationView {
            VStack {
                if self.status {
                    HomeScreen()
                } else {
                    ZStack {
                        NavigationLink(destination: SignUp(show: self.$show), isActive: self.$show) {
                            Text("")
                        }.hidden()
                        Login(show: self.$show)
                    }
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .onAppear{
                NotificationCenter.default.addObserver(forName: NSNotification.Name("status"), object: nil, queue: .main) { (_) in
                    self.status =  UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                }
            }
        }
    }
}


struct HomeScreen : View {
    var body: some View {
        VStack {
            Text("Logged Sucessfully")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.black.opacity(0.7))
            
            Button {
                do {
                    try Auth.auth().signOut()
                    UserDefaults.standard.setValue(false, forKey: "status")
                    NotificationCenter.default.post(name:Notification.Name("status"), object: nil )
                } catch {
                    print("Log out falied")
                }
            
            } label: {
                Text("Logout")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            }
            .background(Color(red: 255 / 255, green: 165 / 255, blue: 0 / 255))
            .cornerRadius(10)
            .padding(.top, 25)
        }
    }
}
