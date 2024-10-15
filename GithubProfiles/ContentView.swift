//
//  ContentView.swift
//  GithubProfiles
//
//  Created by Sedat Yıldız on 7.10.2024.
//

import SwiftUI

struct ContentView: View {
    @State var username:String = ""
    @State var durum : Bool = false
    var body: some View {
        NavigationStack {
        ZStack{
            ContainerRelativeShape()
                .fill(LinearGradient(colors: [Color.white,Color.pink], startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            
            VStack{
                VStack{
                    Spacer()
                        .frame(height: 50)
                    Text("GitHub Profiles")
                        .font(.title)
                        .bold()
                        .foregroundStyle(Color.pink)
                        .padding()
                    
                    
                    Image("GitHub")
                        .resizable()
                        .scaledToFit()
                        .frame(width:350)
                    
                }
                Spacer()
                    .frame(height:200)
                
                VStack{
                    
                    TextField("Enter a username", text: $username)
                        .bold()
                        .font(.title2)
                        .padding(.vertical,20)
                        .padding(.horizontal,20)
                        .background(Color.white)
                        .cornerRadius(50)
                        .padding()
                        .autocorrectionDisabled(true)
                        .autocapitalization(.none)
                    
                    Spacer()
                        .frame(height: 30)
                    
                    
                    Button(action:{
                        durum  = true
                        
                    }){
                        Text("Search")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(Color.white)
                            .padding(.vertical,20)
                            .padding(.horizontal,20)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                        
                    }
                    
                    Spacer()
                }
                
                
                
            }
            
        }
        .navigationDestination(isPresented: $durum){
            MainPage(username: $username)
        }
        
    }
        
        
        
    }
}

#Preview {
    ContentView()
}
