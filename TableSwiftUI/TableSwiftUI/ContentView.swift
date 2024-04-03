//
//  ContentView.swift
//  TableSwiftUI
//
//  Created by Trevino, Katie on 4/1/24.
//

import SwiftUI
import MapKit

let data = [
   Item(name: "Mochas and Javas", neighborhood: "LBJ Drive", desc: "This coffee shop offers a nice and calm atmosphere to get some homework done or enjoy coffee with a friend.", lat: 29.891651917822784, long: -97.94064250589906, imageName: "rest1"),
   Item(name: "The Coffee Bar ", neighborhood: "Downtown San Marcos", desc: "Easily accessible downtown, if you ever have down time on campus, take a short walk to this coffee shop for a nice break.", lat: 29.885117920981415, long: -97.93993237216877, imageName: "rest2"),
   Item(name: "Jo’s Cafe", neighborhood: "Texas State Campus", desc: "Close to campus, this coffee shop offers both outdoor and indoor seating with delicious food options available for you and your classmates.", lat: 29.883917706896867, long: -97.94578547984807, imageName: "rest3"),
   Item(name: "The Native Blends", neighborhood: "The Square San Marcos", desc: "Off campus, just off of Wonder World, come to this cozy coffee shop and enjoy quiet vibes with relaxing music . ", lat: 29.88766837562289, long: -97.94015116863484, imageName: "rest4"),
   Item(name: "Tantra SMTX", neighborhood: "Hopkins", desc: "Right off campus, not too far enjoy live music and good vibes with this new and hip coffee shop.", lat: 29.8840809763216, long: -97.94405360311765, imageName: "rest5")
]
   struct Item: Identifiable {
       let id = UUID()
       let name: String
       let neighborhood: String
       let desc: String
       let lat: Double
       let long: Double
       let imageName: String
   }

struct ContentView: View {
    // add this at the top of the ContentView struct. In this case, you can choose the coordinates for the center of the map and Zoom levels
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 29.88882788149447, longitude: -97.94110517305747), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    var body: some View {
        NavigationView {
          VStack {
              List(data, id: \.name) { item in
                  NavigationLink(destination: DetailView(item: item)) {
                  HStack {
                      Image(item.imageName)
                          .resizable()
                          .frame(width: 50, height: 50)
                          .cornerRadius(10)
                  VStack(alignment: .leading) {
                          Text(item.name)
                              .font(.headline)
                          Text(item.neighborhood)
                              .font(.subheadline)
                      } // end internal VStack
                  } // end HStack
                  } // end NavigationLink
              } // end List
              //add this code in the ContentView within the main VStack.
                         Map(coordinateRegion: $region, annotationItems: data) { item in
                             MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                                 Image(systemName: "mappin.circle.fill")
                                     .foregroundColor(.red)
                                     .font(.title)
                                     .overlay(
                                         Text(item.name)
                                             .font(.subheadline)
                                             .foregroundColor(.red)
                                             .fixedSize(horizontal: true, vertical: false)
                                             .offset(y: 25)
                                     )
                             }
                         } // end map
                         .frame(height: 300)
                         .padding(.bottom, -30)
                         
          } // end VStack
          .listStyle(PlainListStyle())
                 .navigationTitle("San Marcos Coffee")
             } // end NavigationView
      } // end body

}

struct DetailView: View {
    // put this at the top of the DetailView struct to control the center and zoom of the map. It will use the item's coordinates as the center. You can adjust the Zoom level with the latitudeDelta and longitudeDelta properties
         @State private var region: MKCoordinateRegion
         
         init(item: Item) {
             self.item = item
             _region = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long), span: MKCoordinateSpan(latitudeDelta: 0.20, longitudeDelta: 0.20)))
         }
       let item: Item
               
       var body: some View {
           VStack {
               Image(item.imageName)
                   .resizable()
                   .aspectRatio(contentMode: .fill)
                   .frame(maxWidth: 200)
               Text("Neighborhood: \(item.neighborhood)")
                   .font(.subheadline)
               Text("Description: \(item.desc)")
                   .font(.subheadline)
                   .padding(10)
               // include this within the VStack of the DetailView struct, below the content. Reads items from data into the map. Be careful to close curly braces properly.

                  Map(coordinateRegion: $region, annotationItems: [item]) { item in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)) {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                            .overlay(
                                Text(item.name)
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .fixedSize(horizontal: true, vertical: false)
                                    .offset(y: 25)
                            )
                    }
                } // end Map
                    .frame(height: 300)
                    .padding(.bottom, -30)
                   } // end VStack
                    .navigationTitle(item.name)
                    Spacer()
        } // end body
     } // end DetailView

#Preview {
    ContentView()
}
