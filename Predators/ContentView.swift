//
//  ContentView.swift
//  Predators
//
//  Created by Matko Mihalj on 13.11.2023..
//

import SwiftUI

struct ContentView: View {
    let apController = ApexController()
    @State var sortAlphabetical = false
    @State var currentFilter = "All"
    
    var body: some View {
        
        apController.filterBy(type: currentFilter)
        
        if sortAlphabetical{
            apController.sortByAlphabetical()
        } else {
            apController.sortByMovieAppearance()
        }
         return NavigationView {
            List{
                ForEach(apController.apexPredators) { predator in
                    NavigationLink(destination: PredatorDetail(predator: predator)) {
                        PredatorRow(predator: predator)
                    }
                }
            }
            .navigationTitle("Apex Predators")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        withAnimation {
                            sortAlphabetical.toggle()}
                    } label: {
                        if sortAlphabetical{
                            Image(systemName: "film")
                        } else {
                           Image(systemName: "textformat")
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Menu{
                        Picker("Filter",selection: $currentFilter.animation()){
                            ForEach(apController.typeFilters, id: \.self){ type in
                                HStack{
                                    Text(type)
                                    
                                    Spacer()
                                    
                                    Image(systemName: apController.typeIcon(for: type))
                                }
                                
                            }
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
