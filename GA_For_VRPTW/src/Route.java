import java.util.ArrayList;

/**
 * @author minasora
 * @date 2019/10/7 16:12
 * @description Route类，每一个route储存了一辆车所访问的顾客
 */
public class Route {
    ArrayList<Integer> cus_list = new ArrayList<>();// route列表

    double value;
    boolean if_feasible;
    boolean check()//检查可行性
    {
        return (check_c() && check_t());
    }
    boolean check_c()//容量检查
    {
        int ans = 0;
        for(int i:this.cus_list)
        {
            ans +=Conf.customers[i].demand;
        }

        return ans<Conf.Cap;

    }
    boolean check_t()//时间检查
    {
        double time = 0;
        time += Conf.dis_matriax[0][this.cus_list.get(0)];
        if(time>Conf.customers[cus_list.get(0)].d_time)return false;
        for(int i=1;i<=this.cus_list.size()-1;i++)
        {
            time = Math.max(Conf.customers[this.cus_list.get(i-1)].r_time,time+Conf.dis_matriax[this.cus_list.get(i-1)][this.cus_list.get(i)]);
            if(time > Conf.customers[cus_list.get(i)].d_time)return  false;
        }
        return true;


    }
    double getValue()//获得route的dis
    {
        this.value = 0;
        value += Conf.dis_matriax[0][cus_list.get(0)];//开始
        value += Conf.dis_matriax[0][cus_list.get(cus_list.size()-1)];
        if(cus_list.size()>1) {
            for (int i = 1; i < cus_list.size(); i++) {
                value += Conf.dis_matriax[cus_list.get(i)][cus_list.get(i - 1)];
            }
        }
        return value;
    }
}
