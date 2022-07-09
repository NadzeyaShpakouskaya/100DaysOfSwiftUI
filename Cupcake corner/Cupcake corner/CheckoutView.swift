//
//  CheckoutView.swift
//  Cupcake corner
//
//  Created by Nadzeya Shpakouskaya on 20/06/2022.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var alertMessage = ""
    @State private var alertTitle = ""
    @State private var showingAlert = false

    var body: some View {
        ZStack{
            Color.gray.opacity(0.2).ignoresSafeArea()
            VStack {
                orderInfoView.padding()
                Spacer()
                placeOrderButton
                
            }.padding(.bottom, 20)
                .navigationTitle("Check out")
                .navigationBarTitleDisplayMode(.inline)
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("OK") {}
                } message: {
                    Text(alertMessage)
                }
        }
    }
    
    var placeOrderButton: some View {
        Button {
            Task {
                await placeOrder()
            }
        } label: {
            Text("Place order")
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .font(.title2.bold().italic())
                .foregroundColor(.white)
                .background(.green)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.white, lineWidth: 4).shadow(color: .green, radius: 5, x: 0, y: 0))
        }
    }
    
    var orderInfoView: some View {
        ZStack {
            Color.green.opacity(0.25)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            ScrollView{
                VStack {
                    headerImageView
                        .accessibilityElement()
                    Text("Order information")
                        .font(.title2.bold().italic())
                    VStack(alignment: .leading){
                        
                        Divider()
                        VStack(alignment: .leading) {
                            Text("\(order.newOrder.quantity) x \(Order.types[order.newOrder.type].lowercased()) cupcakes")
                                .bold()
                            if order.newOrder.extraFrosting {
                                Text("Add extra frosting").font(.subheadline.italic())
                            }
                            if order.newOrder.addSprinkles {
                                Text("Add more sprinkles").font(.subheadline.italic())
                            }
                        }
                        Divider()
                        HStack(alignment: .firstTextBaseline, spacing: 10) {
                            VStack(alignment: .leading) {
                                Text("Delivery for: ")
                                Text("Address: ").font(.subheadline)
                            }.font(.subheadline)
                            VStack(alignment: .leading) {
                                Text("\(order.newOrder.name)")
                                Text("\(order.newOrder.address), \(order.newOrder.city), \(order.newOrder.zipCode)")
                            }.font(.headline)
                        }
                        
                        Divider()
                    }.padding(.horizontal, 20)
                    Spacer()
                    Spacer()
                    Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                        .font(.title.bold()).multilineTextAlignment(.leading)
                    Spacer()
                    
                    
                }.padding(.vertical, 20)
            }
        }
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 10).shadow(color: .gray, radius: 4, x: 0, y: 0))
        
    }
    
    var headerImageView: some View {
        AsyncImage(
            url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(.white, lineWidth: 5))
        
    }
    
    
    func placeOrder() async {
        // prepare data to send
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Error: couldn't encode the order ")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            // handle response
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            alertMessage = confirmationOrderInformation(for: decodedOrder.newOrder)
            alertTitle = "Your order is on its way!"
            showingAlert = true
            
        } catch {
            print("Error: Couldn't upload data to server")
            alertMessage = "Something went wrong.\nTry one more time. "
            alertTitle = "Error"
            showingAlert = true
            
        }
        
    }
    
    private func confirmationOrderInformation(for order: OrderModel) -> String {
        """
        
        Order details:
        
        \(order.quantity) x \(Order.types[order.type].lowercased()) cupcakes
        \(order.extraFrosting ? "✔︎ extra frosting" : "")
        \(order.addSprinkles ? "✔︎ more sprinkles" : "")
        """
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
