//
//  AgendaSection.swift
//  EventsHub
//
//  Created by Tatarella on 21.12.25.
//
import SwiftUI

//struct AgendaSection: View {
//
//    let items: [AgendaItem]
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//
//            Text("Agenda")
//                .font(.system(size: 18))
//                .foregroundStyle(.gray900)
//
//            ForEach(items.indices, id: \.self) { index in
//                let item = items[index]
//                let isLast = index == items.indices.last
//
//                HStack(alignment: .top, spacing: 12) {
//
//                    VStack {
//                        ZStack {
//                            Circle()
//                                .fill(.gray300.opacity(0.2))
//                                .frame(width: 28, height: 28)
//
//                            Text("\(item.order)")
//                                .font(.system(size: 12))
//                        }
//
//                        if !isLast {
//                            Rectangle()
//                                .fill(.gray300.opacity(0.2))
//                                .frame(width: 1)
//                                .frame(maxHeight: .infinity)
//                        }
//                    }
//
//                    VStack(alignment: .leading, spacing: 4) {
//                        Text(item.title)
//                            .font(.system(size: 14))
//                            .foregroundColor(.gray900)
//
//                        Text(item.description)
//                            .font(.system(size: 14))
//                            .foregroundColor(.gray300)
//                    }
//                }
//                .frame(minHeight: isLast ? 10 : 70)
//            }
//        }
//        .padding(.horizontal)
//    }
//}
