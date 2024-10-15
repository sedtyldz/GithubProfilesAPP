//
//  MainPage.swift
//  GithubProfiles
//
//  Created by Sedat Yıldız on 7.10.2024.
//

import SwiftUI
import Foundation

struct MainPage: View {
    @Binding var username:String
    @State var veriler: UserModel?
    @State var followers:String = ""
    @State var hal:Bool = false
    var body: some View {
        NavigationStack{
        ZStack {
            ContainerRelativeShape()
                .fill(LinearGradient(colors: [Color.white,Color.purple], startPoint: .topLeading, endPoint: .bottomTrailing))
                .ignoresSafeArea()
            
            VStack(spacing:30) {
                Text("Profile of \(username)")
                    .bold()
                    .font(.title)
                Spacer()
                    .frame(height:10)
                
                if let veri = veriler {
                    
                    AsyncImage(url: URL(string:veri.avatar_url)){ result in
                        result.image?.resizable()
                            .scaledToFit()
                            .frame(width: 200,height: 200)
                            .clipShape(.circle)
                        
                    }
                    if let veri = veriler {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Username: \(veri.login)")
                            Text("Name: \(veri.name ?? "No Name")")
                            Text("Bio: \(veri.bio ?? "No Bio")")
                            Text("Joining Date: \(veri.created_at)")
                            Text("Repository Count: \(veri.public_repos)")
                            Text("Followers Count: \(veri.followers)")
                            Text("Following Count: \(veri.following)")

                        }
                    }
                    
                    Button(action: {
                        hal = true
                        
                    })
                    {
                        Text("Show the Followers")
                            .font(.title)
                            .bold()
                            .padding(.vertical,10)
                            .padding(.horizontal,10)
                            .background(Color.blue)
                            .foregroundStyle(Color.white)
                            .cornerRadius(40)
                        
                    }
                    
                    
                }
                
                
                
            }
            
        }
        .navigationDestination(isPresented: $hal){
            followersPage(followers: $followers)
        }
    }
        .onAppear(perform:{
            fetchuserinfos(username: username)}
        )
                  
    }
    
    func fetchuserinfos(username:String){
        
        let urlString:String = "https://api.github.com/users/\(username)"
        
        guard let url  = URL(string: urlString) else{
            print("Hata url türüne çevirilemedi")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, response ,error in
            
            if let error = error {
                print("ERROR ! ")
                return
            }
            else if let data = data {
                print("DATA ALINDI ")
                
                // Parseleme
                
                do {
                    
                    let parsedData = try JSONDecoder().decode(UserModel.self, from:data)
                    DispatchQueue.main.async {
                        self.veriler = parsedData
                        followers = veriler?.login ?? " No Value"
                    }
                    
                }
                catch {
                    print("ERROR PARSELEME")
                }
                
                
                
                
                
            }
            
            
        }
        task.resume()
        
    }
}

#Preview {
    MainPage(username:.constant("deneme"), veriler: UserModel(
        login: "deneme",
                avatar_url: "",
                followers_url: "",
                name: "Deneme Kullanıcı",
                location: "Istanbul",
                bio: "Software Developer",
                public_repos: 42,
                followers: 10,
                following: 5,
                created_at: "2024-01-01"
    ))
}
    
