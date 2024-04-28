//
//  QuoteViewModel.swift
//  Monthly Planner
//
//  Created by Charlotte Varnum on 4/27/24.
//

import Foundation

class QuoteViewModel : ObservableObject {
   
    @Published var Quote = ""
    private let url = "https://api.api-ninjas.com/v1/quotes?category=happiness"
   
    func fetchData() {
        DispatchQueue.main.async {
            if let url = URL(string: self.url) {
                var request = URLRequest(url: url)
                request.setValue("Mx6lTAM05aLqdqyYZ1ATBA==MHeNu9k6HFgHlIJB", forHTTPHeaderField: "X-Api-Key")
                URLSession
                    .shared
                    .dataTask(with: request) { (quotes, reponse, error) in
                        if let error = error {
                            print(error)
                        }
                        else {
                            if let quotes = quotes {
                                
                                do {
                                    let results = try JSONDecoder().decode([QuotesModel].self, from: quotes)

                                    self.Quote = results[0].quote
                                    
                                } catch {
                                    
                                    print(error)
                                }
                            }
                        }
                    }.resume()
            }
        }
    }
}
