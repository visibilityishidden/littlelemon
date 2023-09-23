//
//  Menu.swift
//  Little Lemon
//
//  Created by Yaroslav Liashevych on 22.09.2023.
//

import SwiftUI

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var searchText = ""
    
    //    @FetchRequest(sortDescriptors: [])
    //    private var dishes: FetchedResults<Dish>
    
    var body: some View {
        VStack {
            //            Text("the title of your application at the top")
            //            Text("the restaurant location, like Chicago, below it")
            //            Text("the restaurant location, like Chicago, below it")
            VStack {
                Text("Little Lemon")
                    .foregroundColor(.yellow)
                    .fontWeight(.bold)
                    .font(.system(size: 32))
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text("Chicago")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    VStack {
                        Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                            .foregroundColor(.white)
                            .fontWeight(.medium)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Image("menuLogo")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(12)
                }
                TextField("Search menu", text: $searchText)
                    .textFieldStyle(OutlinedTextFieldStyle())
            }
            .padding()
            .background(.green)
            FetchedObjects(predicate: buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                List {
                    ForEach(dishes, id: \.self) { dish in
                        DishRow(dish: dish)
                    }
                }
            }
            //            List {
            //                 ForEach(dishes, id: \.self) { dish in
            //                     DishRow(dish: dish)
            //                 }
            //             }
        }
        .padding()
        .onAppear {
            getMenuData()
        }
    }
    
    func getMenuData() {
        //Clear the database
        PersistenceController.shared.clear()
        //viewContext.reset()
        
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(MenuList.self, from: data)
                    print(decodedData)
                    
                    for menuItem in decodedData.menu {
                        let dish = Dish(context: viewContext)
                        dish.title = menuItem.title
                        dish.image = menuItem.image
                        dish.price = menuItem.price
                        dish.mainDescription = menuItem.description
                    }
                    
                    // Save the changes to the database
                    try? viewContext.save()
                } catch {
                    print(String(describing: error))
                }
            }
        }
        
        //Start the URLSession data task
        task.resume()
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))
        return [sortDescriptor]
    }
    
    func buildPredicate() -> NSPredicate {
        if searchText.isEmpty {
            // Return a predicate to fetch all objects (no filtering)
            return NSPredicate(value: true)
        } else {
            // Return a predicate to filter objects based on title containing searchText
            return NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
}

struct DishRow: View {
    let dish: Dish

    var body: some View {
        HStack {
            Text("\(dish.title ?? "") - $\(dish.price ?? "")")
            
            Spacer()
            AsyncImage(url: URL(string: dish.image!)!) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                case .failure:
                    Image(systemName: "questionmark.diamond") // Placeholder image for failure
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                @unknown default:
                    EmptyView()
                }
            }
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
