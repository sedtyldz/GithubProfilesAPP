//
//  followersPage.swift
//  GithubProfiles
//
//  Created by Sedat Yıldız on 14.10.2024.
//



import SwiftUI
import Foundation

struct followersPage: View {
    @Binding var followers: String
    @State var followerlist: [String] = []
    @State var avatarurl: [String] = []
    @State var final: [(key: String, value: String)] = []

    var body: some View {
        VStack {
            Text(followers)
                .bold()
                .font(.title)
                .foregroundStyle(.cyan)
            ScrollView {
                VStack {
                    ForEach(final, id: \.key) { item in
                        HStack(spacing: 20) {
                            Text(item.key)
                            Spacer()
                            AsyncImage(url: URL(string: item.value)) { result in
                                result.image?
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .padding()
            }
            Spacer()
        }
        .onAppear {
            getFollowers(for: followers)
        }
    }

    struct Follower: Codable {
        let login: String
        let avatar_url: String
    }

    func getFollowers(for username: String) {
        let urlString = "https://api.github.com/users/\(username)/followers"
        
        guard let url = URL(string: urlString) else {
            print("Url hatası")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("error follower fetching : \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("veri alınamadı.")
                return
            }
            
            do {
                print("data var")
                
                let followers = try JSONDecoder().decode([Follower].self, from: data)
                
                DispatchQueue.main.async {
                    self.followerlist = followers.map { $0.login }
                    self.avatarurl = followers.map { $0.avatar_url }
                    
                    self.fetcher(array1: followerlist, array2: avatarurl)
                }
            } catch {
                print("Başarısız decode: \(error.localizedDescription)")
            }
        }
        
        task.resume()
    }
    
    func fetcher(array1: [String], array2: [String]) {
        self.final = zip(array1, array2).map { (key: $0, value: $1) }
    }
}


#Preview {
    followersPage(followers: .constant("sedtyldz"))
}
