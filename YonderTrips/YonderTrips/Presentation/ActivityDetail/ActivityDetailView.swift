//
//  ActivityDetailView.swift
//  YonderTrips
//
//  Created by 임윤휘 on 6/18/25.
//

import SwiftUI

struct ActivityDetailView: View {
    
    @StateObject var activityDetailViewMdoel: ActivityDetailViewModel
    @StateObject var orderViewMdoel: OrderViewModel
    
    var body: some View {
        
        ScrollView {
            VStack(spacing: 10) {
                
                ZStack {
                    DataImageView(urlString: activityDetailViewMdoel.state.activity.imageThumbnail)
                        .frame(height: 500)
                        .frame(maxWidth: .infinity)
                        .background(.gray0)
                        .clipped()
                        .aspectRatio(contentMode: .fill)
                    
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color.gray15, location: 0.15),
                            .init(color: Color.clear, location: 0.65)
                        ]),
                        startPoint: .bottom,
                        endPoint: .top
                    )
                }
                
                VStack {
                    VStack(alignment: .leading, spacing: 24) {
                        activityDetailInfoView()
                        
                        restrictionInfoView()
                            .frame(maxWidth: .infinity)
                            .frame(alignment: .center)
                        
                        priceInfoView()
                        
                    }
                    .padding(20)
                    
                    
                    ActivityCurriculumView(items: activityDetailViewMdoel.state.activity.schedule)
                    
                    ActivityReservationListView(reservations: activityDetailViewMdoel.state.activity.reservationList,
                                                selectedItemName: $activityDetailViewMdoel.state.selectedItemName,
                                                selectedItemTime: $activityDetailViewMdoel.state.selectedItemTime)
                }
                .frame(width: 400)
                .padding(.top, -200)
            }
            .padding(.bottom, 150)
        }
        .background(.gray15)
        .ignoresSafeArea()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                FavoriteButtonView {
                    print("Keep")
                }
            }
        }
        .overlay {
            
            VStack {
                Spacer()
                paymentBottomView()
            }
            .frame(width: 400)
        }
        .toolbarBackground(.hidden, for: .navigationBar)
        .overlay {
            if orderViewMdoel.state.isPresentedPopup {
                
                if let errorMessage = orderViewMdoel.state.errorMessage {
                    PopupView(
                        title: errorMessage,
                        isPresented: $orderViewMdoel.state.isPresentedPopup
                    )
                } else if let successMessage = orderViewMdoel.state.successMessage {
                    PopupView(
                        title: successMessage,
                        isPresented: $orderViewMdoel.state.isPresentedPopup
                    )
                }
            }
        }
        .fullScreenCover(isPresented: $orderViewMdoel.state.isPresentedPaymentRequest) {
            
            if let orderCreate = orderViewMdoel.state.orderCreate {
                PaymentRequestView(orderCreate: orderCreate) { result in
                    orderViewMdoel.action(.didPaymentRequestFinish(result))
                }
            }
        }
    }
}

//MARK: - View
extension ActivityDetailView {
    
    func activityDetailInfoView() -> some View {
        
        VStack(alignment: .leading, spacing: 12) {
            Text(activityDetailViewMdoel.state.activity.title)
                .font(.yt(.paperlogy(.title1)))
                .foregroundStyle(.gray90)
            
            HStack(spacing: 12) {
                Text(activityDetailViewMdoel.state.activity.country)
                    .font(.yt(.pretendard(.body1)).weight(.bold))
                    .foregroundStyle(.gray60)
                PointRewardTextView(pointReward: activityDetailViewMdoel.state.activity.pointReward)
            }
            
            Text(activityDetailViewMdoel.state.activity.description)
            .font(.yt(.pretendard(.caption1)))
            .foregroundStyle(.gray60)
            .lineSpacing(6)
            
            HStack {
                activityTotalCountView(.buy, "누적 구매", activityDetailViewMdoel.state.activity.totalOrderCount)
                activityTotalCountView(.keepFill, "KEEP", activityDetailViewMdoel.state.activity.keepCount)
            }
        }
    }
    
    func activityTotalCountView(_ imageResource: ImageResource, _ title: String, _ count: Int) -> some View {
        
        HStack(spacing: 2) {
            Image(imageResource)
                .resizable()
                .frame(width: 16, height: 16)
            
            Text(title)
                .font(.yt(.pretendard(.body3)))
            
            Text("\(count)회")
                .font(.yt(.pretendard(.body3)))
        }
        .foregroundStyle(.gray45)
    }
    
    func restrictionInfoView() -> some View {
        
        HStack(spacing: 20) {
            restrictionInfoDetailView(.age, "연령 제한", "\(activityDetailViewMdoel.state.activity.restrictions?.minAge ?? 0)세")
            restrictionInfoDetailView(.height, "신장 제한", "\(activityDetailViewMdoel.state.activity.restrictions?.minHeight ?? 0)cm")
            restrictionInfoDetailView(.people, "최대 참가 인원", "\(activityDetailViewMdoel.state.activity.restrictions?.maxParticipants ?? 0)명")
        }
        .padding()
        .background(.gray0)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(.gray30, lineWidth: 0.6)
        }
    }
    
    func restrictionInfoDetailView(_ imageResource: ImageResource, _ title: String, _ value: String) -> some View {
        
        HStack {
            Image(imageResource)
                .resizable()
                .frame(width: 24, height: 24)
                .padding(8)
                .foregroundStyle(.gray60)
                .background(.gray15)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(title)
                    .foregroundStyle(.gray45)
                    .font(.yt(.pretendard(.caption2)))
                
                Text(value)
                    .foregroundStyle(.gray75)
                    .font(.yt(.pretendard(.body3)))
            }
        }
    }
    
    func priceInfoView() -> some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            Text("\(activityDetailViewMdoel.state.activity.price.original)원")
                .foregroundStyle(.gray45)
                .font(.yt(.paperlogy(.caption1)))
                .overlay {
                    HStack {
                        Image(.line)
                            .frame(height: 16)
                            .padding(.trailing, -25)
                            .foregroundStyle(.blackSeafoam)
                    }
                    .padding(.top, 13)
                }
            
            HStack(spacing: 8) {
                Text("판매가")
                    .foregroundStyle(.gray45)
                    .font(.yt(.paperlogy(.body1)))
                
                Text("\(activityDetailViewMdoel.state.activity.price.final)원")
                    .foregroundStyle(.gray75)
                    .font(.yt(.paperlogy(.body1)))
                
                Text("\(63)%")
                    .foregroundStyle(.blackSeafoam)
                    .font(.yt(.paperlogy(.body1)))
            }
        }
    }
    
    func paymentBottomView() -> some View {
        
        VStack(spacing: 0) {
            
            Divider()
            
            HStack {
                Text("\(activityDetailViewMdoel.state.activity.price.final)원")
                    .font(.yt(.pretendard(.title1)))
                    .foregroundColor(.gray90)
                
                Spacer()
                
                Button(action: handlePaymentButton) {
                    Text("결제하기")
                        .font(.yt(.pretendard(.title1)))
                        .foregroundColor(.gray0)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 30)
                        .background(.blackSeafoam)
                        .cornerRadius(6)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .background(.gray0)
            .disabled(activityDetailViewMdoel.state.selectedItemName == nil || activityDetailViewMdoel.state.selectedItemTime == nil)
        }
    }
}

//MARK: - Action
extension ActivityDetailView {
    
    func handlePaymentButton() {
        orderViewMdoel.action(
            .requestOrderCreate(
                id: activityDetailViewMdoel.state.activity.activityId,
                name: activityDetailViewMdoel.state.selectedItemName ?? "",
                time: activityDetailViewMdoel.state.selectedItemTime ?? "",
                participantCount: 1, // TODO: - 인원수 설정
                totalPrice: activityDetailViewMdoel.state.activity.price.final
            )
        )
    }
}
