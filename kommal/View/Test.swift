//
//  Test.swift
//  kommal
//
//  Created by hailah alsaudi on 29/06/1446 AH.
//


import SwiftUI

// MARK: - Main Splash View
struct Test: View {
    @StateObject var vm = vmtest()
    var body: some View {
        VStack{
            ZStack{
                VStack{
                    Text("\(vm.testt.count)")
                    ForEach(vm.testt.indices, id:\.self){
                        index in
                        Text(vm.testt[index].testinfo)
                    }
                }
            }.onAppear{
                vm.fetchLearners()
            }
        }
        
    }}
#Preview {
    Test()
}
