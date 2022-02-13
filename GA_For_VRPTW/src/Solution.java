import java.util.ArrayList;

/**
 * @author minasora
 * @date 2019/10/7 16:16
 * @description Solution类，构成了问题的一个解,提供了转到chromosome的函数
 */
public class Solution {
    ArrayList<Route> rou_list = new ArrayList<>();
    double fitness; // 适应度

    double getFitness()
    {
        this.fitness = 0;
        for(Route route:rou_list) {
            route.getValue();
            this.fitness += route.value;

        }
        return this.fitness;
    }
    Chromosome tochromosome()//把solution转化为chromosome
    {
        Chromosome chromosome = new Chromosome();
        for(Route route :rou_list)
        {
            chromosome.cur_list.addAll(route.cus_list);
        }
        return chromosome;
    }
    void print()//输出解
    {
        int  i = 1;
        for(Route route :this.rou_list)
        {
            System.out.print("Route "+ i + ": 0-");
            for (int j : route.cus_list)
            {

                System.out.print(j + "-");
            }
            System.out.print("0");
            System.out.print("可行性检验："+route.check()+" ");
            System.out.print(route.value);
            System.out.println();
            i++;
        }
        System.out.println("该解的目标函数值为" + this.getFitness());
    }

}
