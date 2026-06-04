import SwiftUI

struct TabNavigation: View {
    @Binding var selectedTab: TabSelection
 

    
    var body: some View {
        NavigationStack {
            VStack {
                Group {
                    switch selectedTab {
                    case .home:
                        HomeView()
                            
                    case .profile:
                        ProfileView()
                  

                    case .statistics:
                        StatisticsView()
                        

                    }
                }
                .frame(maxHeight: .infinity)
                
                CustomTabBarView(selectedTab: $selectedTab)

            }
           
            
        }
    }
}

#Preview {
    NavigationStack {
        TabNavigation(selectedTab: .constant(.home))
    }
}
