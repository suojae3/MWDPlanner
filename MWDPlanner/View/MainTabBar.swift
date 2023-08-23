
import UIKit


class MainTabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let monthlyVC = MonthlyView()
        monthlyVC.tabBarItem = UITabBarItem(title: "Scene 1", image: nil,  tag: 0)
        
        let weeklyVC = WeeklyView()
        weeklyVC.tabBarItem = UITabBarItem(title: "Scene 2", image: nil, tag: 1)
        
        let dailyVC = DailyView()
        dailyVC.tabBarItem = UITabBarItem(title: "Scene 3", image: nil, tag: 2)
        
        self.viewControllers = [monthlyVC, weeklyVC, dailyVC]
        
    }
}
