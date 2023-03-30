//
//  ContentView.swift
//  ioscardexample
//
//  Created by vuslat coşkun on 27.03.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        Home()
            
        
    }
}

struct Oyun: Identifiable {
    var id: Int
    var name:String
    var image:String
    var rate: Int
}

var oyunVerileri = [
    Oyun(id: 0, name:"Resident Evil 1", image:"g1", rate: 3),
    Oyun(id: 1, name:"Resident Evil 2", image:"g2", rate: 3),
    Oyun(id: 2, name:"Resident Evil 3", image:"g3", rate: 3),
    Oyun(id: 3, name:"Resident Evil 4", image:"g4", rate: 3),
    Oyun(id: 4, name:"Resident Evil 5", image:"g5", rate: 3),
    Oyun(id: 5, name:"Resident Evil 6", image:"g6", rate: 3),
    Oyun(id: 5, name:"Resident Evil 7", image:"g7", rate: 3),
]

struct Home: View {
    @State var ara=""
    @State var index=0
    @State var columns = Array(repeating:GridItem(.flexible(),
                                                  spacing:15),
               count:2)
    var body: some View {
        
        ScrollView{
            LazyVStack {
                HStack {
                    Text("Oyun pazarı").font(.title).fontWeight(.bold)
                    Spacer()
                }.padding(.horizontal)
                TextField("ara",text:self.$ara)
                    .padding(.vertical,10).padding(.horizontal)
                    .background(Color.black.opacity(0.07))
                    .cornerRadius(10).padding(.horizontal).padding(.top,25)
                TabView(selection: self.$index){
                    ForEach(0...5,id:\.self){index in
                        Image("p\(index)").resizable()
                            .frame(height: self.index == index ? 230 : 180)
                            .cornerRadius(15).padding(.horizontal)
                            .tag(index)
                    }
                }.frame(height:230)
                    .padding(.top,25)
                    .tabViewStyle(PageTabViewStyle())
                    .animation(.easeOut)
                
                HStack{
                    Text("popüler").font(.title).fontWeight(.bold)
                    Spacer()
                    Button{
                        withAnimation{
                            if self.columns.count == 2 {
                                self.columns.removeLast()
                            }
                            else{
                                self.columns.append(GridItem(.flexible(),spacing:15))
                            }
                        }
                        
                    }label: {
                        Image(systemName: self.columns.count == 2 ? "rectangle.grid.1x2" : "square.grid.2x2")
                            .font(.system(size: 24)).foregroundColor(.black)
                    }
                }.padding(.horizontal).padding(.top,25)
                LazyVGrid(columns: columns, spacing: 25){
                    ForEach(oyunVerileri){oyun in
                        GridView(oyun: oyun, columns: self.$columns)
                    }
                }.padding([.horizontal, .top])
                
            
                }.padding(.vertical)
                
            }.background(Color.black.opacity(0.05).edgesIgnoringSafeArea(.all))
        }
        
    }

struct GridView : View {
    var oyun : Oyun
    @Binding var columns : [GridItem]
    @Namespace var namespace
    var body: some View{
        
        if self.columns.count == 2{
            VStack{
                ZStack(alignment: Alignment(horizontal: .trailing,
                                            vertical: .top)){
                    Image(oyun.image).resizable().frame(height: 250).cornerRadius(15)
                    Button{}label: {
                        Image(systemName: "heart").foregroundColor(.red).padding(.all,10).background(Color.white)
                            .clipShape(Circle())
                    }.padding(.all, 10)
                }.matchedGeometryEffect(id: "image", in: self.namespace)
                Text(oyun.name).fontWeight(.bold).lineLimit(1)
                    .matchedGeometryEffect(id: "image.name", in: self.namespace)
            }
        }
        else{
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
