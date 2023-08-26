
import UIKit


class MainTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = .black
        
        let monthlyVC = MonthlyView()
        monthlyVC.tabBarItem = UITabBarItem(title: "Monthly",
            image: UIImage(systemName: "calendar"),  tag: 0)
        
        let weeklyVC = WeeklyView()
        weeklyVC.tabBarItem = UITabBarItem(title: "Weekly",
            image: UIImage(systemName: "calendar"),tag: 1)
        
        let dailyVC = DailyView()
        dailyVC.tabBarItem = UITabBarItem(title: "Daily",
            image: UIImage(systemName: "calendar"), tag: 2)
        
        self.viewControllers = [monthlyVC, weeklyVC, dailyVC]
        
    }
}
