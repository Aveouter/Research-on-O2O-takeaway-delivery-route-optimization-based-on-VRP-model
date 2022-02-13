/**
 * @author minasora
 * @date 2019/10/7 16:14
 * @description Customer类，储存了顾客的信息
 */
public class Customer {
    int x;
    int y;
    int demand;
    int r_time;//开始时间
    int d_time;//结束时间
    int s_time;//服务时间
}
abstract class Customer_Strategy
{
    public static double dis(Customer a,Customer b)
    {
        return Math.sqrt((a.x-b.x)*(a.x-b.x) + (a.y-b.y)*(a.y-b.y));//返回两个顾客的欧式距离
    }
}
